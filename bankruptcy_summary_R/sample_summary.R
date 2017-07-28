# 2017-05-04, Feng Mai
# Sample summary stats and ploting

library(tidyverse)
library(lubridate)

# 1. Number of bankruptcies per year
# ========================================
final_sample <- read_csv("../data/final_sample.csv")

n_bk_per_year <- final_sample %>% group_by(fyear) %>% summarise (n = n(), Y = sum(Y)) %>%
  mutate(rate = Y / n )
ggplot(data = n_bk_per_year, aes(x = fyear, y = rate)) + geom_line() + xlab("") + ylab("Percentage of Bankrupted Firms") + scale_x_continuous(breaks = c(1994:2014)) + scale_y_continuous(labels= scales::percent) + annotate("text", x = 1998, y = 0.01, label = "Asian Financial Crisis", size = 3) + annotate("text", x = 2008, y = 0.012, label = "The Great Recession", size = 3) + annotate("text", x = 2001, y = 0.0075, label = "Burst of Dot-com Bubble", size = 3) + 
  theme_light(base_size =  10) 

final_sample %>% distinct(gvkey) %>% count()
final_sample %>% summarise(sum(Y))
n_bk_per_year %>% write_csv("../../../manuscript/table_figs/year_dist.csv")
ggsave("../../../manuscript/table_figs/rate_bk.png", width = 8, height = 3.5, units = 'in')
