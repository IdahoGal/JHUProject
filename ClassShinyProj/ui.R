
library(shiny)

# This application is an interactive text predictor 
# fluid - width is automatically set based on the browser
shinyUI(fluidPage(
        
        # Application title
        titlePanel("WriteWords"),
        br(),
        tags$h5("Use this application to predict the next word in a phrase. Enter a phrase into the box below, if no word is predicted, the phrase <No SWAG> will appear.",
                style = "color:blue"),
        br(),
        tags$h5("To experiment, try these phrases from NEWS and TWITTER data..."), 
        tags$h5("...well he picks up on a girl with mcnuggets ...but he's no Aaron"), 
        tags$h5("...Tufts University #tinnitus (starting with photo of Buffalo"), 
        tags$h5("...Swanson wrote a letter to Iowa Attorney General Tom Miller, New York Attorney General"), 
        br(),
        # Add inputs & output controls   
        sidebarLayout(
                # Sidebar is for the user input
                #br(),
                sidebarPanel(
                        textInput("text", label =  h3("Predict Next!  "), value = (" ")),
                        #actionButton(inputId= "predict", label = "Predict Next!"), 
                        tags$img(height = 100, width = 100, src = "cellphoneimage.jpg")   
                 ),  # end sidebar Panel
                
                # Main panel is for where the output will be displayed 
                mainPanel(
                        #h5("Search string..."),
                        #verbatimTextOutput("text"),
                        #br(),
                        h5("Predicted Words (up to 3)..."),
                        verbatimTextOutput("view"),
                        tags$img(height = 100, width = 100, src = "cellphoneimage.jpg"),  
                        br(),
                        br(),
                        br(),
                        em("For information about the app, navigate through the tabs below.", style = "font-family: 'verdana'; font-si20pt"),
                        br(), 
                        tabsetPanel(type = "tabs", 
                                     tabPanel("About Data", 
                                        h5("This app was built using Twitter and News data sets.
                                            To keep the data size footprint small, the Twitter data set was
                                            sampled at 15% and the News data set at 100%.  The raw data was then standardized by appling a combination
                                            of steps to remove extra spaces, common words, common swear words, duplicate characters, 
                                            numbers, and punctuation. "),
                                        br(),
                                        h5("Using the TAU package, 3 Ngrams data sets were created (2, 3, and 4).  Only the most common
                                            word combinations were retained from each of the NGrams: (30,850 4-NGrams, 60,000 3-NGrams, 
                                            and 130,000 2-Ngrams). The NGram datasets were merged using a data table structure which 
                                            provides very fast, indexed searches.")
                                    ), 
                                    tabPanel("About Design", 
                                        h5("This app is intended for a mobile phone so the design has been prioritized
                                                for speed and efficiency. An intentional trade-off has been made between the time
                                                it takes to display the suggested next word and the volume and size of the app's
                                                vocabulary. You should expect to see very fast response times for common phrases. 
                                                For uncommon or unique phrases, there may be no suitable prediction in which case 
                                                <No S(illy)W(ild)A(ss)G(uess)> will display as output. "),
                                        br(),
                                        h5("The algorithm used is an implementation of a simple Katz back-off model described here in: ",
                                             tags$a(href = "http://en.wikipedia.org/wiki/Katz%27s_back-off_model", "Wikipedia"))
                                    ), 
                                    tabPanel("About App", 
                                             tags$em("This application is a project deliverable from...", 
                                             tags$a(href = "https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage", 
                                                    "Coursera Data Science Certification")),
                                             h5("It is about predicting the next word given a sequence of words. Think about a
                                                 phrase and then think about what the next word might be.  For instance, if someone
                                                 says 'Breakfast at...', what is the next word that comes to mind? Examples of 
                                                 applications that use this approach are spell checkers and search engines. 
                                                 Amusing examples of predictions from similar apps include: "),
                                             tags$hr(), 
                                             tags$em("        Being able to fit size fourteen shoes is quite a [feet]", style = "color:blue"),
                                             br(),
                                             tags$em("        Chest xtray said it all.  Lungs are full of [rum]", style = "color:blue"), 
                                             br(),
                                             tags$em("        Pizza does not like [buffallo]", style = "color:blue"),         
                                             br()
                                             )
                        ) # end tabsetPanel   
                        
                        
                ) # end mainPanel
        ) # end sidebarLayout
   ) # end FluidPage
) # end shinyUI
