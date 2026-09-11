library(dplyr)


# data downloaded from: https://www.cbioportal.org/results/oncoprint?tab_index=tab_visualize&Action=Submit&session_id=61b9b128f8f71021ce57d922&clinicallist=CANCER_TYPE%2CCANCER_TYPE_DETAILED%2CMUTATION_COUNT%2CNO_CONTEXT_MUTATION_SIGNATURE&plots_horz_selection=%7B%7D&plots_vert_selection=%7B%7D&plots_coloring_selection=%7B%7D
#d <- readr::read_csv("sarcoma_pancancer_mutation.csv")

#https://www.cbioportal.org/results/oncoprint?cancer_study_list=msk_impact_2017%2Ces_dfarber_broad_2014%2Ces_iocurie_2014%2Csarc_tcga%2Crms_nih_2014%2Cangs_painter_2020%2Cusarc_msk_2020%2Cntrk_msk_2019%2Cpan_origimed_2020%2Cpancan_pcawg_2020%2Csarc_mskcc%2Cangs_project_painter_2018%2Cmetastatic_solid_tumors_mich_2017%2Cmixed_allen_2018%2Csummit_2018%2Ctmb_mskcc_2018&tab_index=tab_visualize&profileFilter=mutations%2Cfusion%2Ccna%2Cgistic%2Ccna_rae&case_set_id=all&Action=Submit&gene_list=TP53&clinicallist=CANCER_TYPE%2CCANCER_TYPE_DETAILED%2CMUTATION_COUNT%2CTMB_NONSYNONYMOUS&Z_SCORE_THRESHOLD=2.0&RPPA_SCORE_THRESHOLD=2.0&geneset_list=%20

d <- read.csv("input/PATIENT_DATA_oncoprint.tsv", sep= "\t")
d <- t(d)
d <- data.frame(d)
colnames(d) <- d[1,] 
d <- d[-c(1,2),]
d <- d[,1:3]
colnames(d) <- c("Cancer.Type", "Cancer.Type.Detailed", "Mutation.Count")
d[,3] <- as.numeric(d[,3])
d$Mutation.Count <- d$Mutation.Count/30 #mutation n * 1 Mb/ Exom Mb ~ 30Mb

#expand the sarcoma category 
d$new.type <- d$Cancer.Type
d$new.type <- ifelse(d$Cancer.Type %in% c("Nerve Sheath Tumor",
                                          "Peripheral Nervous System",
                                          "Bone Cancer",
                                          "Bone Sarcoma",
                                          "Soft Tissue Sarcoma"), d$Cancer.Type.Detailed, d$Cancer.Type)
#create a 01 classifier for sarcoma
d$isSarco <- ifelse(d$Cancer.Type %in% c("Nerve Sheath Tumor",
                                         "Peripheral Nervous System",
                                         "Bone Cancer",
                                         "Bone Sarcoma",
                                         "Soft Tissue Sarcoma", 
                                         "Uterine Sarcoma",
                                         "Gastrointestinal Stromal Tumor",
                                         "Breast Sarcoma" ), 1, 0)

# #group UPS
# d$new.type[d$new.type=="Undifferentiated Pleomorphic Sarcoma/Malignant Fibrous Histiocytoma/High-Grade Spindle Cell Sarcoma"] <- "Undifferentiated Pleomorphic Sarcoma"
# d$new.type[d$new.type=="Undifferentiated Pleomorphic Sarcoma Malignant Fibrous Histiocytoma"] <- "Undifferentiated Pleomorphic Sarcoma"
# d$new.type[d$new.type=="Unclassified Sarcoma"] <- "Undifferentiated Pleomorphic Sarcoma"
# d$new.type[d$new.type=="Soft Tissue Sarcoma"] <- "Undifferentiated Pleomorphic Sarcoma"
# d$new.type[d$new.type=="Soft Tissue Sarcoma Other"] <- "Undifferentiated Pleomorphic Sarcoma"
# d$new.type[d$new.type=="Undifferentiated Sarcoma"] <- "Undifferentiated Pleomorphic Sarcoma"
# d$new.type[d$new.type=="Spindle Cell Sarcoma"] <- "Undifferentiated Pleomorphic Sarcoma"
# d$new.type[d$new.type=="Sarcoma, NOS"] <- "Undifferentiated Pleomorphic Sarcoma"
# d$new.type[d$new.type=="Mixed"] <- "Undifferentiated Pleomorphic Sarcoma"

#group UPS
d$new.type[d$new.type=="Undifferentiated Pleomorphic Sarcoma/Malignant Fibrous Histiocytoma/High-Grade Spindle Cell Sarcoma"] <- "Undifferentiated Pleomorphic Sarcoma"
d$new.type[d$new.type=="Undifferentiated Pleomorphic Sarcoma Malignant Fibrous Histiocytoma"] <- "Undifferentiated Pleomorphic Sarcoma"
d$new.type[d$new.type=="Unclassified Sarcoma"] <- "Sarcoma, NOS"
d$new.type[d$new.type=="Soft Tissue Sarcoma"] <- "Sarcoma, NOS"
d$new.type[d$new.type=="Soft Tissue Sarcoma Other"] <- "Sarcoma, NOS"
d$new.type[d$new.type=="Undifferentiated Sarcoma"] <- "Sarcoma, NOS"
d$new.type[d$new.type=="Spindle Cell Sarcoma"] <- "Sarcoma, NOS"
d$new.type[d$new.type=="Sarcoma, NOS"] <- "Sarcoma, NOS"
d$new.type[d$new.type=="Mixed"] <- "Sarcoma, NOS"



