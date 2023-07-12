# plotting  Jour et al findings PMID25059573

ampl_by_grade <- c(10,13,7,19) 
xpos <- 1:4-0.5
hcol <-  c(3,4,3,4)


png('output/jour_ampl_grade_hist.png')
plot(0, type = "l", 
     xlab = "amplification", ylab = "Counts",  
     xlim = c(0,4), ylim = c(0,20), 
     xaxt = "n")
for (i in 1:4) {
  segments(x0 = xpos[i], y0 = 0, y1 = ampl_by_grade[i],                   
           col = hcol[i], lwd = 4)}
abline(v = 2, lty = 2)
axis(1, at = c(1,3), labels = c('high', 'low'))
legend('topleft', lwd=4, col = c(3,4), legend = c('G3', 'G2'))
dev.off()
