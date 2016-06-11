# Dekki

Quickly create Anki flashcards out of Japanese text.

Turns sequential lines of Japanese text, like this:

```
世の中に不満があるなら自分を変えろ。
それが嫌なら耳と眼を閉じ口を噤んで孤独に暮らせ。
それも嫌なら…
```

...into cards like this:

![example](https://raw.githubusercontent.com/Ruin0x11/dekki/master/img/example.png)

## Requirements

* mecab
* mecab-ipadic

## Installation

Install the above requirements, then do:

```
gem install dekki
```

If the dictionary hasn't been downloaded, you will be prompted to do so on the first run.

## Usage

```
dekki [-ik] [-c LINES] [-o FILE] INPUT
```

You can input one or more files or read from stdin.

By default, the cards are printed on stdout. You can pipe them to a file or use the `-o` flag to specify a file to write to. Note that with the `-o` flag, the file is overwritten.

To create a single wordlist per file, use the `-i` flag. This will write one word list file per file passed in, each with the original file's name in the word list's name.

By default, cards that are missing the kana or meaning fields are ignored. This can happen if the dictionary fails to find an entry for a separated word. To keep these cards anyway, use the `-k` flag.

The `-c` flag controls how many lines of context before and after the sentence the word is found in are kept.

The order of the fields in the output is as follows:

* Kanji
* Kana
* Meaning
* Before (sentences before sentence word was in)
* Context (first sentence word was found in)
* After (sentences after sentence word was in)
* Frequency (times word was seen)
* Position (line number word was first seen on)
* Source (first file word was found in)

To my knowledge, JMDict entries always contain kana, but might not contain kanji, so cards without kanji will have the kana field copied there.

Once you have the wordlist, import the file into Anki. Make sure that the 'Allow HTML in fields' box is checked.

Many cards will have to be suspended, if they were parsed incorrectly. Just press `!` while reviewing to suspend the current note.

## Notes

Rough around the edges, since there are many false positives. May also be inefficient for large files. Use at your own risk.
