Conclusions
===
<br />

Exhaustive evaluation of **179 classifiers** (+7) belonging to a wide collection of **17 families** over the whole UCI machine learning classification database

<br />

The best results are achieved by the **parallel random forest (parRF t)**, implemented in R with caret, tuning the parameter mtry, arising to **average accuracy 82.0%** 

<br />

**Seven RFs and five SVMs** are included among the 20 best classifiers, which are the
bests families

<br />

### - The parRF t may be considered as a reference (“gold-standard”)

<br />

### - The best results are obtain using the caret package*

*Not the same parameter search was made in sklearn [see code](https://github.com/WinVector/ExploreModels/blob/master/ScoreModels/processArffs.py#L85)
