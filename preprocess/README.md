# Preprocess
This directory contains files related to the preprocessing phase. Brief explanation for each them are as follows:

## `filter.sh`
This file is simply the heart of our preprocessing process. Instead of trimming the raw texts we made a bash script which only allows wanted character to be passed. By this approach we decrease both the time and memory consumed in this process since it uses `sed` it deals with the input file as a stream so it's much faster than loading the file into the memory. It roughly can preprocess each 1 GB of data in a minute. It's tested on Ubuntu 20.04. You may need some changes if you wanted to run it from Google Colab.

### Usage
```bash
bash filter.sh < raw.txt > clean.txt
```
You can also directly clean your data before downloading it by `curl` as follows:
```bash
curl -s -N [LINK_TO_TXT] | bash filter > clean.txt
```

### Steps

#### Filtering Non-Farsi Words
In this process we just let "proper" words to be passed, the "proper" words are defined as follows:
+ All 32 characters of Farsi
+ Some Arabic characters which are ubiquitous in Farsi (like: `ۀ`, `ﺀ`, `ﻱ`, `ۆ`, `ۇ`, `ێ`)
+ Some symbolic characters (like `.`, `?`, `-`, `,` and their Farsi version)
+ `<200c>` which is half-space in Farsi

#### Unifying Arabic/Farsi Characters
In farsi there are lots of texts which uses different shapes of characters for a specefic one in Farsi although they are inherently the same. So in this step we replace the less frequent characters with their alternative as follows:

+ `ێ` and `ﻱ` --> `ﯼ`
+ `ۀ` and `ﺓ` --> `ﻩ`
+ `ﻙ` --> `ک`
+ `ﺇ` --> `ا`
+ `ڒ` --> `ر`
+ `ۆ` --> `و`

#### Unifying Spaces
After all of these preprocesses it'd be better if we unify all spaces with one.

#### Removing Empty Lines
There could be several lines that became empty after these steps. So in this step we will remove empty lines.

#### Removing Short Lines
There is a variable called `MIN_NUMBER_OF_TOKENS` in this file which controls the minimum number of words (splited by space) in each line. In the final step we remove lines with less than `MIN_NUMBER_OF_TOKENS` words.
