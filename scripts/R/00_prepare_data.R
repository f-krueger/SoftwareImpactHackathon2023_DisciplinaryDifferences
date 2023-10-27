# create data from CSVs fro OpenAlex matches

library(tidyverse)

df_article_info <- read_csv("kg_article_info.csv")
df_article_software <- read_csv("kg_article_software_all.csv")


n_distinct_na <- function(v){
  ifelse(any(is.na(v)),0,n_distinct(v))
}

df_article_info %>%
  left_join(df_article_software, by = c('id'='article_id')) %>%
  select(id, type, software_id) %>%
  group_by(id, type) %>%
  summarise(n_software=n_distinct_na(software_id)) ->
  df_article_unique_software_count

write_csv(df_article_unique_software_count, "df_article_unique_software_count.csv")


df_software_names <- read_csv("kg_software.csv")

df_software_names %>%
  group_by(id) %>%
  arrange(desc(ratio)) %>%
  slice_head(n=1) ->
  df_software_name_map

df_article_software %>%
  left_join(df_software_name_map, by = c("software_id"="id")) %>%
  select(article_id, software_id, name) ->
  df_article_software_id_name

write_csv(df_article_software_id_name, "df_article_software_id_name.csv")
