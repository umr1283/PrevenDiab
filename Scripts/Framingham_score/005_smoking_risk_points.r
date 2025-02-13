# source :
  # https://www.ahajournals.org/doi/10.1161/CIRCULATIONAHA.107.699579?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%20%200pubmed#FD2
  # https://github.com/PHP2560-Statistical-Programming-R/r-framingham/blob/master/R/05_smoking_risk_points.R


#' @title calculate smoking risk factor
#'
#' @description
#' \code{calc_smoking_points} returns smoking risk factor points given smoking status and gender
#'
#' @param gender A character
#' @param age A number
#' @param status boolean
#' @return framingham smoking risk score \code{status} and \code{gender}
#' @examples
#' calc_smoking_points(status, gender)

calc_smoking_points <- function(status, gender) {
  if (gender == "M" || gender == "m") {
    # logic for male
    if (status == TRUE) { #logic for smoking
      return(4)
    } else { #logic for not smoking
      return(0)
    }
  }else {
    # logic for female
    if (status == TRUE) { # logic for smoking
      return(3)
    } else { #logic for not smoking
      return(0)
    }
  }
}
