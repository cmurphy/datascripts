#!/usr/bin/env gnuplot

set term pdfcairo enhanced font "Times,4" size 12,6
set style line 1 pointtype 7 pointsize 0.25 linecolor rgb "blue" 
set style line 2 pointtype 7 pointsize 0.25 linecolor rgb "dark-green"
set style line 3 pointtype 7 pointsize 0.25 linecolor rgb "red"
set style line 4 pointtype 7 pointsize 0.25 linecolor rgb "dark-magenta"
set style line 5 pointtype 7 pointsize 0.25 linecolor rgb "dark-yellow"
set style line 6 pointtype 7 pointsize 0.25 linecolor rgb "orange"
set style line 7 pointtype 7 pointsize 0.25 linecolor rgb "dark-pink"
set style line 8 pointtype 7 pointsize 0.25 linecolor rgb "dark-cyan"
set key Left

# Frame vs Size
set xlabel "Frame"
set ylabel "Size (bits)"
set xrange [-1:201]
set xtics 0,8,200
set yrange [0:800000]
set grid xtics linetype 1 linewidth 0.25 linecolor rgb "#cccccc"
if (!exists("ver")) ver=3
set output ''.ver.'/frame_v_size.pdf'
#plot ''.ver.'/stream'.i.'.dat' using 2:4 with points linestyle 10+i title 'Stream '.i ,\
#                                   ''.ver.'/stream'.i.'.dat' using 2:4:1 with labels offset 1 textcolor rgb "blue" notitle
plot ''.ver.'/stream0.dat' using 2:4 with points linestyle 1 title 'Stream 0: fwd dependency on Stream 2' ,\
        ''.ver.'/stream0.dat' using 2:4:1 with labels offset 1 textcolor rgb "blue" notitle ,\
     ''.ver.'/stream1.dat' using 2:4 with points linestyle 2 title 'Stream 1: fwd dependency on Stream 2, bwd dependency on Stream 0' ,\
        ''.ver.'/stream1.dat' using 2:4:1 with labels offset 1 textcolor rgb "dark-green" notitle ,\
     ''.ver.'/stream2.dat' using 2:4 with points linestyle 3 title 'Stream 2' ,\
        ''.ver.'/stream2.dat' using 2:4:1 with labels offset 1 textcolor rgb "red" notitle ,\
     ''.ver.'/stream3.dat' using 2:4 with points linestyle 4 title 'Stream 3: fwd dependency on Stream 2' ,\
        ''.ver.'/stream3.dat' using 2:4:1 with labels offset 1 textcolor rgb "dark-magenta" notitle
set output

# Frame vs PSNR
set output "3/frame_v_psnr.pdf"
set ylabel "PSNR (dB)"
set yrange [28:34]
set ytics 28,0.5,34
plot "3/stream0.dat" using 2:3 with points linestyle 1 title "Stream 0: fwd dependency on Stream 2",\
        "3/stream0.dat" using 2:3:1 with labels offset 1 textcolor rgb "blue" notitle,\
     "3/stream1.dat" using 2:3 with points linestyle 2 title "Stream 1: fwd dependency on Stream 2, bwd dependency on Stream 0",\
        "3/stream1.dat" using 2:3:1 with labels offset 1 textcolor rgb "dark-green" notitle ,\
     "3/stream2.dat" using 2:3 with points linestyle 3 title "Stream 2" ,\
        "3/stream2.dat" using 2:3:1 with labels offset 1 textcolor rgb "red" notitle ,\
     "3/stream3.dat" using 2:3 with points linestyle 4 title "Stream 3: fwd dependency on Stream 2" ,\
        "3/stream3.dat" using 2:3:1 with labels offset 1 textcolor rgb "dark-magenta" notitle
set output
