
# Read results from (http://persoal.citius.usc.es/manuel.fernandez.delgado/papers/jmlr/results.txt)
# http://stackoverflow.com/questions/5990654/incomplete-final-line-warning-when-trying-to-read-a-csv-file-into-r
results_raw <- readLines("data/results.txt")

# Import into a dataframe
names_cols <- strsplit(results_raw[1], "\\, |\\,| |\t")[[1]]
names_cols <- names_cols[-which(names_cols=="")]
n_rows = 122  # Last rows are the summary
results = data.frame(matrix(NA, nrow=n_rows-1, ncol=length(names_cols)))
colnames(results) <- names_cols

for (i in 2:n_rows) {
  temp <- strsplit(results_raw[i], "\\, |\\,| |\t")[[1]]
  temp <- temp[-which(temp=="")]
  results[i-1,] <- temp
}

# Remove columns 
rownames(results) <- results[,"problema"]
results <- results[, !(colnames(results) %in% c("problema", "min", "max", "mean", "std"))]
results[results == "--"] <- NA

# Convert to numeric
for (j in 1:dim(results)[2]){
  results[,j] <- as.numeric(results[,j])  
}

save(results, file="data/results.Rda")


# Create datasets information file
# using the information on TABLE1 & TABLE2
# Some names are not the same in restults and the tables

info_tables = data.frame(matrix(NA, nrow=dim(results)[1], ncol=4))
colnames(info_tables) <- c("obs", "features", "classes", "majority")
rownames(info_tables) <- rownames(results)

