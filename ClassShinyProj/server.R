###############################################################
# Coursera Capstone Project: Next Word Prediction  
#  
#  1. Set up environment
#  2. Read in data: 2, 3, 4 NGram data formatted as data table
#  3. Clean up and standardize the format of the input
#  4. Predict the next word
#  5. Render the output
#
##############################################################  

options(shiny.maxRequestSize=95&1024^2)

suppressWarnings(library(shiny))
suppressWarnings(library(tm))
suppressWarnings(library(wordcloud))
suppressWarnings(library(data.table))

##############################################################
#
# Read in the data
#
##############################################################

# Read in data table
myNGrams <- data.table(read.csv("../Data/combinedDT.csv", header=TRUE))

#############################################################
#
# Functions to clean the intput
# 
#############################################################

# http://stackoverflow.com/questions/9934856/removing-non-ascii-characters-from-data-files
removeNonASCII <-
        content_transformer(function(x) iconv(x, "latin1", "ASCII", sub=""))

# http://stackoverflow.com/questions/8697079/remove-all-punctuation-except-apostrophes-in-r
removeCustomPunctuation <- content_transformer(function(x) {
        x <- gsub("(.*?)($|'|[^[:punct:]]+?)(.*?)", "\\2", tolower(x))
        return(x)})

## Clean up the input text
cleanText <- function(textVector) 
{
        # Remove duplicate characters  
          textVector <- gsub('([[:alpha:]])\\1+', '\\1\\1', tolower(textVector))
        
        # Create corpus  
          theCorpus <- Corpus(VectorSource(textVector))
       
        # Remove non-ASCII 
          theCorpus = tm_map(theCorpus, removeNonASCII, mc.cores=1)  
        
        # Remove default sop words 
          theCorpus <- tm_map(theCorpus, removeWords, stopwords("english"))

        # Remove numbers 
          theCorpus = tm_map(theCorpus, removeNumbers, mc.cores=1)
        
        # Remove punctuation  
          theCorpus = tm_map(theCorpus, removeCustomPunctuation, mc.cores=1)
        
        # Remove whitespace  
          theCorpus = tm_map(theCorpus, stripWhitespace, mc.cores=1)
        
          textVector  <- unlist(lapply(theCorpus, 
                                     function(x) return(x[1]$content)))
          return(textVector)    
}       


#############################################################
#
# Function to predict the next word
#
#############################################################
predictNextWord <- function(text) {
        words_list <- strsplit(text, split = " ")
        words <- words_list[[1]]
        nWords <- length(words)
        if (nWords > 3) {
                lookupWords <- paste(words[nWords - 3], words[nWords - 2], words[nWords - 1], words[nWords], collapse = " ")
                result <- as.character(myNGrams[look==lookupWords,output[1:3]])
                if (is.na(result[1])) {       
                        words <- c(words[nWords - 2], words[nWords - 1], words[nWords])  
                        nWords = 3
                }
        }
        if (nWords ==3 ) {       
                lookupWords <- paste(words[nWords - 2], words[nWords - 1], words[nWords])
                result <- as.character(myNGrams[look==lookupWords,output[1:3]])
                if (is.na(result[1])) {       
                        words <- c(words[nWords - 1], words[nWords])  
                        nWords = 2
                }
        }
        if (nWords == 2) {
                lookupWords <- paste(words[nWords - 1], words[nWords])
                result <- as.character(myNGrams[look==lookupWords,output[1:3]])
                if (is.na(result[1])) {       
                        result <- c("<Not Available>") 
                }
        }
        if (nWords < 2) {
                result <- c("<Not Available") 
        }
        result
}     

###############################################################
#
#  Server logic to process the input and render the prediction 
#
###############################################################
shinyServer(function(input, output) {
        
        output$text <- renderText({ 
                str1 <- cleanText(input$text); 
        })
        
        output$view <- renderText({ 
                str2 <- predictNextWord(cleanText(input$text));
        })
        
        output$wcloud <- renderPlot({
              title <- "Word Cloud for Input Text"
              wordcloud(myNGrams$look[100:150], 
                        myNGrams$sum[100:150],c(5,.3),50,
                        random.order=FALSE,colors=brewer.pal(8, "Dark2")) 
        })
 
})
