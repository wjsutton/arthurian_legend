
library(dplyr)

book_df <- read.csv("data/le_morte_darthur.csv", stringsAsFactors = F)
tagging_df <- read.csv("data/character_tagging.csv", stringsAsFactors = F)
sections_df <- read.csv("data/text_sections.csv", stringsAsFactors = F)
layout_df <- read.csv("data/tableau_timeline_layout.csv", stringsAsFactors = F)

book_df$id <- c(1:nrow(book_df))

combined_file <- dplyr::left_join(book_df,layout_df, by = c('id' = 'id'))
combined_file <- dplyr::left_join(combined_file,sections_df, by = c('id' = 'id'))
combined_file <- dplyr::left_join(combined_file,tagging_df, by = c('id' = 'id'))

write.csv(combined_file,'data/arthurian_legend_full.csv', row.names = F)
