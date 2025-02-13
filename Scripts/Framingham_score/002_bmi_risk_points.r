# source :
  # https://www.ahajournals.org/doi/10.1161/CIRCULATIONAHA.107.699579?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%20%200pubmed#FD2
  # https://github.com/PHP2560-Statistical-Programming-R/r-framingham/blob/master/R/02_bmi_risk_points.R


#' @title calculate BMI risk factor
#'
#' @description
#' \code{calc_BMI_points} returns BMI risk factor points given BMI status and gender
#'
#' @param bmi A number
#' @return framingham BMI risk score \code{status} and \code{bmi}
#' @examples
#' calc_bmi_points(bmi)

# function to calculate BMI points
calc_bmi_points <- function(bmi) {
  if (bmi < 15 || bmi > 50 || is.na(bmi)) { #specify cases when BMI point will return NA)
    return(NA)
  }else if (bmi < 25) { #specify BMI groups
    return(0)
  }else if (bmi >= 25 && bmi < 30) {
    return(1)
  }else if (bmi >= 30) {
    return(2)
  }
}
