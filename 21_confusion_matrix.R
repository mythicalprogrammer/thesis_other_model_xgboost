pred_xgboost <- c()
for (i in 1:length(pred)) {
  if (pred[i] == 0) {
    pred_xgboost[i] <- "D"
  } else {
    pred_xgboost[i] <- "I"
  }
}
levels(pred_xgboost) <- c("D", "I")
pred_xgboost <- as.factor(pred_xgboost)
levels(pred_xgboost) == levels(as.factor(prostate_data$state))
cm <- confusionMatrix(pred_xgboost, as.factor(prostate_data$state))
cm$overall["Accuracy"]

"
Accuracy
0.85 for 2 rounds
"
