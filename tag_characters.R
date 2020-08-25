library(stringr)

book_df <- read.csv("data/le_morte_darthur.csv", stringsAsFactors = F)

book_df$id <- c(1:nrow(book_df))
book_df$text_lower <- tolower(book_df$text)
book_df <- book_df[,c('id','text_lower')]

book_df$arthur <- grepl('arthur',book_df$text_lower)
book_df$merlin <- grepl('merlin',book_df$text_lower)
book_df$guenever <- grepl('guenever',book_df$text_lower)
book_df$launcelot <- grepl('launcelot',book_df$text_lower)
book_df$lady_of_the_lake <- grepl('lady of the lake|damosel of the lake',book_df$text_lower)
book_df$galahad <- grepl('galahad',book_df$text_lower)
book_df$mordred <- grepl('mordred',book_df$text_lower)
book_df$tristram <- grepl('tristram',book_df$text_lower)

book_df$jousting <- grepl('joust',book_df$text_lower)
book_df$dragons <- grepl(' dragon',book_df$text_lower)
book_df$holy_grail <- grepl('sangreal',book_df$text_lower)
book_df$excalibur_and_scabbard <- grepl('scabbard|excalibur',book_df$text_lower)

book_df$arthur <- gsub('FALSE',1,gsub('TRUE','',book_df$arthur))
book_df$merlin <- gsub('FALSE',1,gsub('TRUE','',book_df$merlin))
book_df$guenever <- gsub('FALSE',1,gsub('TRUE','',book_df$guenever))
book_df$launcelot <- gsub('FALSE',1,gsub('TRUE','',book_df$launcelot))
book_df$lady_of_the_lake <- gsub('FALSE',1,gsub('TRUE','',book_df$lady_of_the_lake))
book_df$galahad <- gsub('FALSE',1,gsub('TRUE','',book_df$galahad))
book_df$mordred <- gsub('FALSE',1,gsub('TRUE','',book_df$mordred))
book_df$tristram <- gsub('FALSE',1,gsub('TRUE','',book_df$tristram))

book_df$jousting <- gsub('FALSE',1,gsub('TRUE','',book_df$jousting))
book_df$dragons <- gsub('FALSE',1,gsub('TRUE','',book_df$dragons))
book_df$holy_grail <- gsub('FALSE',1,gsub('TRUE','',book_df$holy_grail))
book_df$excalibur_and_scabbard <- gsub('FALSE',1,gsub('TRUE','',book_df$excalibur_and_scabbard))

write.csv(book_df,'data/character_tagging.csv',row.names = F)
