library(tidyverse)


df <- read_csv("software_domain_nCount - bq-results-20231026-214023-1698356638186.csv") %>%
  select(-doi_alex, -work_id,  -software_id) 

df_concepts <- read_csv("df_OA_concepts.csv") %>%
  select(id=Id, concept=display_name)

df_article_unique_software_count <- read_csv("df_article_unique_software_count.csv") %>%
  inner_join(df_concepts, by=c("id"="id"))


df %>%
  distinct() %>%
  group_by(display_name) %>% 
  summarise(mean=mean(n_software), sd=sd(n_software)) %>%
  ggplot(aes(reorder(display_name, -mean), mean)) + 
  geom_point() + 
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd)) + 
  theme(axis.text.x = element_text(angle = 60, hjust = 1), 
        legend.position = 'none')  +
  ylab("Mean software per paper") + 
  xlab("Open Alex Concept") + 
  ggtitle("Mean number of software per article per discipline (subsample)")




df_article_unique_software_count %>%
  group_by(concept) %>% 
  summarise(mean=mean(n_software), sd=sd(n_software)) %>%
  ggplot(aes(reorder(concept, -mean), mean)) + 
  geom_point() + 
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd)) + 
  theme(axis.text.x = element_text(angle = 60, hjust = 1), 
        legend.position = 'none')  +
  ylab("Mean software per paper") + 
  xlab("Open Alex Concept") + 
  ggtitle("Mean number of software per article per discipline (full)")



df_article_unique_software_count %>%
  group_by(concept) %>% 
  summarise(mean=mean(n_software)) %>%
  ggplot(aes(reorder(concept, -mean), mean)) + 
  geom_col(aes(fill=mean)) + 
        theme(axis.text.x = element_text(angle = 60, hjust = 1), 
        legend.position = 'none')  +
  ylab("Median software per paper") + 
  xlab("Open Alex Concept") + 
  ggtitle("Mean number of software per article per discipline (full)")  + 
  scale_fill_viridis_c()

