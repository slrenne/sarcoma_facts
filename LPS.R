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

# CNV from MDM2 amplified DDLPS of TCGA firehsose https://www.cbioportal.org/results/oncoprint?comparison_subtab=overlap&comparison_overlapStrategy=Exclude&comparison_selectedGroups=%5B%22Altered%20group%22%2C%22MDM2%22%2C%22HMGA2%22%2C%22GLI1%22%2C%22DDIT3%22%2C%22CDK4%22%5D&plots_horz_selection=%7B%7D&plots_vert_selection=%7B%7D&plots_coloring_selection=%7B%7D&tab_index=tab_visualize&Action=Submit&session_id=64df514f1095f74ff79801da#userSettingsJson={%22clinicallist%22:[{%22stableId%22:%22PROFILED_IN_sarc_tcga_rna_seq_v2_mrna_median_Zscores%22,%22sortOrder%22:null,%22gapOn%22:null},{%22stableId%22:%22CANCER_TYPE_DETAILED%22,%22sortOrder%22:null,%22gapOn%22:null}]}

DDLPS.seg <- read.delim("input/sarc_tcga_segments.seg")
