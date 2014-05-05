#!/bin/bash

STREAMS="1 2 3 4"

# Frames/Viewing Order vs Size in Bits
for i in $STREAMS
do
  for j in `seq 0 7`
  do
    echo "#Frame Type  Viewing Order  PSNR(Y)  Size" > plotting/${i}/stream${j}.dat
    sed 's/              / ... ........ /' streams/logs/${i}/stream${j}.log | sed 's/          / ........ /' | sed 's/     / ... /' | awk '/ViewCodingOrder/{flag=1; next} /^$/{flag=0} flag { if ($4 == "REF_VIEW") printf "%-12s %-14s %-8s %-14s %-8s\n", $2, $5, $9, $18, $4; else printf "%-12s %-14s %-8s %-14s\n", $2, $5, $9, $18; }' | sort -nk 2 >> plotting/${i}/stream${j}.dat;
  done
done
