# Kaisuu

Create tab-separated Japanese word lists ordered by frequency for importing into Anki from text files.

## Usage

Place the 'JMDict' dictionary in the `~/.dicts` folder before using.

After installing the gem, run:

```
kaisuu FILES > list.txt
```

You can input multiple files.

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

Set your model's sort value to the frequency column.

Import the file into Anki. Make sure that the 'Allow HTML in fields' box is checked.

Suspend all the cards. Many will have missing or incorrect readings/meanings (mostly loan words in katakana), but usually the important words that use kanji are left.

Unsuspend only the cards you want to study.

## Notes

Rough around the edges, since there are many false positives. Intended for learning new words that use kanji. Use at your own risk.

Will probably have to manually install ruby-jdict (my own fork) for it to work.
