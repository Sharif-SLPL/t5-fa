# t5-fa
T5 Model for Farsi.

## How to use

## Training
The process of training is briefly as follows - generally from [transformers examples](https://github.com/huggingface/transformers/tree/main/examples/flax/language-modeling):

We demonstrate how to train a T5 model using the span-masked language model objective as proposed in the [Exploring the Limits of Transfer Learning with a Unified Text-to-Text Transformer](https://arxiv.org/abs/1910.10683). More specifically, we demonstrate how JAX/Flax can be leveraged to pre-train [**`google/t5-v1_1-base`**](https://huggingface.co/google/t5-v1_1-base) in Farsi on a single GPU (NVIDIA GeForce RTX 3060) for ? hours.

Let's start by creating a model repository to save the trained model and logs.
Here we call the model `"norwegian-t5-base"`, but you can change the model name as you like.

The default values will save the model in `t5-farsi/` relative to the repository directory.

### Training the tokenizer
In the first step, we train a tokenizer to efficiently process the text input for the model. We make use of the [tokenizers](https://github.com/huggingface/tokenizers) library to train a sentencepiece unigram tokenizer as shown in `t5_tokenizer_model.py` which is heavily inspired from [yandex-research/DeDLOC's tokenizer model](https://github.com/yandex-research/DeDLOC/blob/5c994bc64e573702a9a79add3ecd68b38f14b548/sahajbert/tokenizer/tokenizer_model.py) .

The tokenizer is going to be trained on the complete Persian dataset of our [datasets](#Datasets) and consequently saved in the cloned model directory. The process of training the tokenizer is provided in `t5_tokenizer_train.py`.

You can simply run it by the below command if you wanted to use OSCAR dataset:
```bash
python t5_tokenizer_train.py
```
or the alternative one if you wanted to use your own `.txt` file:
```bash
python t5_tokenizer_train.py [TRAIN_TEXT_FILE] [CACHE_DIR]
```

### Creating configuration
Next, we create the model's configuration file. This is as simple as loading and storing [`**google/t5-v1_1-base**`](https://huggingface.co/google/t5-v1_1-base) in the local model folder. You can simply run the code by
```bash
python t5_config.py
```

### Training the model

Next we can run the example script to pretrain the model. For this section you may need to run the `train.sh` file by:
```bash
bash train.sh
```

\[Our result (accuracy and losss) should come here.\]

## Materials
### Datasets

### Preprocess
For more details check out [here](https://github.com/Sharif-SLPL/t5-fa/tree/main/preprocess).
