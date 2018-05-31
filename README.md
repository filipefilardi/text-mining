# text-mining

Text mining generic script made with [tm package](https://github.com/cran/tm) to use as input in machine learning techniques, such as text clustering or text classification.

## Corpus

[20 newsgroup dataset](http://qwone.com/~jason/20Newsgroups/) with 20 clusters.

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
