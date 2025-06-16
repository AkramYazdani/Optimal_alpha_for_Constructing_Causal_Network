library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(RColorBrewer)

################################################################################################
########   Function to define the knot for piecewise linear regression   #######################
################################################################################################
# Define the knot variable x-x(k) for x < k, k=knot point

knot_point <- function(x, knot)
{
  x_knot <- rep(0, length(x))
  x_knot[x > knot] <- x[x > knot] - knot
  return(x_knot)
}

################################################################################################
############## Read the calculated Hamming distance for different alpha values     #############
################################################################################################

Hamming_dis<- read.table("hamming_distance_NetworksWithSignatures.csv", header=TRUE, sep=",") ## supplementary data 3

## The first column represents alpha (at -log10 scale) applied for constructing the networks 
## columns 2 and 3 contain HD values for each cluster corresponding to different alpha values

################################################################################################
#### Fit piecewise regression with HD as dependent variable and alpha as independent variable  #
################################################################################################
#### calculate the p_values for knot variable for cluster 1 and 3, corresponding to the identified signatures
#### 

pval<- matrix(NA, ncol=2, nrow=21)

for( j in 2:3 )
  {
    for( i in 3:21 )
      {
        x <- knot_point( Hamming_dis[ ,1 ], i ) 
        pval[i, (j-1) ] <- summary( lm( Hamming_dis[,j] ~ Hamming_dis[,1] + x))[[4]][3,4]
    }
}

################################################################################################
########              visualization                                            #################
################################################################################################
data <- cbind.data.frame(as.data.frame(pval[ -c(1:2), ]),as.data.frame(Hamming_dis[ -c(1:2), 1]))

data %>%
  ggplot( aes(x = data[ ,3 ], y = data[ ,1 ])) +
  xlab("-log10(alpha)") + ylab("p-value") +
  geom_line( color = "grey") +
  geom_point(shape = 21, color = "black", fill = "#69b3a2", size =  6) +
  ggtitle("Optimal sparcity level for network based on Hamming distance")


data %>%
  ggplot( aes(x = data[ ,3 ], y = data[ ,2 ])) +
  xlab("-log10(alpha)") + ylab("p-value") +
  geom_line( color = "grey") +
  geom_point(shape = 21, color = "black", fill = "#69b3a2", size =  6) +
  ggtitle("Optimal sparcity level for network based on Hamming distance")

