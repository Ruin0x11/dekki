# Kaisuu

Create tab-separated Japanese word lists ordered by frequency for importing into Anki from text files.

## Usage

After installing the gem, run:

```
kaisuu FILES > list.txt
```

You can input multiple files.

The order of the fields in the output is as follows:

* Kanji
* Kana
* Reading
* Context (first sentence word was found in)
* Frequency (times word was seen)
* Source (first file word was found in)

Set your model's sort value to the frequency column.

Import the file into Anki. Make sure that the 'Allow HTML in fields' box is checked.

Suspend all the cards. Many will have missing or incorrect readings/meanings (mostly loan words in katakana), but usually the important words that use kanji are left.

Unsuspend only the cards you want to study.

## Notes

Rough around the edges, since there are many false positives. Intended for learning new words that use kanji. Use at your own risk.

Will probably have to manually install ruby-jdict (fork) for it to work. Requires 'JMDict' dictionary in the `~/.dicts` folder.