info_tables['abalone',] = c(4177,8,3,34.6)
info_tables['acute-inflammation',] = c(120,6,2,50.8)
info_tables['acute-nephritis',] = c(120,6,2,58.3)
info_tables['adult',] = c(48842,14,2,75.9)
info_tables['annealing',] = c(798,38,6,76.2)
info_tables['arrhythmia',] = c(452,262,13,54.2)
info_tables['audiology-std',] = c(226,59,18,26.3)
info_tables['balance-scale',] = c(625,4,3,46.1)
info_tables['balloons',] = c(16,4,2,56.2)
info_tables['bank',] = c(45211,17,2,88.5)
info_tables['blood',] = c(748,4,2,76.2)
info_tables['breast-cancer',] = c(286,9,2,70.3)
info_tables['breast-cancer-wisc',] = c(699,9,2,65.5)
info_tables['breast-cancer-wisc-diag',] = c(569,30,2,62.7)
info_tables['breast-cancer-wisc-prog',] = c(198,33,2,76.3)
info_tables['breast-tissue',] = c(106,9,6,20.7)
info_tables['car',] = c(1728,6,4,70)
info_tables['cardiotocography-10clases',] = c(2126,21,10,27.2)
info_tables['cardiotocography-3clases',] = c(2126,21,3,77.8)
info_tables['chess-krvk',] = c(28056,6,18,16.2)
info_tables['chess-krvkp',] = c(3196,36,2,52.2)
info_tables['congressional-voting',] = c(435,16,2,61.4)
info_tables['conn-bench-sonar-mines-rocks',] = c(208,60,2,53.4)
info_tables['conn-bench-vowel-deterding',] = c(528,11,11,9.1)
info_tables['connect-4',] = c(67557,42,2,75.4)
info_tables['contrac',] = c(1473,9,3,42.7)
info_tables['credit-approval',] = c(690,15,2,55.5)
info_tables['cylinder-bands',] = c(512,35,2,60.9)
info_tables['dermatology',] = c(366,34,6,30.6)
info_tables['echocardiogram',] = c(131,10,2,67.2)
info_tables['ecoli',] = c(336,7,8,42.6)
info_tables['monks-2',] = c(169,6,2,62.1)
info_tables['monks-3',] = c(3190,6,2,50.8)
info_tables['mushroom',] = c(8124,21,2,51.8)
info_tables['musk-1',] = c(476,166,2,56.5)
info_tables['musk-2',] = c(6598,166,2,84.6)
info_tables['nursery',] = c(12960,8,5,33.3)
info_tables['oocytes_merluccius_states_2f',] = c(1022,25,3,67)
info_tables['oocytes_merluccius_nucleus_4d',] = c(1022,41,2,68.7)
info_tables['oocytes_trisopterus_nucleus_2f',] = c(912,25,2,57.8)
info_tables['oocytes_trisopterus_states_5b',] = c(912,32,3,57.6)
info_tables['optical',] = c(3823,62,10,10.2)
info_tables['ozone',] = c(2536,72,2,97.1)
info_tables['page-blocks',] = c(5473,10,5,89.8)
info_tables['parkinsons',] = c(195,22,2,75.4)
info_tables['pendigits',] = c(7494,16,10,10.4)
info_tables['pima',] = c(768,8,2,65.1)
info_tables['pittsburg-bridges-MATERIAL',] = c(106,4,3,74.5)
info_tables['pittsburg-bridges-REL-L',] = c(103,4,3,51.5)
info_tables['pittsburg-bridges-SPAN',] = c(92,4,3,52.2)
info_tables['pittsburg-bridges-T-OR-D',] = c(102,4,2,86.3)
info_tables['pittsburg-bridges-TYPE',] = c(105,4,6,41.9)
info_tables['planning',] = c(182,12,2,71.4)
info_tables['plant-margin',] = c(1600,64,100,1)
info_tables['plant-shape',] = c(1600,64,100,1)
info_tables['plant-texture',] = c(1600,64,100,1)
info_tables['post-operative',] = c(90,8,3,71.1)
info_tables['primary-tumor',] = c(330,17,15,25.4)
info_tables['ringnorm',] = c(7400,20,2,50.5)
info_tables['seeds',] = c(210,7,3,33.3)
info_tables['semeion',] = c(1593,256,10,10.2)
info_tables['energy-y1',] = c(768,8,3,46.9)
info_tables['energy-y2',] = c(768,8,3,49.9)
info_tables['fertility',] = c(100,9,2,88)
info_tables['flags',] = c(194,28,8,30.9)
info_tables['glass',] = c(214,9,6,35.5)
info_tables['haberman-survival',] = c(306,3,2,73.5)
info_tables['hayes-roth',] = c(132,3,3,38.6)
info_tables['heart-cleveland',] = c(303,13,5,54.1)
info_tables['heart-hungarian',] = c(294,12,2,63.9)
info_tables['heart-switzerland',] = c(123,12,2,39)
info_tables['heart-va',] = c(200,12,5,28)
info_tables['hepatitis',] = c(155,19,2,79.3)
info_tables['hill-valley',] = c(606,100,2,50.7)
info_tables['horse-colic',] = c(300,25,2,63.7)
info_tables['ilpd-indian-liver',] = c(583,9,2,71.4)
info_tables['image-segmentation',] = c(210,19,7,14.3)
info_tables['ionosphere',] = c(351,33,2,64.1)
info_tables['iris',] = c(150,4,3,33.3)
info_tables['led-display',] = c(1000,7,10,11.1)
info_tables['lenses',] = c(24,4,3,62.5)
info_tables['letter',] = c(20000,16,26,4.1)
info_tables['libras',] = c(360,90,15,6.7)
info_tables['low-res-spect',] = c(531,100,9,51.9)
info_tables['lung-cancer',] = c(32,56,3,40.6)
info_tables['lymphography',] = c(148,18,4,54.7)
info_tables['magic',] = c(19020,10,2,64.8)
info_tables['mammographic',] = c(961,5,2,53.7)
info_tables['miniboone',] = c(130064,50,2,71.9)
info_tables['molec-biol-promoter',] = c(106,57,2,50)
info_tables['molec-biol-splice',] = c(3190,60,3,51.9)
info_tables['monks-1',] = c(124,6,2,50)
info_tables['soybean',] = c(307,35,18,13)
info_tables['spambase',] = c(4601,57,2,60.6)
info_tables['spect',] = c(80,22,2,67.1)
info_tables['spectf',] = c(80,44,2,50)
info_tables['statlog-australian-credit',] = c(690,14,2,67.8)
info_tables['statlog-german-credit',] = c(1000,24,2,70)
info_tables['statlog-heart',] = c(270,13,2,55.6)
info_tables['statlog-image',] = c(2310,18,7,14.3)
info_tables['statlog-landsat',] = c(4435,36,6,24.2)
info_tables['statlog-shuttle',] = c(43500,9,7,78.4)
info_tables['statlog-vehicle',] = c(846,18,4,25.8)
info_tables['steel-plates',] = c(1941,27,7,34.7)
info_tables['synthetic-control',] = c(600,60,6,16.7)
info_tables['teaching',] = c(151,5,3,34.4)
info_tables['thyroid',] = c(3772,21,3,92.5)
info_tables['tic-tac-toe',] = c(958,9,2,65.3)
info_tables['titanic',] = c(2201,3,2,67.7)
info_tables['trains',] = c(10,28,2,50)
info_tables['twonorm',] = c(7400,20,2,50)
info_tables['vertebral-column-2clases',] = c(310,6,2,67.7)
info_tables['vertebral-column-3clases',] = c(310,6,3,48.4)
info_tables['wall-following',] = c(5456,24,4,40.4)
info_tables['waveform',] = c(5000,21,3,33.9)
info_tables['waveform-noise',] = c(5000,40,3,33.8)
info_tables['wine',] = c(179,13,3,39.9)
info_tables['wine-quality-red',] = c(1599,11,6,42.6)
info_tables['wine-quality-white',] = c(4898,11,7,44.9)
info_tables['yeast',] = c(1484,8,10,31.2)
info_tables['zoo',] = c(101,16,7,40.6)

