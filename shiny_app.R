library(shiny)
library(httr)
library(lubridate)
library(rjson)
library(rlang)
library(data.table)
library(DT)

url <- "http://127.0.0.1:8000/med_reports/"  # django server url
diseases <- c('Covid', 'Flu', 'Chickenpox') # types of diseases which user can choose

status_codes <- function(){
  list(SUCCESS_REQUEST = c(200, "No error detected"),
       CREATED_REQUEST = c(201, "Data was completely added to database"),
       BAD_REQIEST = c(400, "Wrong request syntax, please check it"),
       NOT_FOUND_REQUEST = c(404, "Server could not find what was requested, please check your input"),
       UNSUPPORTED_MEDIA_TYPE_REQUEST = c(415, "Format of request is not supported by the server, please try again"),
       SERVER_INTERBAL_ERROR = c(500, "Server encountered an unexpected condition that prevented it from fulfilling the request"))
}

# get_data <- reactive({  # method for getting data from db and adding it to plot and table
#       content(GET(url))
# })

draw_table <- function(){
    # req_content <- get_data()
    req_content <-  content(GET(url))
    dates <- c()
    diseases <- c()
    patients_nums <- c()
    for(cell in req_content){
        dates <- append(dates, cell$date)
        diseases <- append(diseases, cell$disease)
        patients_nums <- append(patients_nums, cell$patients)
    }
    data_visual <- renderTable({
        data.frame(dates, diseases, patients_nums)
    })
    data_visual
}

ui <- fluidPage(

  titlePanel("Medical Database"),

  sidebarPanel(
      radioButtons("illness", 'What disease is diagnosed?', diseases),
      sliderInput("patients", "Number of patients with the disease:", value = 0, min = 0, max = 100),
      actionButton('enter', 'Enter data into the database', class = "btn-danger"),
      width = 4
  ),

  mainPanel(
      titlePanel("Statistics"),
      textOutput("result"),
      tableOutput("table"),
      plotOutput("plot")
  ),

)

server <- function(input, output, session){

  output$table <- draw_table()

  observeEvent(input$enter, {
      params <- data.frame(disease = input$illness , patients = input$patients)
      res <- POST(url, body = params, verbose())
      print(status_code(res))
      output$table <- draw_table()
    # if (status_code(res) != status_codes()$SUCCESS_REQUEST[0]){  # erro showing will be added later
    #     print()
    # }
  })
}


shinyApp(ui, server)

