library(ngram)
corp_str <- concatenate(lapply(corp_dat,"[", 1))



ng2 <- ngram(str = corp_str,n = 2)
print(ng2,output="truncated")
ng_phrs_tbl2 <- get.phrasetable(ng2)
ng_phrs_tbl2 <- ng_phrs_tbl2[order(ng_phrs_tbl2[,2],decreasing = TRUE),]
head(ng_phrs_tbl2)

ng3 <- ngram(str = corp_str,n = 3)
print(ng3,output="truncated")
ng_phrs_tbl3 <- get.phrasetable(ng3)
ng_phrs_tbl3 <- ng_phrs_tbl3[order(ng_phrs_tbl3[,2],decreasing = TRUE),]
head(ng_phrs_tbl3)

ng4 <- ngram(str = corp_str,n = 4)
print(ng4,output="truncated")
ng_phrs_tbl4 <- get.phrasetable(ng4)
ng_phrs_tbl4 <- ng_phrs_tbl4[order(ng_phrs_tbl4[,3],decreasing = TRUE),]
head(ng_phrs_tbl4)