save(info_tables, file="data/info_tables.Rda")

load(file="data/info_tables.Rda")

# Import Results from sklearn
load(file="experiments_sklearn/ExploreModels/results_sklearn.RDa")

# Row audiology-std is repeted
results_sklearn <- results_sklearn[c(c(1:7),c(9:123)),]

# rows column_3C_weka and column_2C_weka not in initial results, trains is missing
results_sklearn <- results_sklearn[c(c(1:111),c(113:122)),]
results_sklearn[111,"data"] = "trains"
results_sklearn[111,4:9] = NA
# keep only algos and change names
results_sklearn <- results_sklearn[,4:9]
sklearn_algos = c("graBoost_sklearn", "KNN5_sklearn", "logres_sklearn", "NB_sklearn", "RF_sklearn","SVM_sklearn")
colnames(results_sklearn) <- sklearn_algos
results_sklearn <- results_sklearn *100

# add sklearn in results
results[,sklearn_algos] <- results_sklearn
save(results,file="data/results.Rda")
# For ranking inpute mean
results_ranking <- results
for (i in 1:dim(results_ranking)[1]){
  results_ranking[i, is.na(results_ranking[i, ])] <- mean(data.matrix(results_ranking[i, ]),  na.rm = TRUE)
}
save(results_ranking, file="data/results_ranking.Rda")


# ADD algorithm group
load(file="data/results.Rda")

nj = dim(results)[2]
algos_family <- data.frame(matrix(ncol = 1, nrow = nj))
rownames(algos_family)  <- colnames(results)
colnames(algos_family)  <- "family"

