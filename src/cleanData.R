library(tm)
library(dplyr)
library(stringr)

# Function to remove emails
removeEmail <- function(X) {
	str_replace_all(X, "[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+", "")
} 

# Funtion to remove most common terms by percentage
removeCommonTerms <- function (X, percentage) {
	x <- t(X)
	t <- table(x$i) < x$ncol * percentage
	X[, as.numeric(names(t[t]))]
}

# Using pipes to not allocate extra memmory
Corpus(
    DirSource(
        "/home/filipe/Desktop/text-mining/corpus/20_newsgroup/texts",
        encoding = "UTF-8",                     # encoding used
        recursive = TRUE,                       # read folder recursevly
        ignore.case = FALSE,                    # case sensitive
        mode = "text"                           # document mode
    ),
    readerControl = list(
        reader = readPlain,
        language = "en"
    )
) %>%
tm_map(content_transformer(tolower)) %>%        # no uppercase
tm_map(content_transformer(removeEmail)) %>%    # remove email
tm_map(removeNumbers) %>%                       # no numbers
tm_map(removeWords, stopwords('en')) %>%        # remove stopwords
tm_map(removePunctuation) %>%                   # no punctuation
tm_map(stripWhitespace) %>%                     # no extra whitespaces
tm_map(stemDocument) %>%                        # reduce to radical
DocumentTermMatrix(
    control = list(
        weighting = weightTfIdf,
        wordLengths = c(2,16),                  # radical between 2 and 16
        minDocFreq = 1                          # appears at least 1 times
    )
) %>%
removeSparseTerms(0.99) %>%                     # at least in 1% documents
removeCommonTerms(0.50) %>%                     # maximun 50% documents
as.matrix(tdm) %>%                              # to matrix
write.csv2(file = "/home/filipe/Desktop/text-mining/data/20_newsgroup/result_tf_idf.csv")

