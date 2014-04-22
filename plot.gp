#!/usr/bin/env gnuplot

set term pdfcairo enhanced font "Times,8" size 12,6
colors = "blue dark-green red dark-magenta dark-yellow orange dark-pink dark-cyan"

set for [i=0:words(colors)] style line 10+i pointtype 7 pointsize 0.25 linecolor rgb word(colors,i+1)
set key Left
if (!exists("ver")) ver=3      # Which encode configuration version
if (!exists("start")) start=0  # First stream
if (!exists("end")) end=3      # Last stream (default half-set)

# Frame vs Size
set xlabel "Frame"
set ylabel "Size (bits)"
set xrange [-1:201]
set xtics 0,8,200
set yrange [0:800000]
set grid xtics linetype 1 linewidth 0.25 linecolor rgb "#cccccc"
set output ''.ver.'/frame_v_size.pdf'
set multiplot
plot for [i=start:end] ''.ver.'/stream'.i.'.dat' using 2:4 with points linestyle 10+i title 'Stream '.i
plot for [i=start:end] ''.ver.'/stream'.i.'.dat' using 2:4:1 with labels offset 1 textcolor rgb word(colors,i+1) notitle
unset multiplot
set output

# Frame vs PSNR
set output ''.ver.'/frame_v_psnr.pdf'
set ylabel "PSNR (dB)"
set yrange [28:34]
set ytics 28,0.5,34
set multiplot
plot for [i=start:end] ''.ver.'/stream'.i.'.dat' using 2:3 with points linestyle 10+i title 'Stream '.i
plot for [i=start:end] ''.ver.'/stream'.i.'.dat' using 2:3:1 with labels offset 1 textcolor rgb word(colors,i+1) notitle
unset multiplot
set output
