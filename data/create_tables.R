
# Read results from (http://persoal.citius.usc.es/manuel.fernandez.delgado/papers/jmlr/results.txt)
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

mean(results[,"rbfDDA_caret"], na.rm = TRUE)
save(results, file="data/results.Rda")


# Create datasets information file
# using the information on TABLE1 & TABLE2
# Some names are not the same in restults and the tables

info_tables = data.frame(matrix(NA, nrow=dim(results)[1], ncol=4))
colnames(info_tables) <- c("obs", "features", "classes", "%majority")
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

# ADD algorithm group
load(file="data/results.Rda")

nj = dim(results)[2]
algos_family = vector("list", nj) 
algos_family[1] = 'DA'
algos_family[2] = 'DA'
algos_family[3] = 'DA'
algos_family[4] = 'DA'
algos_family[5] = 'DA'
algos_family[6] = 'DA'
algos_family[7] = 'DA'
algos_family[8] = 'DA'
algos_family[9] = 'DA'
algos_family[10] = 'DA'
algos_family[11] = 'DA'
algos_family[12] = 'DA'
algos_family[13] = 'DA'
algos_family[14] = 'DA'
algos_family[15] = 'DA'
algos_family[16] = 'DA'
algos_family[17] = 'DA'
algos_family[18] = 'DA'
algos_family[19] = 'DA'
algos_family[20] = 'DA'
algos_family[21] = 'BY'
algos_family[22] = 'BY'
algos_family[23] = 'BY'
algos_family[24] = 'BY'
algos_family[25] = 'BY'
algos_family[26] = 'NNET'
algos_family[27] = 'NNET'
algos_family[28] = 'NNET'
algos_family[29] = 'NNET'
algos_family[30] = 'NNET'
algos_family[31] = 'NNET'
algos_family[32] = 'NNET'
algos_family[33] = 'NNET'
algos_family[34] = 'NNET'
algos_family[35] = 'NNET'
algos_family[36] = 'NNET'
algos_family[37] = 'NNET'
algos_family[38] = 'NNET'
algos_family[39] = 'NNET'
algos_family[40] = 'NNET'
algos_family[41] = 'NNET'
algos_family[42] = 'NNET'
algos_family[43] = 'NNET'
algos_family[44] = 'NNET'
algos_family[45] = 'SVM'
algos_family[46] = 'SVM'
algos_family[47] = 'SVM'
algos_family[48] = 'SVM'
algos_family[49] = 'SVM'
algos_family[50] = 'SVM'
algos_family[51] = 'SVM'
algos_family[52] = 'SVM'
algos_family[53] = 'SVM'
algos_family[54] = 'DT'
algos_family[55] = 'DT'
algos_family[56] = 'DT'
algos_family[57] = 'DT'
algos_family[58] = 'DT'
algos_family[59] = 'DT'
algos_family[60] = 'DT'
algos_family[61] = 'DT'
algos_family[62] = 'DT'
algos_family[63] = 'DT'
algos_family[64] = 'RL'
algos_family[65] = 'RL'
algos_family[66] = 'DT'
algos_family[67] = 'RL'
algos_family[68] = 'RL'
algos_family[69] = 'RL'
algos_family[70] = 'RL'
algos_family[71] = 'RL'
algos_family[72] = 'RL'
algos_family[73] = 'RL'
algos_family[74] = 'RL'
algos_family[75] = 'RL'
algos_family[76] = 'RL'
algos_family[77] = 'BST'
algos_family[78] = 'BST'
algos_family[79] = 'BST'
algos_family[80] = 'BST'
algos_family[81] = 'BST'
algos_family[82] = 'BST'
algos_family[83] = 'BAG'
algos_family[84] = 'BAG'
algos_family[85] = 'BAG'
algos_family[86] = 'BAG'
algos_family[87] = 'BAG'
algos_family[88] = 'BAG'
algos_family[89] = 'BAG'
algos_family[90] = 'BAG'
algos_family[91] = 'BAG'
algos_family[92] = 'BAG'
algos_family[93] = 'STC'
algos_family[94] = 'STC'
algos_family[95] = 'RF'
algos_family[96] = 'RF'
algos_family[97] = 'RF'
algos_family[98] = 'RF'
algos_family[99] = 'RF'
algos_family[100] = 'RF'
algos_family[101] = 'RF'
algos_family[102] = 'OEN'
algos_family[103] = 'OEN'
algos_family[104] = 'OEN'
algos_family[105] = 'OEN'
algos_family[106] = 'OEN'
algos_family[107] = 'OEN'
algos_family[108] = 'OEN'
algos_family[109] = 'OEN'
algos_family[110] = 'OEN'
algos_family[111] = 'OEN'
algos_family[112] = 'OM'
algos_family[113] = 'GLM'
algos_family[114] = 'GLM'
algos_family[115] = 'GLM'
algos_family[116] = 'GLM'
algos_family[117] = 'GLM'
algos_family[118] = 'NN'
algos_family[119] = 'NN'
algos_family[120] = 'NN'
algos_family[121] = 'NN'
algos_family[122] = 'NN'
algos_family[123] = 'PLSR'
algos_family[124] = 'PLSR'
algos_family[125] = 'PLSR'
algos_family[126] = 'PLSR'
algos_family[127] = 'PLSR'
algos_family[128] = 'PLSR'
algos_family[129] = 'LMR'
algos_family[130] = 'LMR'
algos_family[131] = 'LMR'
algos_family[132] = 'MARS'
algos_family[133] = 'MARS'
algos_family[134] = 'OM'
algos_family[135] = 'OM'
algos_family[136] = 'OM'
algos_family[137] = 'OES'
algos_family[138] = 'OM'
algos_family[139] = 'OM'
algos_family[140] = 'OM'
algos_family[141] = 'OM'
algos_family[142] = 'OM'
algos_family[143] = 'OM'
algos_family[144] = 'SVM'
algos_family[145] = 'NNET'

save(algos_family, file="data/algos_family.Rda")
