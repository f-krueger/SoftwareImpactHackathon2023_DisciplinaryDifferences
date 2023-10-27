# layer based analysis

library(tidyverse)

df <- read_csv("10k_sample_L1_L2_analysis.csv")

df %>%
  select(L0_domain, L0_sw_count, L1_sw_count, L1_L0_sw_count)


df %>%
  group_by(L0_domain) %>%
  summarise(mean_L0 = mean(L0_sw_count), mean_L1 = mean(L1_sw_count), mean_total = mean(L1_L0_sw_count), .groups = 'drop') %>%
  mutate(val=mean_L1/mean_L0) %>%
  pivot_longer(cols=c("mean_L0", "mean_L1", "mean_total")) %>%
  ggplot(aes(reorder(L0_domain,-val), value)) + 
  geom_col(aes(fill=name), position = 'dodge')  +
  theme(axis.text.x = element_text(angle = 60, hjust = 1), 
        legend.position = 'top')  +
  xlab("Open Alex Concept") + 
  ylab("Number of unique software mentions") + 
  scale_fill_discrete("Source", labels = c('Original Article','Citated Article','Total')) 
  
  
df %>%
  group_by(L0_domain) %>%
  summarise(mean_L0 = mean(L0_sw_count), mean_L1 = mean(L1_sw_count), mean_total = mean(L1_L0_sw_count), .groups = 'drop') %>%
  ggplot(aes(mean_L0, mean_L1)) + 
  geom_label(aes(label=L0_domain))  +
  geom_smooth(method='lm', formula = 'y~x') +
  xlab("Software in Original Article") + 
  ylab("Software in Cited Articles") + 
  scale_fill_discrete("Source", labels = c('Original Article','Citated Article','Total')) +
  ggtitle("")

