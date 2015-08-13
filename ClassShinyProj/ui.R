
library(shiny)

# This application is an interactive text predictor 
# fluid - width is automatically set based on the browser
shinyUI(fluidPage(
        
        # Application title
        titlePanel("WriteWords"),
        br(),
        tags$h4("Use this application to predict the next word in a phrase.",
                style = "color:blue"),
        br(),
        tags$p(
                tags$h5("Enter a phrase in the box below.  The search string will display the  
                         standardized text used for search, and the predicted words will display.") 
                ),
        br(),
        br(),
        tags$h5("Try these phrases..."), 
        tags$h5("You're the reason why I smile everyday. Can you follow me please? It would mean the"), 
        tags$h5("Very early observations on the Bills game: Offense still struggling but the"), 
        tags$h5("I'm thankful my childhood was filled with imagination and bruises from playing"), 

        # Add inputs & output controls   
        sidebarLayout(
                # Sidebar is for the user input
                sidebarPanel(
                        textInput("text", label =  h3("  "), value = ("Enter phrase...")),
                        #actionButton(inputId= "predict", label = "Predict Next!"), 
                        tags$img(height = 100, width = 100, src = "cellphoneimage.jpg")   
                 ),  # end sidebar Panel
                
                # Main panel is for where the output will be displayed 
                mainPanel(
                        h6("Search string..."),
                        verbatimTextOutput("text"),
                      
                        em("To view the output, navigate through the tabs below.", style = "font-family: 'verdana'; font-si20pt"),
                        p(" "), 
                        tabsetPanel(type = "tabs", 
                                    tabPanel("Predicted Word(s)", verbatimTextOutput("view")), 
                                    tabPanel("Word Cloud", plotOutput("wcloud")), 
                                    tabPanel("About", 
                                             tags$strong("This application is a project deliverable from...", 
                                             tags$a(href = "https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage", 
                                                    "Coursera Data Science Certification")),
                                             br(),
                                             tags$hr(), 
                                             tags$em("        Being able to fit size fourteen shoes is quite a [feet]", style = "color:blue"),
                                             br(),
                                             tags$em("        Chest xtray said it all.  Lungs are full of [rum]", style = "color:blue"), 
                                             br(),
                                             tags$em("        Pizza does not like [buffallo]", style = "color:blue"),         
                                             br(),
                                             tags$hr(),
                                             h5("This project is about predicting the next word in a sequence of words   
                                                      Think about a phrase  and then think about what the next word is likely to be.  
                                                      For instance, if someone says 'Cat in the ..'.  What is the next word that comes to mind?   
                                                      This is the intention of this project:  enter a phrase and the algorithm will attempt to 
                                                      predict the next word. Examples of applications that use this approach are spell checkers 
                                                      that suggest a likely alternative to a mis-spelled word or a search engine that is predicting 
                                                      the rest of a search phrase..."),
                                             verbatimTextOutput("summary")) 
                        ) # end tabsetPanel   
                        
                        
                ) # end mainPanel
        ) # end sidebarLayout
   ) # end FluidPage
) # end shinyUI
