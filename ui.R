# ui.R

shinyUI(fluidPage(
  titlePanel("US Natural Disasters"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("selectState", 
                                  label = h3("Select State"), 
                                    choices = list("Texas" = 1, 
                                                   "California" = 2, "New York" = 3,
                                                   "Ohio" = 4, "Tennessee" = 5,
                                                   "South Carolina" = 6),
                                    ),
      actionButton("goBtn", "Plot!")),
    mainPanel(
      p("Histogram displaying US Natural Disasters in selected US states"),
    p(plotOutput("distPlot"))
    )
  )
  ))