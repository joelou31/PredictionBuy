install.packages("caret")
library(caret)


#Predicción de Regresión Logística
log_preds_binary <- ifelse(log_preds > 0.5, 1, 0)  # Convertir las predicciones a 0 o 1

#Predicción de XGBoost:
xgb_preds_binary <- ifelse(xgb_preds > 0.5, 1, 0)  # Convertir las predicciones a 0 o 1


#Predicción de Random Forest:
rf_preds_binary <- ifelse(rf_preds > 0.5, 1, 0)  # Convertir las predicciones a 0 o 1
S