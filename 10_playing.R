prostate_data <-
  read.csv(
    "start_data/GDS1390_after_anova.csv",
    header = TRUE,
    stringsAsFactors = FALSE
  )

test <- prostate_data[, !names(prostate_data) %in% c("state")]
label <- prostate_data$state

for (i in 1:length(label)) {
  if (label[i] == "D") {
   label[i] <- 0
  } else {
   label[i] <- 1
  }
}

test <- data.matrix(test)
label <- data.matrix(label)

rand_seed <- 1030
set.seed(rand_seed)


# train a model using our training data
model <- xgboost(
  data = test,
  label = label,
  nround = 2,
  objective = "multi:softmax",
  num_class = 2
)

pred <- predict(model, test)
