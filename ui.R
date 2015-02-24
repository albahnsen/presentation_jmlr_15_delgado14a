library(shiny)
require(markdown)
load(file="data/algos_family.Rda")

selected_algos = list("NNET - avNNet_caret" = "avNNet_caret", 
                      "BAG - Bagging_LibSVM_weka" = "Bagging_LibSVM_weka",
                      "BST - adaboost_R" = "adaboost_R",
                      "DT - C5.0_caret" = "C5.0_caret",
                      "BY - BayesNet_weka" = "BayesNet_weka",
                      "RF - parRF_caret" = "parRF_caret",
                      "DA - fda_caret" = "fda_caret",
                      "SVM - svm_C" = "svm_C",
                      "GLM - glmnet_R" = "glmnet_R",
                      "NN - knn_caret" = "knn_caret")


shinyUI(navbarPage("Paper - Comparison classifiers",
  tabPanel("Introduction", htmlOutput('slides')
  ),
  navbarMenu("Experimental Setup",
             tabPanel("Datasets",
                      tabsetPanel(type="tabs",
                                  tabPanel("Datasets1", includeMarkdown("www/desc_datasets.md")),
                                  tabPanel("Datasets2", img(class="img-polaroid",
                                                            src="fig_datasets_properties.png"))
                                  )
                      ),
             tabPanel("Algorithms", 
                      includeMarkdown("www/desc_algos.md"),
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("family1", "Algorithm Family:", 
                                      choices = c("ALL", unique(algos_family$family))),
                          submitButton("Update View")
                                    ),
                        mainPanel(dataTableOutput("table_algos"))
                        ) 
                      ),
             tabPanel("Evaluation",  includeMarkdown("www/desc_setup.md") )
  ),
  tabPanel("Results",
    selectInput("filter_binary", "Filter databases by number of classes:",
                       c("All", "Binary")),
    tabsetPanel(type="tabs",
      tabPanel("Friedman Ranking",
           sidebarLayout(
             sidebarPanel( width = 2,
               selectInput("table_by", "Results by:",
                           c("Algorithm", "Family")),
               uiOutput("ui"),
               submitButton("Update View")
             ),
             mainPanel(
               h4("Summary"),
               conditionalPanel("input.table_by == 'Algorithm'",
                                dataTableOutput("table")
               ),
               conditionalPanel("input.table_by == 'Family'",
                                plotOutput("table_plot_family", height=600)
               )
             )
           )
      ),
      tabPanel("Comparison",
               sidebarLayout(
                 sidebarPanel( width = 2,
                   checkboxGroupInput("best_acc_by2", label = h3("Checkbox group"), 
                                      choices = selected_algos,  selected = "parRF_caret"),
                   submitButton("Update View")
                 ),
                 mainPanel(
                   h4("Summary"),
                   plotOutput("plot_per_best_acc", height=600)
                 )
               )               
          ),
      tabPanel("T-statistic",
               sidebarLayout(
                 sidebarPanel(  width = 2,
                   selectInput("best_acc_by3", label = h3("Checkbox group"), 
                                      choices = selected_algos,  selected = "parRF_caret"),
                   submitButton("Update View")
                 ),
                 mainPanel(
                   h4("Summary"),
                   plotOutput("plot_comparison", height=600)
                 )
               )               
      ),
      tabPanel("Database complexity",
               sidebarLayout(
                 sidebarPanel(  width = 2,
                                radioButtons("weighted", label = h3("Weighted by"), 
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
                   plotOutput("plot_weighted", height=600)
                 )
               )               
      )
    )
  ),
  tabPanel("Conclusions", includeMarkdown("www/desc_conclusions.md"))
)
)