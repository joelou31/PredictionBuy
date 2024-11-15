#Métricas para la Regresión Logística:
log_cm <- confusionMatrix(factor(log_preds_binary), factor(test_data$purchased))
log_cm


#Métricas para XGBoost:
xgb_cm <- confusionMatrix(factor(xgb_preds_binary), factor(test_data$purchased))
xgb_cm


#Métricas para Random Forest:
rf_cm <- confusionMatrix(factor(rf_preds_binary), factor(test_data$purchased))
rf_cm

usethis::use_git()
