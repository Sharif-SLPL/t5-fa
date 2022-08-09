#   This file uses `sed` to filter non-proper characters in a streamin manner.
#   Use it like below:
#       bash filter.sh < raw.txt > clean.txt
#   =========================================================================
MIN_NUMBER_OF_TOKENS=5

#   filter non-farsi characters:
sed 's/[^<200c>ۀﺀ-ﻍ ﻑ-ﻱ ًھکﮒﮋﭙﭼۆۇێەﯼ!.,?؟!،]/ /g' - | \

#   unify characters:
sed 's/[ﻱ­ێ]/ﯼ/g' - | \
sed 's/[ۀﺓ]/ﻩ/g' - | \
sed 's/[ﻙ]/ﮎ/g' - | \
sed 's/[ﺇ]/ﺍ/g' - | \
sed 's/[ڒ]/ﺭ/g' - | \
sed 's/[ۆ]/ﻭ/g' - | \

#   unifiy spaces to a space:
sed 's/  */ /g' - | \

#   remove empty lines:
sed -r '/^\s*$/d' - | \

awk "NF>=${MIN_NUMBER_OF_TOKENS}"
