## ----setup, include=FALSE-----------------------------------------------------
all_times <- list()  # store the time for each chunk
knitr::knit_hooks$set(time_it = local({
  now <- NULL
  function(before, options) {
    if (before) {
      now <<- Sys.time()
    } else {
      res <- difftime(Sys.time(), now, units = "secs")
      all_times[[options$label]] <<- res
    }
  }
}))
knitr::opts_chunk$set(
  tidy = TRUE,
  tidy.opts = list(width.cutoff = 95),
  message = FALSE,
  warning = FALSE,
  time_it = TRUE
)
orthologs <- readRDS(file = "fls/orthologs.rds")

## ----setup packages, eval = F-------------------------------------------------
#  require(biomaRt)
#  require(tidyverse)
#  require(SignacX)

## ----load genes, echo = T, eval = T-------------------------------------------
features.tsv <- read.delim("fls/features.tsv.gz", header=FALSE, stringsAsFactors=FALSE)
head(features.tsv)

## ----map genes, eval = F------------------------------------------------------
#  # get human and cyno gene symbols
#  human.R95 <- useMart(host='jan2019.archive.ensembl.org',
#  				   biomart='ENSEMBL_MART_ENSEMBL',
#  				   dataset='hsapiens_gene_ensembl')
#  cyno.R95 <- useMart(host='jan2019.archive.ensembl.org',
#  				   biomart='ENSEMBL_MART_ENSEMBL',
#  				   dataset='mfascicularis_gene_ensembl')
#  
#  # values = listeENSID: list of cynomolgus ensembl IDs to be retrieved.
#  listeENSID = features.tsv$V1
#  orthologs <- getLDS(attributes = c("ensembl_gene_id","external_gene_name"),
#  				  filters = "ensembl_gene_id",
#  				  values = listeENSID,
#  				  mart = cyno.R95,
#  				  attributesL = c("hgnc_symbol","ensembl_gene_id"),
#  				  martL = human.R95)
#  orthologs <- as_tibble(orthologs)
#  colnames(orthologs) <- c("GeneID","cynoSymbol","HumanSymbol","HumanGeneID")
#  
#  # keep only 1:1 orthologs
#  one2one <- orthologs %>%
#  group_by(GeneID) %>%
#  summarise(n()) %>%
#  filter(`n()`<=1) %>%
#  dplyr::select(`GeneID`) %>%
#  pull()
#  orthologs <- orthologs %>% filter(GeneID %in% one2one)
#  
#  # replace empty HumanSymbol (where there isn't a gene name for a homologous gene) with NA
#  orthologs <- orthologs %>%
#  mutate(HumanSymbol=replace(HumanSymbol,HumanSymbol=="", NA))
#  orthologs <- orthologs %>%
#  mutate(cynoSymbol=replace(cynoSymbol,cynoSymbol=="", NA))
#  
#  idx = match(listeENSID, orthologs$GeneID)
#  xx = orthologs$HumanSymbol[idx]
#  logik = !is.na(orthologs$HumanSymbol[idx]) # sum(logik) returns 17,365 homologous genes
#  xx = xx[logik]
#  orthologs = orthologs[!is.na(orthologs$HumanSymbol),]
#  # note: several of these genes are not unique mappers; we will aggregate them later or make them unique. To aggregate, where E is the sparse expression matrix with rownames set to xx:
#  # E = Matrix.utils::aggregate.Matrix(E, row.names(E))

## ----display orthologs--------------------------------------------------------
head(orthologs)

## ----save.times, include = FALSE----------------------------------------------
write.csv(x = t(as.data.frame(all_times)), file = "fls/tutorial_times_Crabeating_vignette.csv")
saveRDS(orthologs, file = "fls/orthologs.rds")

## ---- echo=FALSE--------------------------------------------------------------
sessionInfo()

