## ----setup0, include=FALSE----------------------------------------------------
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
celltypes = readRDS(file = "fls/celltypes_amp_synovium.rds")
True_labels = readRDS(file = "fls/celltypes_amp_synovium_true.rds")
load(file = "fls/SingleR_Results.rda")


## ----read CELSeq2, message = F, eval = F--------------------------------------
#  ReadCelseq <- function (counts.file, meta.file)
#  {
#    E = suppressWarnings(readr::read_tsv(counts.file));
#    gns <- E$gene;
#    E = E[,-1]
#    E = Matrix::Matrix(as.matrix(E), sparse = TRUE)
#    rownames(E) <- gns
#    E
#  }
#  
#  counts.file = "./fls/celseq_matrix_ru10_molecules.tsv.gz"
#  meta.file = "./fls/celseq_meta.immport.723957.tsv"
#  
#  E = ReadCelseq(counts.file = counts.file, meta.file = meta.file)
#  M = suppressWarnings(readr::read_tsv(meta.file))
#  
#  # filter data based on depth and number of genes detected
#  kmu = Matrix::colSums(E != 0)
#  kmu2 = Matrix::colSums(E)
#  E = E[,kmu > 200 & kmu2 > 500]
#  
#  # filter by mitochondrial percentage
#  logik = grepl("^MT-", rownames(E))
#  MitoFrac = Matrix::colSums(E[logik,]) / Matrix::colSums(E) * 100
#  E = E[,MitoFrac < 20]

## ----filter celseq, message = F, eval = F-------------------------------------
#  require(SingleR)
#  data("hpca")
#  Q = SingleR(sc_data = E, ref_data = hpca$data, types = hpca$main_types, fine.tune = F, numCores = 16)
#  save(file = "fls/SingleR_Results.rda", Q)
#  True_labels = M$type[match(colnames(E), M$cell_name)]
#  saveRDS(True_labels, file = "fls/celltypes_amp_synovium_true.rds")

## ----setupSeurat, message = F, eval = F---------------------------------------
#  library(Seurat)

## ----Seurat, message = T, eval = F--------------------------------------------
#  # load data
#  synovium <- CreateSeuratObject(counts = E, project = "FACs")
#  
#  # run sctransform
#  synovium <- SCTransform(synovium, verbose = F)

## ----Seurat 2, message = T, eval = F------------------------------------------
#  # These are now standard steps in the Seurat workflow for visualization and clustering
#  synovium <- RunPCA(synovium, verbose = FALSE)
#  synovium <- RunUMAP(synovium, dims = 1:30, verbose = FALSE)
#  synovium <- FindNeighbors(synovium, dims = 1:30, verbose = FALSE)

## ----setup2, message = F, eval = F--------------------------------------------
#  library(SignacX)

## ----Signac, message = T, eval = F--------------------------------------------
#  # Run Signac
#  labels <- Signac(synovium, num.cores = 4)
#  celltypes = GenerateLabels(labels, E = synovium)

## ----Seurat Visualization 1110, message = F, echo = F-------------------------
xx = celltypes$CellTypes
xx = as.character(xx)
xx[xx == "Plasma.cells"] = "B"
xx[xx == "NonImmune"] = as.character(celltypes$CellStates)[xx == "NonImmune"]
xx[xx == "B"] = "B"
xx[xx == "Fibroblasts"] = "F"
xx[xx == "MPh"] = "MPh"
xx[xx == "TNK"] = "T"
xx[celltypes$CellStates == "NK"] = "NK"
True_labels[True_labels == "B cell"] = "B"
True_labels[True_labels == "Fibroblast"] = "F"
True_labels[True_labels == "Monocyte"] = "MPh"
True_labels[True_labels == "T cell"] = "T"
tab = table(FACs = True_labels, Signac = xx)
vcd::assoc(tab, shade=T, legend=T)

## ----Seurat Visualization 11110, message = F, echo = T------------------------
logik = xx != "Unclassified"
Signac_Accuracy = round(sum(xx[logik] == True_labels[logik]) / sum(logik) * 100, 2)
Signac_Accuracy

## ----Seurat Visualization 10, message = F, echo = F---------------------------
xx = Q$labels
xx[xx %in% c("Macrophage", "DC", "Monocyte", "Platelets", "Neutrophils")] = "MPh"
xx[xx %in% c("B_cell", "Pre-B_cell_CD34-", "Pro-B_cell_CD34+")] = "B"
xx[xx == "Fibroblasts"] = "F"
xx[xx == "T_cells"] = "T"
xx[xx %in% c("Astrocyte", "Osteoblasts", "Tissue_stem_cells", "Smooth_muscle_cells", "MSC")] = "NonImmune"
xx[xx == "NK_cell"] = "NK"
xx[xx == "Chondrocytes"] = "Chondr."
tab = table(FACs = True_labels, SingleR = xx)
vcd::assoc(tab, shade=T, legend=T)

## ----Seurat Visualization 111110, message = F, echo = T-----------------------
logik = xx != "Unclassified"
SingleR_Accuracy = round(sum(xx[logik] == True_labels[logik]) / sum(logik) * 100, 2)
SingleR_Accuracy

## ----save results, message = F, eval = F--------------------------------------
#  saveRDS(synovium, file = "synovium_signac.rds")
#  saveRDS(celltypes, file = "synovium_signac_celltypes.rds")

## ----save.times, include = FALSE, eval = F------------------------------------
#  write.csv(x = t(as.data.frame(all_times)), file = "fls/tutorial_times_signac-seurat_singler_AMP_RA.csv")

## ---- echo=FALSE--------------------------------------------------------------
sessionInfo()

