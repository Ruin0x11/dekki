# -*- coding: utf-8 -*-
require 've'
require 'set'

module My
  class Word
    attr_accessor :name, :raw, :example, :file, :lineno, :count

    def initialize(name, raw, example, file, lineno)
      @count = 1
      @name = name
      @raw = raw
      @example = example
      @file = Set.new
      @file.add(file)
      @lineno = lineno
    end

    def sources
      @file.to_a.join("; ")
    end
  end

  class WordCounter
    # MECAB = '/usr/local/bin/mecab'
    # NECESSARY_FEATURE = %w/名詞,固有名詞 名詞,一般 名詞,副詞可能 名詞,サ変接続 動詞.*五段/
    # UNNECESSARY_FEATURE = %w/名詞,数 名詞,接尾/
    NECESSARY_POS = [Ve::PartOfSpeech::Noun,
      Ve::PartOfSpeech::Verb,
      Ve::PartOfSpeech::Adjective,
      Ve::PartOfSpeech::Adverb]

    def initialize
      @result = Hash.new
    end

    attr_reader :result

    # mainループ
    def count(text, filename, lineno)
      # words = split_to_words(text)
      words = Ve.in(:ja).words(text)
      words = words.select { |word| NECESSARY_POS.include?(word.part_of_speech) }
      count_up_result(words, text, filename, lineno)
      self
    end

    # 単語数をカウント
    def count_up_result(words, text, filename, lineno)
      warn "No words found in #{text}" if words.empty? && !text.strip.empty?
      words.each do |word|
        if @result[word.lemma]
          @result[word.lemma].count += 1
          @result[word.lemma].file.add(filename)
        else
          @result[word.lemma] = My::Word.new(word.lemma, word.tokens[0][:lemma], text.strip, filename, lineno)
        end
      end
    end

    def sort
      @result.sort_by { |_key, value| value.count }
    end
  end

  class CardMaker
    def initialize
      @counter = My::WordCounter.new
      @dict = JDict::JMDict.new
    end

    def kanji_for_entry(entry)
      unless entry.kanji.empty?
        if entry.kanji.is_a?(Array)
          entry.kanji.join(', ')
        else
          entry.kanji
        end
      end
    end

    def kana_for_entry(entry)
      entry.kana.join(', ') unless entry.kana.nil?
    end

    def sense_for_entry(entry)
      if entry.senses.size > 1
        sense = entry.senses.map.with_index(1) do |sense, _|
          sense_to_s(sense)
        end
        sense.reverse.join("<br>")
      else
        sense = entry.senses.first
        sense_to_s(sense)
      end
    end

    def sense_to_s(sense)
      pos = sense.parts_of_speech.nil? ? '' : '(' + sense.parts_of_speech.join(', ') + ') '
      glosses = sense.glosses.join(', ')
      pos + glosses
    end

    def get_sentences(txt, index, num)
      first = index - num
      last = index + num

      first = 0 if first < 0

      before = txt[first..index-1].join("<br>") unless first == index
      current = txt[index]
      after = txt[index+1..last].join("<br>") unless index == last

      "#{before}\t#{current}\t#{after}"
    end

    def generate_cards(filename, keep_incomplete = false, individual_decks = false, context_sentences = 2)
      txt = File.readlines(filename).map(&:strip)
      txt.each_with_index { |line, index| @counter.count(line, filename, index) }

      cards = []
      # cards << "Kanji\tKana\tMeaning\tBefore\tContext\tAfter\tFrequency\tPosition\tSource"

      @counter.sort.each do |_token, word|
        # since the lemmas of Words like "1話" become "*話", remove extra '*'s
        lemma = word.name.tr('*', '')

        # raw token, drops "する" and other extra parts
        query = word.raw
        query = lemma if query == '*'

        if query
          results = @dict.search(query, true)
          entry = results.first
        end

        #TODO: Handle katakana gracefully?

        kanji = query if query
        sense = ""
        kana = ""

        if entry
          kanji = kanji_for_entry(entry)
          kana = kana_for_entry(entry)
          sense = sense_for_entry(entry)
        end

        context = get_sentences(txt, word.lineno, context_sentences)

        if (kanji && kana && sense) || keep_incomplete
          cards << "#{kanji}\t#{kana}\t#{sense}\t#{context}\t#{word.count}\t#{word.lineno}\t#{word.sources}"
        end
      end
      @counter = My::WordCounter.new if individual_decks

      cards
    end
  end
end
