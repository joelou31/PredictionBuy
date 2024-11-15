# Cargar librerías necesarias
install.packages(c("data.table", "xgboost", "randomForest", "caTools", "pROC"))
library(data.table)
library(xgboost)
library(randomForest)
library(caTools)
library(pROC)

# Fijamos una semilla para reproducibilidad
set.seed(123)

# Crear dataset sintético
n <- 10000
data <- data.table(
  age = sample(18:70, n, replace = TRUE),
  income = rnorm(n, mean = 50000, sd = 15000),
  gender = sample(c("Male", "Female"), n, replace = TRUE),
  web_visits = rpois(n, lambda = 5),
  purchased = sample(0:1, n, replace = TRUE, prob = c(0.7, 0.3))
)

# Convertimos la variable "gender" a factor y luego la codificamos en binaria
data$gender <- as.factor(data$gender)
data$gender <- as.numeric(data$gender) - 1  # 0 para Female, 1 para Male
