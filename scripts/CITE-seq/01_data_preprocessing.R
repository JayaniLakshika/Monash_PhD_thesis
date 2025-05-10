## This is to save  PCAs for CITE-seq data from https://atlas.fredhutch.org/nygc/multimodal-pbmc/

# if (!requireNamespace("remotes", quietly = TRUE)) {
#   install.packages("remotes")
# }
# remotes::install_github("mojaveazure/seurat-disk")
library(readr)
library(Seurat)
library(SeuratDisk)
Convert("data/CITE-seq/multi.h5seurat", dest = "rds")  # or use dest = "rds" if you prefer

seurat_obj <- LoadH5Seurat("data/CITE-seq/multi.h5seurat")
pca_data <- seurat_obj@reductions$pca@cell.embeddings |>
  tibble::as_tibble()
names(pca_data) <- paste0("x", 1:50)

pca_data <- pca_data |>
  dplyr::select(x1:x10)

write_rds(pca_data, "data/CITE-seq/cite_seq_pbmc.rds")

