
  


library(shiny)
library(shinydashboard)
multiyr_ncaa <- read.csv("multiyr_ncaa.csv")

dashboardPage(
  dashboardHeader(title="APR Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Intro", tabName = "intro"),
      menuItem("Density", tabName = "density"),
      menuItem("Boxplots", tabName = "boxplots"),
      menuItem("Leaflet", tabName = "leaflet")
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro",
              fluidRow(
               p("Implemented by the NCAA, the Academic Progress Rate (APR) is a team-based metric that holds institutions accountable for the academic progress of their student-athletes and accounts for eligibility and retention of each individual student-athlete for each academic term. This measurement system rewards teams with superior academic performance and penalizes teams that do not achieve certain benchmarks."),
               p("APR is an important measurement to consider for any prospective student athletes who are looking to play for not only a specific school but also a specific team. According to the NCAA, less than 2 percent of NCAA student-athletes become professional athletes. Because of this, student-athletes may wish to emphasize academic performance to prepare them for life after college. "),
               p("The creators of this application wish to give any prospective student athlete an inside view of the academic performance of a specific school, team, and conference as well as the factors which may contribute to the APR. With this knowledge, one should be able to gain a greater perspective of their lives as student athletes off the field and inside the classroom. This application consists of a density plot and multiple box plots regarding APR and multiple variables as well as a heat map demonstrating the regional differences in APR.")
              )
              ),
     #first tab
      tabItem(tabName = "density",
              fluidRow(
                p("This is a density plot which shows the distribution of Academic Performance Rates (APR). Choose to group by either school or conference and find out the density of the APR of that particular variable:"),
                box(
                  width= 12,
                  title = "Density",
                  sidebarLayout(
                    
                    sidebarPanel(
                      selectInput(
                        inputId = "aprGroupBy",
                        label = "Group by",
                        choices = list(Conference= "confname_18",
                                       School= "scl_name"
                        ),
                        selected = "confname_18",
                        
                      ),
                      selectizeInput(
                        inputId = "aprIncludeSchools",
                        label = "Schools",
                        choices = unique(multiyr_ncaa$scl_name),
                        multiple=TRUE,
                        selected=unique(multiyr_ncaa$scl_name[1]),
                      )
                    ),
                    mainPanel(
                      plotOutput("aprDensity")
                    )
                  )
                )
              )
      ),
      #second tab
      tabItem(tabName = "boxplots",
              fluidRow(
                p("Choose a sport, conference, or school you are interested in looking at to see a box plot of the Academic Progress Rate (APR). This plot allows you to see the distribution of..."),
                box(
                  title = "Box Plots Showing APR",
                  width= 12,
                  sidebarLayout(
                    sidebarPanel(
                      selectInput(
                        inputId = "aprGroup",
                        label = "Group by",
                        choices = list(Sport = "sport_name",
                                       Conference = "confname_18",
                                       School = "scl_name"
                        ),
                      selected = "sport_name"),
                      uiOutput('plotFilter')
                    ),
                    mainPanel(
                      plotOutput("aprBoxPlot"))
                  )
                  
                )
              )      
      ),
     tabItem(tabName= "leaflet",
             fluidRow(
               p("View how APR is distributed regionally:")
             )
             )
    )
    
  )
)


