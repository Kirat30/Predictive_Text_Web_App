predictWord <- function(primeSentence){
        primeSentence <- tolower(primeSentence)
        primeSentence <- Boost_tokenizer(primeSentence)
        ln <<- length(primeSentence)
        if(ln>=3){
                tripredict(primeSentence)
        }else if(ln==2){
                bipredict(primeSentence)
        }else if(ln==1){
                unipredict(primeSentence)
        }else{
                nullpredict()
        }
}

tripredict <- function(sentence){
        cols <- which(quadgram[1,]==sentence[ln-2])
        cols <- cols[which(quadgram[2,cols]==sentence[ln-1])]
        cols <- cols[which(quadgram[3,cols]==sentence[ln])]
        if(!is.na(quadgram[4,cols[1]])){
                if(any(!is.na(cols[2:3]))){
                        return(quadgram[4,cols[1:3]])
                }else{
                        cols[2:3] <- " "
                        return(quadgram[4,cols[1:3]])
                }
        }else{
                bipredict(sentence)
        }
}

bipredict <- function(sentence){
        cols <- which(trigram[1,]==sentence[ln-1])
        cols <- cols[which(trigram[2,cols]==sentence[ln])]
        if(!is.na(trigram[3,cols[1]])){
                if(any(!is.na(cols[2:3]))){
                        return(trigram[3,cols[1:3]])
                }else{
                        cols[2:3] <- " "
                        return(trigram[3,cols[1:3]])
                }
        }else{
                unipredict(sentence)
        }
        
}

unipredict <- function(sentence){
        cols <- which(bigram[1,]==sentence[ln])
        if(!is.na(bigram[2,cols[1]])){
                if(any(!is.na(cols[2:3]))){
                        return(bigram[2,cols[1:3]])
                }else{
                        cols[2:3] <- " "
                        return(bigram[2,cols[1:3]])
                }
        }else{
                ln <<- ln-1
                tripredict(sentence)
        }
        
}

nullpredict <- function(){
        return(sample(cnvstart,3,replace = FALSE))
}