algos_family[1,] = 'NNET'
algos_family[2,] = 'BST'
algos_family[3,] = 'BAG'
algos_family[4,] = 'BAG'
algos_family[5,] = 'BAG'
algos_family[6,] = 'BAG'
algos_family[7,] = 'BAG'
algos_family[8,] = 'BAG'
algos_family[9,] = 'BAG'
algos_family[10,] = 'BAG'
algos_family[11,] = 'BAG'
algos_family[12,] = 'BAG'
algos_family[13,] = 'BAG'
algos_family[14,] = 'BAG'
algos_family[15,] = 'BAG'
algos_family[16,] = 'BAG'
algos_family[17,] = 'DT'
algos_family[18,] = 'BST'
algos_family[19,] = 'BST'
algos_family[20,] = 'BST'
algos_family[21,] = 'BST'
algos_family[22,] = 'BST'
algos_family[23,] = 'BST'
algos_family[24,] = 'BST'
algos_family[25,] = 'BST'
algos_family[26,] = 'BST'
algos_family[27,] = 'BST'
algos_family[28,] = 'BST'
algos_family[29,] = 'BST'
algos_family[30,] = 'BY'
algos_family[31,] = 'DT'
algos_family[32,] = 'RF'
algos_family[33,] = 'DT'
algos_family[34,] = 'DT'
algos_family[35,] = 'DA'
algos_family[36,] = 'DA'
algos_family[37,] = 'DA'
algos_family[38,] = 'DA'
algos_family[39,] = 'DA'
algos_family[40,] = 'DA'
algos_family[41,] = 'DA'
algos_family[42,] = 'DA'
algos_family[43,] = 'DA'
algos_family[44,] = 'DA'
algos_family[45,] = 'DA'
algos_family[46,] = 'DA'
algos_family[47,] = 'DA'
algos_family[48,] = 'DA'
algos_family[49,] = 'DA'
algos_family[50,] = 'DA'
algos_family[51,] = 'DA'
algos_family[52,] = 'DA'
algos_family[53,] = 'DA'
algos_family[54,] = 'DA'
algos_family[55,] = 'BY'
algos_family[56,] = 'BY'
algos_family[57,] = 'BY'
algos_family[58,] = 'BY'
algos_family[59,] = 'BY'
algos_family[60,] = 'NNET'
algos_family[61,] = 'NNET'
algos_family[62,] = 'NNET'
algos_family[63,] = 'NNET'
algos_family[64,] = 'NNET'
algos_family[65,] = 'NNET'
algos_family[66,] = 'NNET'
algos_family[67,] = 'NNET'
algos_family[68,] = 'NNET'
algos_family[69,] = 'NNET'
algos_family[70,] = 'NNET'
algos_family[71,] = 'NNET'
algos_family[72,] = 'NNET'
algos_family[73,] = 'NNET'
algos_family[74,] = 'NNET'
algos_family[75,] = 'NNET'
algos_family[76,] = 'NNET'
algos_family[77,] = 'NNET'
algos_family[78,] = 'NNET'
algos_family[79,] = 'SVM'
algos_family[80,] = 'SVM'
algos_family[81,] = 'SVM'
algos_family[82,] = 'SVM'
algos_family[83,] = 'SVM'
algos_family[84,] = 'SVM'
algos_family[85,] = 'SVM'
algos_family[86,] = 'SVM'
algos_family[87,] = 'SVM'
algos_family[88,] = 'DT'
algos_family[89,] = 'DT'
algos_family[90,] = 'DT'
algos_family[91,] = 'DT'
algos_family[92,] = 'DT'
algos_family[93,] = 'DT'
algos_family[94,] = 'DT'
algos_family[95,] = 'DT'
algos_family[96,] = 'DT'
algos_family[97,] = 'DT'
algos_family[98,] = 'RL'
algos_family[99,] = 'RL'
algos_family[100,] = 'DT'
algos_family[101,] = 'RL'
algos_family[102,] = 'RL'
algos_family[103,] = 'RL'
algos_family[104,] = 'RL'
algos_family[105,] = 'RL'
algos_family[106,] = 'RL'
algos_family[107,] = 'RL'
algos_family[108,] = 'RL'
algos_family[109,] = 'RL'
algos_family[110,] = 'RL'
algos_family[111,] = 'BST'
algos_family[112,] = 'BST'
algos_family[113,] = 'BST'
algos_family[114,] = 'BST'
algos_family[115,] = 'BST'
algos_family[116,] = 'BST'
algos_family[117,] = 'BAG'
algos_family[118,] = 'BAG'
algos_family[119,] = 'BAG'
algos_family[120,] = 'BAG'
algos_family[121,] = 'BAG'
algos_family[122,] = 'BAG'
algos_family[123,] = 'BAG'
algos_family[124,] = 'BAG'
algos_family[125,] = 'BAG'
algos_family[126,] = 'BAG'
algos_family[127,] = 'STC'
algos_family[128,] = 'STC'
algos_family[129,] = 'RF'
algos_family[130,] = 'RF'
algos_family[131,] = 'RF'
algos_family[132,] = 'RF'
algos_family[133,] = 'RF'
algos_family[134,] = 'RF'
algos_family[135,] = 'RF'
algos_family[136,] = 'OEN'
algos_family[137,] = 'OEN'
algos_family[138,] = 'OEN'
algos_family[139,] = 'OEN'
algos_family[140,] = 'OEN'
algos_family[141,] = 'OEN'
algos_family[142,] = 'OEN'
algos_family[143,] = 'OEN'
algos_family[144,] = 'OEN'
algos_family[145,] = 'OEN'
algos_family[146,] = 'OM'
algos_family[147,] = 'GLM'
algos_family[148,] = 'GLM'
algos_family[149,] = 'GLM'
algos_family[150,] = 'GLM'
algos_family[151,] = 'GLM'
algos_family[152,] = 'NN'
algos_family[153,] = 'NN'
algos_family[154,] = 'NN'
algos_family[155,] = 'NN'
algos_family[156,] = 'NN'
algos_family[157,] = 'PLSR'
algos_family[158,] = 'PLSR'
algos_family[159,] = 'PLSR'
algos_family[160,] = 'PLSR'
algos_family[161,] = 'PLSR'
algos_family[162,] = 'PLSR'
algos_family[163,] = 'LMR'
algos_family[164,] = 'LMR'
algos_family[165,] = 'LMR'
algos_family[166,] = 'MARS'
algos_family[167,] = 'MARS'
algos_family[168,] = 'OM'
algos_family[169,] = 'OM'
algos_family[170,] = 'OM'
algos_family[171,] = 'OEN'
algos_family[172,] = 'OM'
algos_family[173,] = 'OM'
algos_family[174,] = 'OM'
algos_family[175,] = 'OM'
algos_family[176,] = 'OM'
algos_family[177,] = 'OM'
algos_family[178,] = 'SVM'
algos_family[179,] = 'NNET'
# Sklearn
algos_family[180,] = 'BST'
algos_family[181,] = 'NN'
algos_family[182,] = 'GLM'
algos_family[183,] = 'BY'
algos_family[184,] = 'RF'
algos_family[185,] = 'SVM'

