# detailed fields
library(tidyverse)
library(lubridate)

df <- read_csv("pubdate.csv") %>%
  select(-row, -work_id, -pmcid_alex, -concept_id, -publication_date) %>%
  filter(level==1) %>%
  select(-level)


df %>%
  group_by(id) %>%
  slice_max(score) ->
  df_concept


df_concept %>%
  select(-score,-publication_year) ->
  df_c
  


df_article_unique_software_count  <- read_csv("df_article_unique_software_count.csv") %>%
  filter(type=="research-article")

df_article_info <- read_csv("kg_article_info.csv") %>%
  mutate(year = year(year)) %>% 
  select(id, year, type) %>%
  filter(year > 2000)

df_article_software <- read_csv("kg_article_software_all.csv") %>%
  select(-n)

df_software_names <- read_csv("kg_software.csv") %>%
  group_by(id) %>%
  arrange(desc(ratio)) %>%
  slice_head(n=1) %>%
  select(-ratio)


df_article_unique_software_count %>%
  inner_join(df_c, by =c("id"="id")) %>%
  select(-type) %>%
  rename(concept=display_name)->
  df_article_concepts


df_article_concepts %>%
  group_by(concept, has_software=n_software>0) %>%
  summarise(n_articles=n_distinct(id), .groups = 'drop') %>%
  group_by(concept) %>%
  mutate(r_articles = n_articles/sum(n_articles)) %>%
  mutate(order=ifelse(has_software,0,n_articles)) %>%
  ungroup() %>%
  #mutate(concept = fct_reorder(concept, desc(r_articles))) %>%
  ggplot(aes(reorder(concept,-order),n_articles)) +
  geom_col(aes(fill=has_software)) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1), 
        legend.position = "top",
        plot.title = element_text("Relative Frequency of Articles with Software per Top Level Discipline"))  +
  scale_fill_brewer(palette = 'Set1') + 
  xlab("Open Alex Concept") + 
  ylab("Frequency")



df_article_concepts %>%
  group_by(concept, has_software=n_software>0) %>%
  summarise(n_articles=n_distinct(id), .groups = 'drop') %>%
  group_by(concept) %>%
  mutate(r_articles = n_articles/sum(n_articles)) %>%
  mutate(order=ifelse(has_software,0,r_articles)) %>%
  ungroup() %>%
  #mutate(concept = fct_reorder(concept, desc(r_articles))) %>%
  ggplot(aes(reorder(concept,order),r_articles)) +
  geom_col(aes(fill=has_software)) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1), 
        legend.position = "top",
        plot.title = element_text("Relative Frequency of Articles with Software per Top Level Discipline"))  +
  scale_fill_brewer(palette = 'Set1') + 
  xlab("Open Alex Concept") + 
  ylab("Frequency")


df_article_concepts %>%
  inner_join(df_article_info, by = "id") %>%  
  group_by(concept, year, has_software=n_software>0) %>%
  summarise(n_articles=n_distinct(id), .groups = 'drop') %>%
  group_by(concept, year) %>%
  mutate(r_articles = n_articles/sum(n_articles)) %>%
  mutate(order=ifelse(has_software,0,r_articles)) %>%
  ungroup() %>%
  filter(has_software) %>%
  ggplot(aes(year, concept)) + 
  geom_tile(aes(fill=r_articles)) + 
  geom_text(aes(label=round(r_articles, digits = 2))) + 
  scale_fill_viridis_c("Ratio of articles with software") + 
  theme(legend.position = "top",
        plot.title = element_text("Relative Frequency of Articles with Software per Top Level Discipline over time"))  +
  xlab("Year") + 
  ylab("Frequency")


# top sofware per discipline
df_article_concepts %>%
  inner_join(df_article_software, by = c("id"="article_id"), relationship="many-to-many") %>%
  group_by(concept, software_id) %>%
  summarise(n_articles = n_distinct(id), .groups = 'drop') %>%
  group_by(concept) %>%
  slice_max(n_articles, n=20) %>%
  inner_join(df_software_names, by=c("software_id" = "id")) ->
  df_concept_top_software



df_concept_top_software %>%
  group_by(software_id) %>%
  mutate(n_software_articles = sum(n_articles)) %>%
  ungroup() %>%
  mutate(name = reorder(name, -n_software_articles)) %>%
  group_by(concept) %>%
  arrange(desc(n_articles)) %>%
  mutate(concept_order = row_number()) %>%
  ungroup() %>%
  filter(concept_order <=10) %>%
  mutate(text_color=concept_order>=7) %>%
  ggplot(aes(name, concept)) + 
  geom_tile(aes(fill=concept_order)) + 
  geom_text(aes(label=concept_order, color=text_color))  +
  theme(axis.text.x = element_text(angle = 60, hjust = 1), 
        legend.position = 'none')  +
  xlab("Open Alex Concept") + 
  xlab("Software") + 
  ggtitle("Top Software per Discipline") + 
  scale_fill_viridis_c(direction = -1) + 
  scale_color_manual(values=c("black","white"))