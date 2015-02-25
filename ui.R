library(shiny)
require(markdown)
load(file="data/algos_family.Rda")

load(file="data/algos.Rda")
selected_algos <- split(algos$Algorithm, algos$FullName)

shinyUI(navbarPage("Paper - Comparison classifiers",
  tabPanel("Introduction", htmlOutput('slides')
  ),
  navbarMenu("Experimental Setup",
             tabPanel("Datasets",
                      tabsetPanel(type="tabs",
                                  tabPanel("Datasets1", includeMarkdown("www/desc_datasets.md")),
                                  tabPanel("Datasets2", h3("Datasets Information"), 
                                           img(class="img-polaroid", src="fig_datasets_properties.png"))
                                  )
                      ),
             tabPanel("Algorithms", 
                      includeMarkdown("www/desc_algos.md"),
                      sidebarLayout(
                        sidebarPanel(width = 2,
                          selectInput("family1", "Algorithm Family:", 
                                      choices = c("ALL", sort(unique(algos_family$Family)))),
                          selectInput("implementation1", "Algorithm Implementation:", 
                                      choices = c("ALL", sort(unique(algos_family$Implementation)))),
                          submitButton("Update View")
                                    ),
                        mainPanel(dataTableOutput("table_algos"))
                        ) 
                      ),
             tabPanel("Evaluation",  includeMarkdown("www/desc_setup.md") )
  ),
  tabPanel("Results",
    selectInput("filter_binary", h4("Filter databases by number of classes:"),
                       c("All", "Binary")),
    tabsetPanel(type="tabs",
      tabPanel("Friedman Ranking",
           sidebarLayout(
             sidebarPanel( width = 2,
               selectInput("table_by", h4("Results by:"),
                           c("Algorithm", "Family")),
               uiOutput("ui"),
               uiOutput("ui2"),
               submitButton("Update View")
             ),
             mainPanel(
               h4("Results measured by Friedman Ranking"),
               conditionalPanel("input.table_by == 'Algorithm'",
                                dataTableOutput("table")
               ),
               conditionalPanel("input.table_by == 'Family'",
                                plotOutput("table_plot_family", height=800)
               )
             )
           )
      ),
      tabPanel("Comparison max. accuracy",
               sidebarLayout(
                 sidebarPanel( width = 2,
                   checkboxGroupInput("best_acc_by2", label = h4("Algorithms:"), 
                                      choices = selected_algos,  selected = "parRF_caret"),
                   submitButton("Update View")
                 ),
                 mainPanel(
                   plotOutput("plot_per_best_acc", height=800)
                 )
               )               
          ),
      tabPanel("T-statistic",
               sidebarLayout(
                 sidebarPanel(  width = 2,
                   radioButtons("best_acc_by3", label = h4("Algorithms:"), 
                                      choices = selected_algos,  selected = "parRF_caret"),
                   submitButton("Update View")
                 ),
                 mainPanel(
                   plotOutput("plot_comparison", height=800)
                 )
               )               
      ),
      tabPanel("Database complexity",
               sidebarLayout(
                 sidebarPanel(  width = 2,
                                radioButtons("weighted", label = h4("Weighted by"), 
                                            choices = list("Average accuracy" = "um",
                                                       "Weighted accuracy difficulty" = "uj",
                                                       "Weighted accuracy # patterns" = "up",
                                                       "Weighted accuracy dec # patterns" = "ud",
                                                       "Weighted accuracy # classes" = "ul",
                                                       "Weighted accuracy # features" = "ui"
                                            ),  selected = "um"),
                                submitButton("Update View")
                 ),
                 mainPanel(
                   h4("Summary"),
                   plotOutput("plot_weighted", height=800)
                 )
               )               
      ),
      tabPanel("Binary vs. Multinomial",
               sidebarLayout(
                 sidebarPanel(width = 2,
                              radioButtons("comparison_by4", label = h4("Statistic:"), 
                                           choices = list("Friedman Ranking"="friedman",
                                                          "Average Accuracy"="acc"),
                                           selected = "friedman"), 
                              submitButton("Update View")
                 ),
                 mainPanel(
                   plotOutput("plot_bin_multi", height=800)
                 )
               )               
      )
    )
  ),
  tabPanel("Conclusions", includeMarkdown("www/desc_conclusions.md")),
  tabPanel("About", includeMarkdown("README.md"))
)
)