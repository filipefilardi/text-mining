# text-mining

Text mining generic script made with [tm package](https://github.com/cran/tm) to use as input in machine learning techniques, such as text clustering or text classification.

## Corpus

[20 newsgroup dataset](http://qwone.com/~jason/20Newsgroups/) with 20 classes.

RemoveSparseTerms is the most function to apply in your dataset, otherwise you'll get a huge document term matrix such as:

```R
<<DocumentTermMatrix (documents: 18828, terms: 90779)>>
Non-/sparse entries: 1684692/1707502320
Sparsity           : 100%
Maximal term length: 16
Weighting          : term frequency - inverse document frequency (normalized) (tf-idf)
```

The following tests were made to see how different is the output when the percentage in removeTerms function is higher or lower.

### test one

**input**

```R
removeSparseTerms(0.99) %>%
removeCommonTerms(0.50) 
```
**output**

```R
<<DocumentTermMatrix (documents: 18828, terms: 1648)>>
Non-/sparse entries: 1094789/29933755
Sparsity           : 96%
Maximal term length: 12
Weighting          : term frequency - inverse document frequency (normalized) (tf-idf)
```
### test two

**input**

```R
removeSparseTerms(0.95) %>%
removeCommonTerms(0.50) 
```
**output**

```R
<<DocumentTermMatrix (documents: 18828, terms: 290)>>
Non-/sparse entries: 544083/4916037
Sparsity           : 90%
Maximal term length: 10
Weighting          : term frequency - inverse document frequency (normalized) (tf-idf)
```
### test three

**input**

```R
removeSparseTerms(0.90) %>%
removeCommonTerms(0.75) 
```
**output**

```R
<<DocumentTermMatrix (documents: 18828, terms: 292)>>
Non-/sparse entries: 566838/4930938
Sparsity           : 90%
Maximal term length: 10
Weighting          : term frequency - inverse document frequency (normalized) (tf-idf)
```
