#Load library
library(babynames)
library(tidyverse)
bb_names<-babynames

#Make a histogram for the name Marie
ggplot(data=bb_names %>% filter(name=="Marie", year>="1982"))+
  geom_col(aes(x=year, y=n, fill='red'))

#Create a line plot for proportion of the name Joe, colored by sex. Make the lines a bit thicker and more transparent.
ggplot(data=bb_names %>% filter(name=="Joe"))+
  geom_line(aes(y=prop, x=year, color=sex), alpha=0.5, lwd=2)

#Add new x and y axis labels, as well as a chart title.
ggplot(data=bb_names %>% filter(name=="Joe"))+
  geom_line(aes(y=prop, x=year, color=sex), alpha=0.5, lwd=2)+
  labs(x="Year", y="Propotion", color="Sex", title="Propotion of the name Joe")

#Create a bar chart of all female names in 2002.
ggplot(data=bb_names %>% filter(sex=="F", year=="2002", name %in% c("Abigail", "Sarah", "Emma", "Emily", "Olivia", "Madison", "Hannah", "Alexis", "Ashley", "Samantha")))+
  geom_col(aes(x=name, y=n))

#Make the bars transparent and filled with the color blue.
ggplot(data=bb_names %>% filter(sex=="F", year=="2002", name %in% c("Abigail", "Sarah", "Emma", "Emily", "Olivia", "Madison", "Hannah", "Alexis", "Ashley", "Samantha")))+
  geom_col(aes(x=name, y=n), alpha=0.7, fill='lightgreen')
 
#Create a new data set called the_nineties that only contains years from the 1990s.
the_nineties<-bb_names %>% filter(year>=1990, year<2000)

#Save this dataset to your repository (use write_csv()).
write_csv(the_nineties, file="babynames_90s.csv")

#Add, commit, and push your files to GitHub.     
#RStudio pull from GitHub. Is it already up to date?

  
#Now that everything is up to date, make a visualisation of you and your team member’s names for a year of your choice.


#Make a visual that looks at your name over time. What happens if you color by sex?

 
#Don’t forget to stage/add, commit, and push your hardwork to GitHub!