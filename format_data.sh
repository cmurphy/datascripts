#!/usr/bin/env bash

# This script must be run before either the plot.gpp or aggr_plot.gpp scripts are run.

# Assumes there is a ./streams/logs accessible from wherever this script is run
LOG_DIR=streams/logs

# Run this script like (for example):
#   ./format_data.sh 1 2 3 4 5 6 7
# to format data from trials 1 through 7
STREAMS="$@"

# Frames/Viewing Order vs Size in Bits
for i in $STREAMS
do
  mkdir -p plotting/${i}
  for j in `seq 0 7`      # Assumes 8 streams
  do
    echo "#Frame Type  Viewing Order  PSNR(Y)  Size" > plotting/${i}/stream${j}.dat
    sed 's/              / ... ........ /' ${LOG_DIR}/${i}/stream${j}.log | sed 's/          / ........ /' | sed 's/     / ... /' | awk '/ViewCodingOrder/{flag=1; next} /^$/{flag=0} flag { if ($4 == "REF_VIEW") printf "%-12s %-14s %-8s %-14s %-8s\n", $2, $5, $9, $18, $4; else printf "%-12s %-14s %-8s %-14s\n", $2, $5, $9, $18; }' | sort -nk 2 >> plotting/${i}/stream${j}.dat;
  done
done