colnames(algos_family) <- "Family"
algos_family[,"Algorithm"] = rownames(algos_family)
for (i in 1:dim(algos_family)[1]){
  temp1 <- strsplit(algos_family$Algorithm[i], split="_")[[1]]
  temp1 <- temp1[length(temp1)]
  algos_family[i,"Implementation"] <- temp1  
}
save(algos_family, file="data/algos_family.Rda")

# fix databases
load(file="data/algos_family.Rda")
load(file="data/results.Rda")
load(file="data/info_tables.Rda")

stats_all <- data.frame(colMeans(t(apply(-results_ranking[,!names(results_ranking) %in% c("order","max")], 1, rank, ties.method='average'))))
colnames(stats_all) <- 'FriedmanRank'
stats_all['Accuracy']  <- colMeans(results, na.rm = TRUE)
stats_all['Algorithm'] <- rownames(stats_all)
stats_all['Family'] <- algos_family$Family
stats_all['Implementation'] <- algos_family$Implementation
stats_all <- stats_all[order(stats_all$FriedmanRank),]
stats_all['Rank'] <- c(1:dim(stats_all)[1])
save(stats_all, file="data/stats_all.Rda")


filter_ = (info_tables[,"classes"] == 2)
stats_bin <- data.frame(colMeans(t(apply(-results_ranking[filter_ == "TRUE",!names(results_ranking) %in% c("order","max")], 1, rank, ties.method='average'))))
colnames(stats_bin) <- 'FriedmanRank'
stats_bin['Accuracy']  <- colMeans(results[filter_ == "TRUE",], na.rm = TRUE)
stats_bin['Algorithm'] <- rownames(stats_bin)
stats_bin['Family'] <- algos_family$Family
stats_bin['Implementation'] <- algos_family$Implementation
stats_bin <- stats_bin[order(stats_bin$FriedmanRank),]
stats_bin['Rank'] <- c(1:dim(stats_bin)[1])
save(stats_bin, file="data/stats_bin.Rda")


algos <- data.frame(Algorithm="",FullName="", color="", id=1:15, stringsAsFactors=FALSE)
algos[1,1] <- "parRF_caret"
algos[2,1] <- "svm_C"
algos[3,1] <- "svmPoly_caret"
algos[4,1] <- "elm_kernel_matlab"
algos[5,1] <- "C5.0_caret"
algos[6,1] <- "avNNet_caret"
algos[7,1] <- "Bagging_LibSVM_weka"
algos[8,1] <- "RotationForest_weka"
algos[9,1] <- "graBoost_sklearn"
algos[10,1] <- "glmnet_R"
algos[11,1] <- "pcaNNet_caret"
algos[12,1] <- "svmRadialCost_caret"
algos[13,1] <- "RF_sklearn"
algos[14,1] <- "MultiBoostAB_LibSVM_weka"
algos[15,1] <- "fda_caret"
n=15
for (i in 1:15){
  algos[i,2] <- paste(algos_family[algos[i,1],"Family"],algos[i,1], sep=" - ")
  algos[i,3] <- rainbow(n, s = 1, v = 1, start = 0, end = max(1, n - 1)/n, alpha = 1)[i]
}
# n = 15
# rainbow(n, s = 1, v = 1, start = 0, end = max(1, n - 1)/n, alpha = 1)
# heat.colors(n, alpha = 1)
# terrain.colors(n, alpha = 1)
# topo.colors(n, alpha = 1)
# cm.colors(n, alpha = 1)
save(algos, file="data/algos.Rda")
colors <- setNames(as.vector(algos$color), algos$Algorithm)
selected_algos <- split(algos$Algorithm, algos$FullName)