Data Scripts
============

This repo is for scripts I used while studying the encoding of multiview video using the JVT's JMVC reference software.

These scripts expect log files to be located at ./streams/logs/${trialid}/stream${streamid}.log. They store formatted tables in ./plotting/${trialid}/.

The format\_data.sh script takes a file output directly from an encoding of a video stream with the reference software
and transforms it into readable columns containing the picture viewing order, frame type, Y PSNR value, size in bits, and whether it is a reference view.

The plot.gpp script uses files generated by format\_data.sh and plots the frame vs size and frame vs PSNR, labeling each point
with the frame type. It accepts the encode version and the first and last stream numbers as arguments,
i.e. `gnuplot -e "ver=3; start=0; end=7; title='Encode Trial 1';" plot.gpp`

The aggr\_plot.gpp script uses the same data files. For each stream in a trial, it plots the frame vs size or frame vs PSNR of the stream, plus all of its dependencies, and the total size or average PSNR of the stream and its dependencies. It also summarizes, as a bar chart, the total size or average PSNR of an entire stream, in comparison to the entire stream plus all frames it depends on, in comparison to the entire stream plus the entire stream it depends on. This script accepts the version and a dependency configuration file as arguments, i.e.
`gnuplot -e "ver=3; depfile='deps3'; title='Encode Trial 3';" aggr_plot.gpp`
It assumpes that the dependency file is organized with in ascending order and takes starting and ending streams from the file. The  dependency file looks something like:

```
0:2
1:2 0
3:2
4:5
6:5 7
7:5
```

You can also manually specify which stream to start and end on the same way you specified it in plot.gpp.

The gnuplot scripts were tested using gnuplot 4.6.
