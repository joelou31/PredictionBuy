# División en entrenamiento y prueba
set.seed(123)
split <- sample.split(data$purchased, SplitRatio = 0.8)
train_data <- subset(data, split == TRUE)
test_data <- subset(data, split == FALSE)


#realizado de predicciones:
# Modelo de Regresión Logística
log_model <- glm(purchased ~ ., data = train_data, family = binomial)
log_preds <- predict(log_model, test_data, type = "response")



# Convertimos los datos a matriz para XGBoost
train_matrix <- as.matrix(train_data[, -'purchased', with = FALSE])
train_label <- train_data$purchased
test_matrix <- as.matrix(test_data[, -'purchased', with = FALSE])

# Entrenamos el modelo
xgb_model <- xgboost(data = train_matrix, label = train_label, nrounds
                     = 100, objective = "binary:logistic", verbose = 0)
xgb_preds <- predict(xgb_model, test_matrix)



# Asegúrate de que la variable "purchased" es un factor
train_data$purchased <- as.factor(train_data$purchased)
test_data$purchased <- as.factor(test_data$purchased)

# Entrena el modelo de Random Forest en modo clasificación
rf_model <- randomForest(purchased ~ ., data = train_data, ntree = 100)
rf_preds <- predict(rf_model, test_data, type = "prob")[,2]




# Curva ROC y AUC para Regresión Logística
log_roc <- roc(test_data$purchased, log_preds)
log_auc <- auc(log_roc)
print(paste("AUC de Regresión Logística:", log_auc))

# Curva ROC y AUC para XGBoost
xgb_roc <- roc(test_data$purchased, xgb_preds)
xgb_auc <- auc(xgb_roc)
print(paste("AUC de XGBoost:", xgb_auc))

# Curva ROC y AUC para Random Forest
rf_roc <- roc(test_data$purchased, rf_preds)
rf_auc <- auc(rf_roc)
print(paste("AUC de Random Forest:", rf_auc))

# Graficar las curvas ROC para comparar
plot(log_roc, col = "blue", main = "Curvas ROC de los Modelos", lwd = 2)
plot(xgb_roc, col = "red", add = TRUE, lwd = 2)
plot(rf_roc, col = "green", add = TRUE, lwd = 2)
legend("bottomright", legend = c("Regresión Logística", "XGBoost", "Random Forest"), 
       col = c("blue", "red", "green"), lwd = 2)





