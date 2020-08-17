# Volume II
# http://www.gutenberg.org/files/1252/1252-h/1252-h.htm

library(rvest)
library(dplyr)
library(stringr)

vol1 <- 'http://www.gutenberg.org/files/1251/1251-h/1251-h.htm'
vol1_html <- read_html(vol1)


vol2 <- 'http://www.gutenberg.org/files/1252/1252-h/1252-h.htm'
vol2_html <- read_html(vol2)

volumes <- c(rep('VOLUME I',238),rep('VOLUME II',265))

vol1_books <- c(rep('BOOK I',27)
               ,rep('BOOK II',19)
               ,rep('BOOK III',15)
               ,rep('BOOK IV',28)
               ,rep('BOOK V',30)
               ,rep('BOOK VI',35)
               ,rep('BOOK VII',41)
               ,rep('BOOK VIII',43))

vol2_books <- c(rep('BOOK X',88)
                ,rep('BOOK XI',14)
                ,rep('BOOK XII',14)
                ,rep('BOOK XIII',20)
                ,rep('BOOK XIV',10)
                ,rep('BOOK XV',6)
                ,rep('BOOK XVI',17)
                ,rep('BOOK XVII',23)
                ,rep('BOOK XVIII',25)
                ,rep('BOOK XIX',13)
                ,rep('BOOK XX',22)
                ,rep('BOOK XXI',13))

books <- c(vol1_books,vol2_books)

text <- c(as.character(html_nodes(vol1_html,"div")),as.character(html_nodes(vol2_html,"div")))

text_clean <- text[grepl('<h3>',text)]
text_clean <- text_clean[!grepl('BIBLIOGRAPHICAL NOTE',text_clean)]
text_clean <- text_clean[!grepl('PREFACE OF WILLIAM CAXTON',text_clean)]
text_clean <- trimws(gsub('\\r\\n',' ',text_clean),which = 'both')

chapters <- stringr::str_extract(text_clean,'CHAPTER\\s[LXVI]*')


event_start <- as.integer(str_locate(text_clean,'<br>')[,2])
event_end <- as.integer(str_locate(text_clean,'</h3>')[,1])
events <- substr(text_clean,event_start+1,event_end-1)

text_start <- as.integer(str_locate(text_clean,'<p>')[,2])
text_end <- as.integer(str_locate(text_clean,'</div>')[,1])
texts <- substr(text_clean,text_start+1,text_end-1)
texts <- gsub('<p>','',texts)
texts <- gsub('<\\/p>','',texts)

book_df <- data.frame(volume=volumes,book=books,chapter=chapters,event=events,text=texts, stringsAsFactors = F)

write.csv(book_df,"data/le_morte_darthur.csv",row.names = F)
