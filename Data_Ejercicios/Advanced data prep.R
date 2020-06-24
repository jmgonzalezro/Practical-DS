library(vroom)
library(vtreat) #preparación del dato
library(wrapr)

setwd("/home/jmgonzalezro/Documentos/PDSwR2-master/KDD2009/")
d <- read.table("orange_small_train.data.gz", header = TRUE, sep = "\t", na.strings = c("NA", ""))
churn <- read.table("orange_small_train_churn.labels.txt",
                    header = FALSE,
                    sep = "\t")
d$churn <- churn$V1

set.seed(729375)
rgroup <- base::sample(c("train", "calibrate", "test"), #hacemos split de data en train, calibration yt est
                       nrow(d),
                       prob = c(0.8, 0.1, 0.1),
                       replace = TRUE)
dTrain <- d[rgroup == "train", , drop = FALSE]
dCal <- d[rgroup == "calibrate", , drop = FALSE]
dTrainAll <- d[rgroup %in% c("train", "calibrate"), , drop = FALSE]
dTest <- d[rgroup == "test", , drop = FALSE]

outcome <- "churn"
vars <- setdiff(colnames(dTrainAll), outcome)

rm(list = c("d", "churn", "rgroup")) # para eliminar los objetos que no necesitamos del workspace

str(dTrain)
summary(dTrain)

outcome_summary <- table(
  churn = dTrain[, outcome],
  useNA = "ifany"
)
knitr::kable(outcome_summary) # 1 = cancela. -1 no cancela.
outcome_summary["1"] / sum(outcome_summary) # establece el churnrate o la prevalencia
# tenemos un ratio de 0.93 de precisión. Fallamos el 7%

# library(wrapr)




























































