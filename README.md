# Kaisuu

Create tab-separated Japanese word lists ordered by frequency for importing into Anki from text files.

## Usage

After installing the gem, run:

```
kaisuu FILES > list.txt
```

Import the file into Anki and suspend all the cards. Many will have incorrect readings/meanings (mostly loan words in katakana), but usually the important ones are left.

Set your model's sort value to the frequency column. Unsuspend only the cards you want to study.

## Notes

Rough around the edges, since there are many false positives. Use at your own risk.

Will probably have to manually install ruby-jdict (fork) for it to work. Requires 'JMDict' dictionary in the `~/.dicts` folder.
