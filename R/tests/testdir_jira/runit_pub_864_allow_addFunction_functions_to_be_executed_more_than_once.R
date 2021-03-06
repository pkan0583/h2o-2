setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source('../findNSourceUtils.R')

test.pub_864_allow_addFunction_functions_to_be_executed_more_than_once <- function(localH2O) {

covtype.hex <- h2o.importFile(localH2O, normalizePath(locate("smalldata/covtype/covtype.20k.data")), "cov")

covtype.local = as.data.frame(covtype.hex)

# Are we in the right universe?
expect_equal(20000, dim(covtype.local)[1])
expect_equal(55, dim(covtype.local)[2])

###########################################################
# execs
###########################################################

fun = function(x) { mean( x[,2]) }
h2o.addFunction(object = localH2O, fun = fun, name = "m" )
h2o.exec(ddply(covtype.hex, c(2), m))
h2o.exec(ddply(covtype.hex, c(2), m))

testEnd()

}

doTest("PUB-864 allow addFunction functions to be executed more than once.", test.pub_864_allow_addFunction_functions_to_be_executed_more_than_once)
