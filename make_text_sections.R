# Tableau text box requires text to be less than 1500 characters
# aim - split text in up to 5 1,500 character sections,
# splitting text only at a full stop
library(stringr)

book_df <- read.csv("data/le_morte_darthur.csv", stringsAsFactors = F)


book_df$id <- c(1:nrow(book_df))
book_df$len <- nchar(book_df$text)

#stringr::str_locate_all()
#stringr::str_locate_all(book_df$text,"\\.")[[1]]

# full stops in first
for(i in seq_along(book_df$id)){

  full_stops <- stringr::str_locate_all(book_df$text,"\\.")[[i]][,1]
  sec1_end <- max(full_stops[full_stops<1500])
  
  sec2_stops <- full_stops[full_stops>=1500]
  sec2_end <- ifelse(length(sec2_stops),max(sec2_stops[sec2_stops<3000]),book_df$len[i])
  
  sec3_stops <- sec2_stops[sec2_stops>=3000]
  sec3_end <- ifelse(length(sec3_stops),max(sec3_stops[sec3_stops<4500]),book_df$len[i])
  
  sec4_stops <- sec3_stops[sec3_stops>=4500]
  sec4_end <- ifelse(length(sec4_stops),max(sec4_stops[sec4_stops<6000]),book_df$len[i])
  
  sec5_stops <- sec4_stops[sec4_stops>=6000]
  sec5_end <- ifelse(length(sec5_stops),max(sec4_stops[sec5_stops<7500]),book_df$len[i])
  
  sec1_text <- substr(book_df$text[i],0,sec1_end)
  sec2_text <- substr(book_df$text[i],ifelse(sec1_end==book_df$len[i],sec1_end,sec1_end+1),sec2_end)
  sec3_text <- substr(book_df$text[i],ifelse(sec2_end==book_df$len[i],sec2_end,sec2_end+1),sec3_end)
  sec4_text <- substr(book_df$text[i],ifelse(sec3_end==book_df$len[i],sec3_end,sec3_end+1),sec4_end)
  sec5_text <- substr(book_df$text[i],ifelse(sec4_end==book_df$len[i],sec4_end,sec4_end+1),sec5_end)
  
  sec1_text <- trimws(sec1_text,"both")
  sec2_text <- trimws(sec2_text,"both")
  sec3_text <- trimws(sec3_text,"both")
  sec4_text <- trimws(sec4_text,"both")
  sec5_text <- trimws(sec5_text,"both")
  
  entry <- c(book_df$id[i],sec1_text,sec2_text,sec3_text,sec4_text,sec5_text)

  if(i == 1){
    text_sections <- data.frame(id=entry[1],section1_text=sec1_text,section2_text=sec2_text,section3_text=sec3_text,section4_text=sec4_text,section5_text=sec5_text, stringsAsFactors = F)
  }
  
  if(i != 1){
    text_sections <- rbind(text_sections,entry)
  }

}

write.csv(text_sections,"data/text_sections.csv",row.names = F)