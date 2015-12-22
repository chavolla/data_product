library(shiny)
secretW<-c('APPLE','PINEAPPLE','BANANA','CARROT','POMEGRANATE','ORANGE','RASPBERRY','GRAPEFRUIT','AVOCADO',
           'COCONUT','PEACH','STRAWBERRY','PAPAYA','ELEPHANT','BUTTERFLY','PLATYPUS','HIPPOPOTAMUS','KANGAROO',
           'MERMAID','GRYPHON','CHIMAERA','SPHINX','CENTAURS','CERBERUS','HIPPOCAMP','KITSUNE','MINOTAUR')
idx<-0
shinyServer(
  function(input, output, clientData, session) {    
    if(idx == 0)idx<-ceiling(runif(1)*length(secretW))
    processWord<-function(w,s=''){unlist(strsplit(x=w,split = s))}    
    checkWord<-function(letters,index){
      s<-processWord(secretW[idx])
      cc<-rep("_",length(s))
      l<-processWord(letters,',')      
      err<-0
      ok<-0
      if(length(l) > 0){
        index<-1:length(s)
        index2<-1:length(l)
        for(i in index2){
          cl<-l[i]
          found<-F
          for(j in index){
            if(cl == s[j]){
              found<-T
              cc[j]=cl
            }
          }
          if(found){ok<-ok+1;}
          else{err<-err+1;}
        }
        df<-data.frame(right=ok,wrong=err)
        output$myPlot <- renderPlot({      
          par(mfrow=c(1, 1), mar=c(5, 5, 4, 10))
          barplot(matrix(df),col=c('lightgreen','darkred'), main=paste0("Accuracy ",(ok*100/(ok+err)),"%" ), 
                  legend=names(df) ,args.legend = list(x = "topright", bty = "n", inset=c(-0.15, 0)) )
          
        })        
        resVal <-as.character((ok*100/(ok+err)))
        if(sum(cc == "_") == 0){
          resVal<-paste(resVal,"%")
        }else if(err > 10){
          resVal<-"-1"
        }
        updateTextInput(session, "word",
                        #label = paste("New", c_label),
                        value = resVal
        )
      }
      
      cc
    }    
    output$oid1 = renderPrint({processWord(input$newLetter,',')})     
    output$secret = renderPrint({checkWord(input$newLetter,idx)})     
    
  }
)