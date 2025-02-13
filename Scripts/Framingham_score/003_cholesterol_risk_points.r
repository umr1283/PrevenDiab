# source :
  # https://www.ahajournals.org/doi/10.1161/CIRCULATIONAHA.107.699579?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%20%200pubmed#FD2
  # https://github.com/PHP2560-Statistical-Programming-R/r-framingham/blob/master/R/03_cholesterol_risk_points.R


#' @title calculate cholesterol risk factor
#'
#' @description
#' \code{calc_cholesterol_points} returns cholesterol risk factor points given cholesterol and gender
#'
#' @param gender A character
#' @param cholesterol A number
#' @return framingham cholesterol risk score \code{cholesterol} and \code{gender}
#' @examples
#' calc_cholesterol_points(gender='f', chol=35)
calc_cholesterol_points <- function(gender, chol) {
  points <- 0 # set default point to be 0
  # logic
  if (gender == "M" || gender == "m") {
    # call function for male
    points <- calc_cholesterol_male(chol)
  }else  if (gender == "F" || gender == "f") {
    # call function for female
    points <- calc_cholesterol_female(chol)
  }
  return(points)

}

# this male specific function takes in chol and returns framingham CAD10 yeras risk points
calc_cholesterol_male <- function (chol) {  # chol should be numeric
  point <- 0 #set default point to be 0
  if (is.na(chol)) {
    points <- NA
  } else if (chol < 160) { # specify cholesterol level case by case
    points <- 0
  } else if (chol >= 160 && chol <= 199) {
    points <- 1
  } else if (chol >= 200 && chol <= 239) {
    points <- 2
  } else if (chol >= 240 && chol <= 279) {
    points <- 3
  }else if (chol >= 280) {
    points <- 4
  }

  return(points);
}

# this female specific function takes in chol and returns framingham CAD10 yeras risk points
calc_cholesterol_female <-  function(chol) {  # chol should be numeric
  point <- 0 # set default point to be 0
  if (is.na(chol)) {
    points <- NA
  } else if (chol < 160) { # specify cholesterol level case by case
    points <- 0
  } else if (chol >= 160 && chol <= 199) {
    points <- 1
  } else if (chol >= 200 && chol <= 239) {
    points <- 3
  } else if (chol >= 240 && chol <= 279) {
    points <- 4
  }else if (chol >= 280) {
    points <- 5
  }

  return(points);
}
