# source :
  # https://www.ahajournals.org/doi/10.1161/CIRCULATIONAHA.107.699579?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%20%200pubmed#FD2
  # https://github.com/PHP2560-Statistical-Programming-R/r-framingham/blob/master/R/04_sbp_risk_points.R


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
#' @title calculate sbp risk factor
#'
#' @description
#' \code{calc_sbp_points} returns sbp risk factor points given hdl and gender
#'
#' @param gender A character
#' @param age A number
#' @param sbp A number
#' @param isTreated A boolean
#' @return framingham hdl risk score \code{sbp} and \code{gender} and \code{isTreated}
#' @examples
#' calc_sbp_points(sbp, gender)

calc_sbp_points <- function(sbp, gender, isTreated = FALSE) {
  points <- 0 # set default point to be 0
  # logic
  if (gender == "M" || gender == "m") {
    # call function for male
    points <- calc_sbp_male(sbp, isTreated)
  }else if (gender == "F" || gender == "f") {
    # call function for female
    points <- calc_sbp_female(sbp, isTreated)
  }
  return(points)
}

# this is a male specific function that takes in SBP and treatment status and return Framingham CAD 10 years risk points
calc_sbp_male <- function(sbp, isTreated) { # SBP is neumeric and isTreated is boolean
  points <- 0 # set default point to be 0
  if (sbp <  120 && isTreated == FALSE) { #specify sbp level and whether treated or not treated
    points <- -2
  }else if (sbp >= 120 && sbp <= 129 && isTreated == FALSE) {
    points <-  0
  }else if (sbp >= 130 && sbp <= 139 && isTreated == FALSE) {
    points <-  1
  }else if (sbp >= 140 && sbp <= 159 && isTreated == FALSE) {
    points <-  2
  }else if (sbp >= 160 && isTreated == FALSE) {
    points <-  3
  }else if (sbp <  120 && isTreated == TRUE) {
    points <-  0
  }else if (sbp >= 120 && sbp <= 129 && isTreated == TRUE) {
    points <-  2
  }else if (sbp >= 130 && sbp <= 139 && isTreated == TRUE) {
    points <-  3
  }else if (sbp >= 140 && sbp <= 159 && isTreated == TRUE) {
    points <-  4
  }else if (sbp >= 160 && isTreated == TRUE) {
    points <-  5
  }
  return(points)
}

# this is a female specific function that takes in SBP and treatment status and return Framingham CAD 10 years risk points
calc_sbp_female <- function(sbp, isTreated = FALSE) { # SBP is neumeric and isTreated is boolean
  points <- 0 # set default point to be 0
  if (sbp <  120 && isTreated == FALSE) { # specify sbp level and whether it is treated or not treated
    points <- -3
  }else if (sbp >= 120 && sbp <= 129 && isTreated == FALSE) {
    points <-  0
  }else if (sbp >= 130 && sbp <= 139 && isTreated == FALSE) {
    points <-  1
  }else if (sbp >= 140 && sbp <= 149 && isTreated == FALSE) {
    points <-  2
  }else if (sbp >= 150 && sbp <= 159 && isTreated == FALSE) {
    points <-  4
  }else if (sbp >= 160 && isTreated == FALSE) {
    points <-  5
  }else if (sbp <  120 && isTreated == TRUE) {
    points <- -1
  }else if (sbp >= 120 && sbp <= 129 && isTreated == TRUE) {
    points <-  2
  }else if (sbp >= 130 && sbp <= 139 && isTreated == TRUE) {
    points <-  3
  }else if (sbp >= 140 && sbp <= 149 && isTreated == TRUE) {
    points <-  5
  }else if (sbp >= 150 && sbp <= 159 && isTreated == TRUE) {
    points <-  6
  }else if (sbp >= 160 && isTreated == TRUE) {
    points <-  7
  }
  return(points)
}
