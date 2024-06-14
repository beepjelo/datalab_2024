#Loading
library(ggplot2)
library(dplyr)
library(tidytext)
library(gsheet)
library(wordcloud2)
library(sentimentr)
library(lubridate)
library(tidyverse)

#Read survey
survey <- gsheet::gsheet2tbl('https://docs.google.com/spreadsheets/d/1W9eGIihIHppys3LZe5FNbUuaIi_tfdscIq521lidRBU/edit?usp=sharing')

#Create a new variable
survey<-survey %>% 
  mutate(date_time=mdy_hms(Timestamp))

#Visualization
ggplot(data=survey, aes(x=date_time))+
  geom_histogram()

#New object
sentiments <- get_sentiments('bing')

#Explore sentiments
nrow(sentiments)
ncol(sentiments)
names(sentiments)

#New object again
words <- survey %>%
  dplyr::select(first_name,
                feeling_num,
                feeling) %>%
  unnest_tokens(word, feeling)

#Follow by who did the survey first and follow by words by words that describe their feeling (Q10)

#Making word cloud
word_freq <- words %>% 
  group_by(word) %>% 
  tally()
wordcloud2(word_freq)

#New object again x2
sw <- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/stopwords.csv')

#Words duhhhh

#Remove from word_freq any rows in which the word appears in sw.
word_freq2<- anti_join(word_freq, sw, by="word")

# word_freq3 <- word_freq %>% 
#   filter(!word %in% sw$word)

#Make a new word cloud
wordcloud2(word_freq2, size = 1, minSize = 0, gridSize =  0,
           fontFamily = 'Segoe UI', fontWeight = 'bold',
           color = 'random-dark', backgroundColor = "white",
           minRotation = -pi/4, maxRotation = pi/4, shuffle = TRUE,
           rotateRatio = 0.4, shape = 'circle', ellipticity = 0.65,
           widgetsize = NULL, figPath = NULL, hoverFunction = NULL)

#Make a new object
top10<- head(word_freq[order(-word_freq$n),],10)
#top10<-word_freq %>% arrange(desc(n)) %>% 
#head(10)

#Bar chart for top 10
ggplot(data=top10, aes(x=word, y=n, fill=word))+
  geom_col()

#Join word_freq with sentiments
sentiment_freq<-left_join(word_freq, sentiments, by="word")

#Now explore the data. What is going on?
#There's a lot of NAs...

#For the whole survey, were there more negative or positive sentiment words used?
table(sentiment_freq$sentiment)

#Create an object with the number of negative and positive words used for each person.
sentiment_by_person <-left_join(words, sentiments, by="word")
table(sentiment_by_person$sentiment, sentiment_by_person$first_name)

#In that object, create a new variable named sentimentality, which is the number of positive words minus the number of negative words.


#Make a histogram of senitmentality
# 

#Make a barplot of sentimentality.
# 

#Create a wordcloud for the dream variable.
# 

#Create a barplot showing the top 16 words in our dreams.
# 

#Which word showed up most in people’s description of Joe?
#   

#Make a histogram of feeling_num.
# 

#Make a density chart of feeling_num.
# 

#Change the above plot to facet it by gender.
# 

#How many people mentioned Ryan Gosling in their description of Joe?
#   

#Is there a correlation between the sentimentality of people’s feeling and their feeling_num?
