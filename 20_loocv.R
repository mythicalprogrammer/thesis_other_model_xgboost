prostate_data <-
  read.csv(
    "start_data/GDS1390_after_anova.csv",
    header = TRUE,
    stringsAsFactors = FALSE
  )

train <- prostate_data[, !names(prostate_data) %in% c("state")]
label <- prostate_data$state

for (i in 1:length(label)) {
  if (label[i] == "D") {
    label[i] <- 0
  } else {
    label[i] <- 1
  }
}


rand_seed <- 1030
set.seed(rand_seed)

pred <- c()
for (i in 1:nrow(train)) {
  leftout_row <- train[i,]
  kth_fold_train <- train[-i,]
  kth_fold_response <- label[-i]

  kth_train <- data.matrix(kth_fold_train)
  kth_label <- data.matrix(kth_fold_response)
  kth_test <- data.matrix(leftout_row)

  kth_fit <-
    xgboost(
      data = kth_train,
      label = kth_label,
      nround = 2,
      objective = "multi:softmax",
      num_class = 2
    )
  pred[i] <- predict(kth_fit, kth_test)
}

# back up the result since this took awhile to run
file_path  <- 'result_xgboost.csv'
write.csv(pred,
          file = file_path,
          row.names = FALSE)
