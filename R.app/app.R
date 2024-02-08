pacman::p_load(
  shiny,
  bslib,
  ggpubr,
  shinylive
)

chooseCRANmirror()

library(shiny)
source("E:/Deggendorf/GPH Class Lectures/Digital health/DH proj/DH-Project/DH-Project-Choffih-Yong/cleandata.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Histogram in Tabs"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("marital_status","Marital status",levels(mydata$marital_status)),
      sliderInput("age","Age",min(mydata$age,na.rm = T), max(mydata$age,na.rm = T), c(0,70))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      navset_card_underline(
        title = "Visualization",
        nav_panel("plot", titlePanel("Age Classes"), plotOutput("age_class_def")),
        nav_panel("Summary", titlePanel("Test Change"), plotOutput("age_table")),
        nav_panel("Table", titlePanel("Test 2"), plotOutput(ll_by_case_def))
      ),
      p("This is a Paragraph"),
      tags$li(tag$b("Location_name"), "- Sexual Violence Psychology Department Mbanga "),
      tags$li(tag$b("data_date"), "- December 15, 2023"),
      tags$li(tag$b("submitted_date"), "- January 10,2024"),
      tags$li(tag$b("Region"), "- Littoral "),
      tags$li(tag$b("District"), "  Mbanga "),
      tags$li(tag$b("cases_reported"), "- 358 Confirmed cases ")
      
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  filtered_mydata <- reactive({
    mydata <- mydata %>% filter(Marital_status = input$marital_status & Age >= input$age[13] & age <= input$age[65])
  })
  
    ggplot(age_class_def, aes(x=age_class,y=n)) + geom_col()
  
    output$ll_by_case_def <- renderPlot({ 
    ll_by_case_def <- filtered_data %>%
      group_by(gender,case_def) %>%
      tally() 
    ggplot(ll_by_case_def, aes(x=gender, y=n, fill=case_def)) + geom_col()
    })
    
    output$ageTable <-renderPlot({
    age_table <- filtered_data %>%
      tabyl(age_category,gender) %>%
      adorn_totals(where = "both") %>%
      adorn_percentages(denominator ="col") %>%
      adorn_pct_formatting() %>%
      adorn_ns(position = "front") %>%
      adorn_title(row_name = "Age Category",
                  col_name = "Gender")
    ggtexttable(age_table)
    
  })
}
    
shinylive::export(appdir = "./", format = "html")

# Run the application 
shinyApp(ui = ui, server = server)
