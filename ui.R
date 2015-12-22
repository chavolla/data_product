library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Guess the Word!!"),
  sidebarPanel(    
    tags$script("function getLetter(target){$(target).addClass('disabled');$('#newLetter').val($('#newLetter').val()+$(target).text()+',');$('#newLetter').trigger('keyup')}"),
    textInput(inputId = "newLetter",value = "",label = "Selected Characters"),
    textInput(inputId = "word",value = "",label = "Result (so far!)"),            
    h4("Please click in the buttons to select the desired character"),
    tags$div(class="bg-success",style="text-align:center;padding:5px;" ,
    tags$div(class="row", style="padding:5px;",
      tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"A"),
      tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"B"),
      tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"C"),
      tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"D"),
      tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"E"),
      tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"F"),
      tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"G"),
      tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"H")      
    ),
    
    tags$div(class="row",style="padding:5px;",
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"I"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"J"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"K"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"L"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"M"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"N"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"O"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"P")
    ),
    tags$div(class="row",style="padding:5px;",             
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"Q"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"R"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"S"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"T"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"U"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"V"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"W"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"X")
       
    ),
    tags$div(class="row",style="padding:5px;",
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"Y"),
       tags$div(class="btn btn-xs btn-success",onclick="getLetter(this)" ,"Z")            
    )),
    tags$div(id="refreshBtn",class="btn btn-warning",style="display:none;margin-top:20px;",onclick="location.reload()" ,"Try Again!"),
    tags$div(class="header", checked=NA,
             tags$p(style="margin-top:20px;","For some documentation about the usage please click below!"),
             tags$div(class="btn btn-default", "data-toggle"="modal", "data-target"="#myModal" ,"Documentation") 
    ),
    tags$script("$('#newLetter').attr('disabled','true');$('#word').attr('disabled','true');"),
    tags$script("$('#word').on('change',function(){val = $(this).val();if(val=='-1'){alert('You Lost');$('#refreshBtn').toggle();$('#lost').toggle();$('.btn-xs').attr('disabled',true);}else if(val.indexOf('%') != -1){alert('Congrats, You Won!!');$('#refreshBtn').toggle();$('#won').toggle();$('.btn-xs').attr('disabled',true);}})")
    
  ),
  mainPanel(    
         tags$div(id="won", class="btn btn-lg bg-success", style="text-align:center;font-weight:bold;color:darkgreen;display:none;", "You Won" ),
         tags$div(id="lost",class="btn btn-lg bg-danger",style="text-align:center;font-weight:bold;color:darkred;display:none;", "You lost" ),
         h3("Secret Word"),
         verbatimTextOutput("secret"),
        h3("Processed Characters"),
        verbatimTextOutput("oid1"),    
    h1("Statistics"),    
    plotOutput('myPlot'),
    
    tags$div(class="modal fade", id="myModal", tabindex="-1", role="dialog",tags$div(class="modal-dialog",tags$div(class="modal-content",
       tags$div(class="modal-header",
            tags$button( type="button", class="close", "data-dismiss"="modal", "aria-label"="Close",tags$span(class="btn btn-sm btn-danger", "aria-hidden"="true","X")),
            tags$h4(class="modal-title","Usage Documentation")
       ),
       tags$div(class="modal-body",
          tags$div(h2("Description"),tags$div("The present application requests character inputs to the user in order to guess a secret word. During the process the user performance will be measured using the accuracy.")),
          tags$div(h2("Rules"),tags$div("The user must select the characters of the secret word, once all the characters from the secret word are sent, the user will win."),
                   tags$div("The user is allowed to make 9 mistakes, if a tenth error is detected, the user will lose.")),
          tags$div(h2("User Input"),tags$div("The characters can be sent using the small green buttons.", tags$div(class="btn btn-xs btn-success","A"),
                                             tags$div(class="btn btn-xs btn-success","B"),
                                             tags$div(class="btn btn-xs btn-success","C"),
                                             tags$div("When pressed the button, the corresponding character will be sent to the server and evaluated. Also the button will become disabled.")                                            
                                             )),
          tags$div(h2("Application Output"), tags$div("The used characters can be seen in the field 'Selected Characters', this field is read only, so the user cannot modify it"),
                   tags$div("The field 'Result', will display the current accuracy. If this fields displays '-1', it will indicate that the user has lost."),
                   tags$div("The 'Secret Word' section will display the current progress of found characters for the secret word"),
                   tags$div("The 'Processed Characters' section will display the character already sent to the server"),
                   tags$div("The 'Statistics' section will display a plot reflecting the rights and wrongs from the user")
          ),
          tags$div(h2("Restarting the game"),tags$div("Once the user has lost or won the game a 'Try Again' button will be displayed. Additionally the user can refresh the page to start again."))
       ),
       tags$div(class="modal-footer", tags$button(type="button", class="btn btn-default", "data-dismiss"="modal","Close") )
      )
     )         
    )
  )
))