#   This file uses shuffles the input file and split train/test set
#   Use it like below:
#       bash train-test-split.sh [fname].txt [TRAIN_RATIO]
#   and it will make two file named [fname]_train.txt and [fname]_test.txt
#   Note: the TRAIN_RATIO should be between 0 and 1.
#   =========================================================================
TRAIN_RATIO=$2
fname=$(echo "$1" | cut -f 1 -d '.')


echo "Calculating # of lines..."
FILE_SIZE=$(cat $1 | wc -l)
echo "# of line in $1 = $FILE_SIZE"

TRAIN_SIZE=$(echo "$FILE_SIZE * $TRAIN_RATIO" | bc)
TRAIN_SIZE=${TRAIN_SIZE%.*}
echo "# of line in ${fname}_train.txt = $TRAIN_SIZE"

TEST_SIZE=$(echo "$FILE_SIZE - $TRAIN_SIZE" | bc)
echo "# of line in ${fname}_test.txt = $TEST_SIZE"

# Using the file for constant random seeding (avoding parallel streams):
shuf --random-source=$1 $1 | head -n ${TRAIN_SIZE} > ${fname}_train.txt &
shuf --random-source=$1 $1 | tail -n +$(echo "$TRAIN_SIZE + 1" | bc) > ${fname}_test.txt


# Using parallel streams (stdout consumer):
# mkfifo train_pipe.fq test_pipe.fq
# shuf $1 | tee train_pipe.fq | tee test_pipe.fq & \
# head -n ${TRAIN_SIZE} < train_pipe.fq > ${fname}_train.txt & \
# tail -n +$(echo "$TRAIN_SIZE + 1" | bc) < test_pipe.fq > ${fname}_test.txt
#rm train_pipe.fq test_pipe.fq

echo "Done."
