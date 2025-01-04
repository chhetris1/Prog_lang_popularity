library(readr)
library(dplyr)
library(ggplot2)

data <- read_csv("stack_overflow_data.csv")

#task: analyze the no. of questions with R each year compared to the total no. 
#of questions across all tags per year. 
#OR: Has R been growing or shrinking over years? 
data_percentage <- data %>% 
  mutate(percentage = num_questions/year_total*100)

r_over_time <- data_percentage %>% 
    filter(tag == "r")

ggplot(r_over_time, aes(x = year, y = percentage)) +geom_line()  

r_tag_2020 <- data_percentage %>% filter(year == 2020 & tag == 'r')
#Almost 1% of total searches had R tag. 

#top 5 languages
sorted_tags <- data_percentage %>% filter(year >= 2015) %>% 
 group_by(tag) %>% 
  summarize(tag_total = sum(num_questions)) %>% 
  arrange(desc(tag_total))
highest_tags <- head(sorted_tags$tag, n = 5)
highest_tags

#visualizing
data_subset <- data_percentage %>% 
  filter(tag %in% highest_tags, year >=2015 )
ggplot(data_subset, aes(x= year, y = percentage, color = tag))+
  geom_line()

#which tag experienced the largest year-to-year growth? 
data_perc_year <- data %>% 
  group_by(year) %>% 
  mutate(year_total = sum(num_questions))%>% 
  ungroup() %>%
  mutate(percentage = (num_questions/year_total)*100)

#calculate the ratio of percentage of questions for each tag compared to the
#previous year
tag_ratios_filtered <- data_perc_year %>% 
    arrange(tag, year) %>% 
    group_by(tag) %>%
    mutate(ratio = percentage/lag(percentage)) %>% 
    ungroup()
highest_ratios <- tag_ratios_filtered %>% slice_max(ratio, n=1)
highest_ratio_tag <- highest_ratios$tag
print(highest_ratio_tag)
