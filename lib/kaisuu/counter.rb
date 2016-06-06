require 've'

module My
  class Word
    attr_accessor :name, :example, :file, :count

    def initialize(name, example, file)
      @count = 1
      @name = name
      @example = example
      @file = file
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
    def count(text, filename)
      # words = split_to_words(text)
      words = Ve.in(:ja).words(text)
      words = words.select { |word| NECESSARY_POS.include?(word.part_of_speech) }
      count_up_result(words, text, filename)
      self
    end

    # 単語数をカウント
    def count_up_result(words, text, filename)
      words.each do |word|
        if @result[word.lemma]
          @result[word.lemma].count += 1
        else
          @result[word.lemma] = My::Word.new(word.lemma, text.strip, filename)
        end
      end
    end

    def sort
      @result.sort_by { |_key, value| value.count }
    end
  end
end
