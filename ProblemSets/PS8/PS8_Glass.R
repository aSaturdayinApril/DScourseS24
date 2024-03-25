if (!require("nloptr")) {
  install.packages("nloptr")
}
library(nloptr)

set.seed(100)
N <- 100000
K <- 10
X <- matrix(NA, nrow = N, ncol = K)
X[, 1] <- 1
X[, -1] <- matrix(rnorm((N * (K - 1))), nrow = N, ncol = K - 1)

sigma <- 0.5
eps <- rnorm(N, mean = 0, sd = sqrt(sigma^2))
beta <- c(1.5, -1, -0.25, 0.75, 3.5, -2, 0.5, 1, 1.25, 2)
Y <- X %*% beta + eps



obj_fun <- function(beta) {
  sum((Y - X %*% beta)^2)
}
initial_beta <- rep(0, K)
result <- nloptr(x0 = initial_beta, eval_f = obj_fun, opts = list(algorithm = "NLOPT_LN_SBPLX"))
beta_OLS_nloptr <- result$solution
beta_OLS_nloptr




result <- optim(par = rep(0, K), fn = obj_fun, method = "Nelder-Mead")
beta_OLS_neldermead <- result$par
beta_OLS_neldermead



lm(Y ~ X -1)