#grouping other Sarcoma 
d$new.type[d$new.type=="Low grade Fibromyxoid Sarcoma"] <- "Low-Grade Fibromyxoid Sarcoma"
d$new.type[d$new.type=="Mucinous Liposarcoma"] <- "Myxoid/Round-Cell Liposarcoma"
d$new.type[d$new.type=="Myxoid Fibrosarcoma"] <- "Myxofibrosarcoma"
d$new.type[d$new.type=="Proximal-Type Epithelioid Sarcoma"] <- "Epithelioid Sarcoma"
d$new.type[d$new.type=="Solitary Fibrous Tumor/Hemangiopericytoma"] <- "Solitary Fibrous Tumor"
d$new.type[d$new.type=="Well Differentiated Liposarcoma"] <- "Well-Differentiated Liposarcoma"
d$new.type[d$new.type=="Liposarcoma"] <- "Dedifferentiated Liposarcoma"
d$new.type[d$new.type=="Histiocytic Dendritic Cell Sarcoma"] <- "Follicular Dendritic Cell Sarcoma"
d$new.type[d$new.type=="Fibromatosis"] <- "Desmoid/Aggressive Fibromatosis"
d$new.type[d$new.type=="Inflammatory Myofibroblastic Lung Tumor"] <- "Inflammatory Myofibroblastic Tumor"

#filter the histology to display to the group with more than 50 cases
hist.to.view <- d %>% group_by(Cancer.Type) %>% 
  summarise(N=n()) %>% filter(N > 50) 

d <- d[d$Cancer.Type %in% unique(hist.to.view$Cancer.Type),]

#group repeated histologies
d$new.type[d$new.type=="Breast Cancer"] <- "Breast Carcinoma"
d$new.type[d$new.type=="Colorectal Cancer"] <- "Colorectal Carcinoma"
d$new.type[d$new.type=="Cervical Cancer"] <- "Carcinoma of Uterine Cervix"
d$new.type[d$new.type=="Uterine Corpus Endometrial Carcinoma"] <- "Endometrial Cancer"
d$new.type[d$new.type=="Head and Neck Cancer"] <- "Head and Neck Carcinoma"
d$new.type[d$new.type=="Mature B-Cell Neoplasms"] <- "Mature B-cell lymphoma"
d$new.type[d$new.type=="Non Small Cell Lung Cancer"] <- "Non-Small Cell Lung Cancer"
d$new.type[d$new.type=="Ovarian Cancer"] <- "Ovarian Carcinoma"


#create a vector of histologies oredered by median mutation
ord_by_median <- 
  d %>% group_by(new.type, isSarco) %>% 
  summarise(median.mut = median(log10(Mutation.Count+0.1))) %>%
  arrange(median.mut)

d$new.type <- factor(d$new.type, 
                     levels = ord_by_median$new.type)




png("output/mut.png", 
     units = "in", 
     width = 25, height = 8, res = 300)
par(mar=c(14, 6, 4, 4) + 0.1)
plot(log10(d$Mutation.Count+0.1), type="n",
     ylim = c(log10(0.1),log10(max(d$Mutation.Count))+0.5), 
     xlim = c(0,length(d$Cancer.Type)),
     xaxt="n", yaxt="n",xlab="",ylab = "Somatic mutation prevalence \n(number mutations per Mb)",
     main = "Sarcoma mutational load  \ncompared to other cancer types" )
for(i in 1:length(levels(d$new.type))){
  set_x <-length(d$Cancer.Type)/length(levels(d$new.type))
  class_length <- sum(as.numeric(d$new.type)==i)
  unit_in_tum <- set_x/sum(as.numeric(d$new.type)==i)
  points(x=set_x*(i-1)+unit_in_tum*1:class_length,
         y=log10(d$Mutation.Count[as.numeric(d$new.type)==i]+0.1),
         col= scales::alpha(d$isSarco[as.numeric(d$new.type)==i]+1, 
                            alpha = 0.4))
  segments(x0=set_x*(i-1), 
           x1=set_x*i, 
           y0=ord_by_median$median.mut[i],
           col=d$isSarco[as.numeric(d$new.type)==i]+1,
           lwd=2)
}
axis(side = 1, at=1:length(levels(d$new.type))*set_x-set_x/2,
     labels = FALSE)

text(x=1:length(levels(d$new.type))*set_x-set_x/2,
     y= par("usr")[3] - 0.25,
     labels = ord_by_median$new.type, srt = 45,
     xpd = NA,
     adj = 0.97,
     col = ord_by_median$isSarco +1 )

axis(side=2, at=-1:4, 
      labels = c(0.1,1,10,100,1000,10000))
dev.off()

