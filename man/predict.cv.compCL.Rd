% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tools.R
\name{predict.cv.compCL}
\alias{predict.cv.compCL}
\title{Make predictions based on a \code{"cv.compCL"} object.}
\usage{
\method{predict}{cv.compCL}(object, Znew, Zcnew = NULL, s = c("lam.min", "lam.1se" ),
        trim = FALSE, ...)
}
\arguments{
\item{object}{fitted \code{"cv.compCL"} model.}

\item{Znew}{\code{z} matrix as in \code{compCL} with new compositional data
or categorical data.}

\item{Zcnew}{\code{Zc} matrix as in \code{compCL} with new data for other
covariates. Default is \code{NULL}}

\item{s}{specify the \code{lam} at which prediction(s) is requested.
\itemize{
  \item \code{s = "lam.min"} (default), value of \code{lam} that obtains
        the minimun value of cross-validation error.
  \item \code{s = "lam.1se"} value of \code{lam} that obtains 1 standard
        error above the miminum of the cross-validation errors.
  \item if \code{s} is numeric, it is taken as the value(s) of lam to be used.
  \item if \code{s = NULL}, uses the whole sequence of \code{lam} stored in the
        \code{"cv.compCL"} object.
}}

\item{trim}{Whether to use the trimmed result. Default is FASLE.}

\item{...}{not used.}
}
\value{
predicted values at the requested values of \code{s}.
}
\description{
This function makes prediction based on a cross-validated \code{compCL} model,
using the stored \code{compCL.fit} object.
}
\details{
\code{s} is the vector at which predictions are requested. If \code{s} is not in the lambda
sequence used for fitting the model, the \code{predict} function uses linear interpolation.
}
\examples{
p = 30
n = 50
beta = c(1, -0.8, 0.6, 0, 0, -1.5, -0.5, 1.2)
beta = c( beta, rep(0, times = p - length(beta)) )
Comp_data = comp_Model(n = n, p = p, beta = beta, intercept = FALSE)
test_data = comp_Model(n = 30, p = p, beta = beta, intercept = FALSE)
cvm1 <- cv.compCL(y = Comp_data$y, Z = Comp_data$X.comp,
                  Zc = Comp_data$Zc, intercept = Comp_data$intercept)
y_hat = predict(cvm1, Znew = test_data$X.comp, Zcnew = test_data$Zc)
predmat = predict(cvm1, Znew = test_data$X.comp, Zcnew = test_data$Zc, s = NULL)
plot(test_data$y, y_hat, xlab = "Observed response", ylab = "Predicted response")
abline(a = 0, b = 1, col = "red")

}
\references{
Lin, W., Shi, P., Peng, R. and Li, H. (2014) \emph{Variable selection in
regression with compositional covariates},
\href{https://academic.oup.com/biomet/article/101/4/785/1775476}{https://academic.oup.com/biomet/article/101/4/785/1775476}.
\emph{Biometrika} \strong{101} 785-979.
}
\seealso{
\code{\link{cv.compCL}} and \code{\link{compCL}},
and \code{\link[=coef.cv.compCL]{coef}} and \code{\link[=plot.cv.compCL]{plot}} methods
for \code{"cv.compCL"} object.
}
\author{
Zhe Sun and Kun Chen
}
