# Preprocess
This directory contains files related to the preprocessing phase. Brief explanation for each them are as follows:

## `filter.sh`
This file is simply the heart of our preprocessing process. Instead of trimming the raw texts we made a bash script which only allows wanted character to be passed. By this approach we decrease both the time and memory consumed in this process since it uses `sed` it deals with the input file as a stream so it's much faster than loading the file into the memory. It roughly can preprocess each 1 GB of data in a minute.

### Usage
```bash
bash filter.sh raw.txt
```

### Steps

#### Filtering non-Farsi words
In this process we just let "proper" words to be passed, the "proper" words are defined as follows:
+ All 32 characters of Farsi
+ Some Arabic characters which are ubiquitous in Farsi (like: `ۀ`, `ﺀ`, `ﻱ`, `ۆ`, `ۇ`, `ێ`)
+ Some symbolic characters (like `.`, `?`, `-`, `,` and their Farsi version)
+ `<200c>` which is half-space in Farsi

__TO_BE_CONTINUED__
