# 1 - Ensure renv is loaded
# Tools -> Project Options -> Environments -> Use renv with this project

# 1.1 - If project is within a OneDrive folder, run the below and restart rstudio
# Replace path with somewhere you want packages to be stored
# library(usethis)
# edit_r_environ()
# RENV_PATHS_LIBRARY_ROOT=C:/Users/Bencooper/renv

# 2 - Install packages
renv::restore()
# install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))

# 3 - Install cmdstan
library(cmdstanr)
check_cmdstan_toolchain(fix = TRUE)
install_cmdstan()
# write('RTOOLS40_HOME="C:\\rtools40"', file = "~/.Renviron", append = TRUE)

# 3.1 - If doing manual workaround (https://discourse.mc-stan.org/t/error-in-building-cmdstanr-on-windows-10/17886/42)
# set_cmdstan_path("C:/Users/Bencooper/Documents/.cmdstan/cmdstan-2.30.1/cmdstan-2.30.1")
# cmdstan_version()

# 4 - Test cmdstanr
file <- file.path(cmdstan_path(), "examples", "bernoulli", "bernoulli.stan")
mod <- cmdstan_model(file)
data_list <- list(N = 10, y = c(0,1,0,0,0,0,0,0,0,1))

fit <- mod$sample(
  data = data_list, 
  seed = 123, 
  chains = 4, 
  parallel_chains = 4,
  refresh = 500 # print update every 500 iters
)
