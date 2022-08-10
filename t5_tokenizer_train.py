#!/usr/bin/env python
import sys
import os
from datasets import load_dataset
from pathlib import Path


from t5_tokenizer_model import SentencePieceUnigramTokenizer


vocab_size = 100_000
input_sentence_size = None


# Initialize a dataset - from text file
if len(sys.argv) > 2:
  print("Loading from text...")
  TRAIN_FILE = sys.argv[1]
  CACHE_DIR = sys.argv[2]

  data_files = {}
  ds_name = Path(TRAIN_FILE).stem
  Path(os.path.join(CACHE_DIR, ds_name)).mkdir(exist_ok=True, parents=True)
  
  data_files["train"] = TRAIN_FILE
  assert TRAIN_FILE.split(".")[-1] == "txt"
  
  dataset = load_dataset(
    "text",
    data_files=data_files,
    cache_dir=CACHE_DIR,
    split="train")


# Initialize a dataset - from Huggingface/Datasets
else:
  print("Loading from huggingface/datasets...")
  dataset = datasets.load_dataset(
    "oscar",
    name="unshuffled_deduplicated_fa",
    split="train")

tokenizer = SentencePieceUnigramTokenizer(
  unk_token="<unk>",
  eos_token="</s>",
  pad_token="<pad>")


# Build an iterator over this dataset
def batch_iterator(input_sentence_size=None):
    if input_sentence_size is None:
        input_sentence_size = len(dataset)
    batch_length = 100
    for i in range(0, input_sentence_size, batch_length):
        yield dataset[i: i + batch_length]["text"]


# Train tokenizer
tokenizer.train_from_iterator(
    iterator=batch_iterator(input_sentence_size=input_sentence_size),
    vocab_size=vocab_size,
    show_progress=True,
)

# Save files to disk
tokenizer.save("./t5-farsi/tokenizer.json")
