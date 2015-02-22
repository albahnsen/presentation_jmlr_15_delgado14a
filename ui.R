library(shiny)
load(file="data/algos_family.Rda")

shinyUI(navbarPage("Navb",
  tabPanel("Introduction", 
           "Introduction slides"
  ),
  navbarMenu("Setup",
             tabPanel("Datasets",
                      tabsetPanel(type="tabs",
                                  tabPanel("Datasets1", "Introduction datasets"),
                                  tabPanel("Datasets2", img(class="img-polaroid",
                                                            src="fig_datasets_properties.png"))
                                  )
                      ),
             tabPanel("Algorithms", 
                      "Introduction datasets"
             )
  ),
  tabPanel("Results",
    tabsetPanel(type="tabs",
      tabPanel("Friedman Ranking",
           sidebarLayout(
             sidebarPanel(
               selectInput("table_by", "Results by:",
                           c("Algorithm", "Family")),
               uiOutput("ui"),
               submitButton("Update View")
             ),
             mainPanel(
               h4("Summary"),
               verbatimTextOutput("text_temp"),
               conditionalPanel("input.table_by == 'Algorithm'",
                                dataTableOutput("table")
               ),
               conditionalPanel("input.table_by == 'Family'",
                                plotOutput("table_plot_family", height = 250),
                                plotOutput("table_plot_family2", height = 250)
               )
             )
           )
      ),
      tabPanel("Comparison",
               sidebarLayout(
                 sidebarPanel(
                   checkboxGroupInput("best_acc_by2", label = h3("Checkbox group"), 
                                      choices = list("NNET - elm_kernel_matlab" = "elm_kernel_matlab", 
                                                     "BAG - Bagging_LibSVM_weka" = "Bagging_LibSVM_weka",
                                                     "BST - adaboost_R" = "adaboost_R",
                                                     "DT - C5.0_caret" = "C5.0_caret",
                                                     "BY - BayesNet_weka" = "BayesNet_weka",
                                                     "RF - parRF_caret" = "parRF_caret",
                                                     "DA - fda_caret" = "fda_caret",
                                                     "SVM - svm_C" = "svm_C",
                                                     "GLM - glmnet_R" = "glmnet_R",
                                                     "NN - knn_caret" = "knn_caret"), 
                                      selected = "parRF_caret"),
                   submitButton("Update View")
                 ),
                 mainPanel(
                   h4("Summary"),
                   plotOutput("plot_per_best_acc")
                 )
               )               
          )
    )
  ),
  tabPanel("Temp", 
           "temp"
           )
)
)