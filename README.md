# Kaisuu

Create tab-separated Japanese word lists ordered by frequency for importing into Anki from text files.

## Installation

```
gem build kaisuu && gem install kaisuu-0.1.0.gem
```

Place the 'JMDict' dictionary in the `~/.dicts` folder before using.

## Usage

```
kaisuu [-ik] [-c LINES] FILES
```

You can input multiple files. To create a single wordlist per file, use the `-i` flag.

By default, cards that are missing all the required fields are ignored. This can happen if the dictionary fails to find an entry for a separated word. To keep these cards anyway, use the `-k` flag.

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

Once you have the wordlists, import the file into Anki. Make sure that the 'Allow HTML in fields' box is checked.

Many cards will have to be suspended, if they were detected incorrectly. Just press `!` while reviewing to suspend the current note.

## Notes

Rough around the edges, since there are many false positives. Intended for learning new words that use kanji. Use at your own risk.

Will probably have to manually install ruby-jdict (my own fork) for it to work.
