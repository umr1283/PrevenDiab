# Test chargement Bases
library(readxl)
library(dplyr)
library(stringr)
library(data.table)
library(here)

###
project <- basename(here())
outputs_directory <- here("outputs")
dir.create(dirname(outputs_directory))
#
###
# Utilisation des données cliniques et biologiques envoyées par l'IPL, soit 144 individus, de l'étude cas/témoins
###
#============================BASE DE DONNEES - SOUS-GROUPE (n=144)=================================================================#
data_pheno_path <- here("data/PrevenDIAB_BDD Données cliniques_SG_22122023.csv")
data_geno_path <- here("data/PrevenDIAB_BDD Données biologiques_sous groupe_VF.xlsx")


Data_pheno_PrevenDiab <- data.table::fread(data_pheno_path, header = TRUE, sep = ";")
Data_geno_PrevenDiab <- as.data.frame(read_xlsx(data_geno_path, sheet = "Biologie par sujet"))
# Data_geno_name <- as.data.frame(read_xlsx(data_geno_path, sheet = 2, col_names = c("var", "name_var")))
Data_geno_name <- as.data.frame(read_xlsx(data_geno_path, sheet = "Correspondance", col_names = TRUE))
colnames(Data_geno_name) <- c("var", "name_var", "unités")

# _______________________________________________________________________________
### Renommer les noms des variables biologiques
  ### n = 144
ifelse(colnames(Data_geno_PrevenDiab)[2:ncol(Data_geno_PrevenDiab)] == Data_geno_name[, 1],
  colnames(Data_geno_PrevenDiab)[2:ncol(Data_geno_PrevenDiab)] <- paste0(colnames(Data_geno_PrevenDiab)[2:ncol(Data_geno_PrevenDiab)], "_", Data_geno_name[, 2]),
  NA
)
# OU #
# colnames(Data_geno_PrevenDiab)[3:58] == Data_geno_name[1:56, 1]
# colnames(Data_geno_PrevenDiab)[3:58] <- Data_geno_name[1:56, 2]
# _______________________________________________________________________________
### Attention aux espaces & autres !!
colnames(Data_geno_PrevenDiab) <- colnames(Data_geno_PrevenDiab) %>%
                                    str_replace_all(c(" " = "_", "-" = "", "°" = "", ":" = ""))
colnames(Data_geno_PrevenDiab)

# _______________________________________________________________________________
### Traiter les identifiants

#### On vérifie les identifiants avant de merge (ou simplement pour utiliser les mêmes id pour le traitement des données)
setequal(Data_pheno_PrevenDiab$Patient, Data_geno_PrevenDiab$ID_eCRF)
nrow(Data_pheno_PrevenDiab) == nrow(Data_geno_PrevenDiab)

Data_pheno_PrevenDiab$Patient <- gsub("'", "", Data_pheno_PrevenDiab$Patient) # on retire ' devant les identifiants dans la table Data_pheno_PrevenDiab
# exemple : sprintf("PC%02d", 1:12) # PC01, PC02 ... PC12

Patient_1ernombre <- gsub("^(.*)-([1234567890]+)$", "\\1", Data_pheno_PrevenDiab$Patient)
# Data_pheno_PrevenDiab$Patient_2iemenombre <- gsub("^(1-)([1234567890]+)$", "\\2", Data_pheno_PrevenDiab$Patient)
Patient_2iemenombre <- gsub("^(.*)-([1234567890]+)$", "\\2", Data_pheno_PrevenDiab$Patient)
as.numeric(Patient_2iemenombre)

Data_pheno_PrevenDiab$Patient_clean <- paste0(Patient_1ernombre, "-", sprintf("%04d", as.numeric(Patient_2iemenombre)))

# _______________________________________________________________________________
### Verif
setequal(Data_pheno_PrevenDiab$Patient_clean, Data_geno_PrevenDiab$ID_eCRF) # si ok : TRUE

#### Merge des tables
Data_PrevenDiab_merged <- merge(Data_pheno_PrevenDiab, Data_geno_PrevenDiab, by.x = "Patient_clean", by.y = "ID_eCRF") # 1167 + 45 - ID-col = 1211
# aa <- ncol(Data_pheno_PrevenDiab) ; ab <- ncol(Data_geno_PrevenDiab)
dim(Data_PrevenDiab_merged)


Data_PrevenDiab_merged$Niveau_Etudes

### Attention aussi aux accents :
for (i in seq_len(ncol(Data_PrevenDiab_merged))) {
  # i <- 17
  # Data_PrevenDiab_merged[[i]] <- Data_PrevenDiab_merged[[i]] %>% str_replace_all(c("\xe9" = "e", "\xe8" = "e", "\xf4" = "o", "\xee" = "i", "\xe0" = "a"))
  # OU
  Data_PrevenDiab_merged[[i]] <- gsub("\xe9", "e", gsub("\xe8", "e", gsub("\xf4", "o", gsub("\xee", "i", gsub("\xe0", "a", x = Data_PrevenDiab_merged[[i]])))))
}




data.table::fwrite(Data_PrevenDiab_merged, paste(outputs_directory, paste0("Data_PrevenDiab_merged_00_sous-groupe_", Sys.Date(), ".tsv"), sep = "/"), sep = "\t", na = NA)
