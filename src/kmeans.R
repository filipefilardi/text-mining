# Data set
X <- read.csv2(
	"/Users/danielmurta/Documents/IA-EP/data/bbc/result_bin.csv",
	stringsAsFactors = F
)

X$X <- NULL           # Remove file ids stored in first column

# Euclidian Distance
euclidian <- function(X, C) {
	sqrt(sum((X - C) ^2))
}

# Returns index of min dist centroid
min.euclidian <- function(X, C, k) {
	min_dist <- Inf
	result <- 0
	for(i in 1:k) {
		aux <- euclidian(X, C[i, ])
		if(aux < min_dist) {
			result <- i
			min_dist <- aux
		}
	}
	result
}

# Returns max distance of all centroids
max.euclidian <- function(C, C_old, k) {
	max_dist <- 0.01
	for(i in 1:k) {
		aux <- euclidian(C[i, ], C_old[i, ])
		if(aux > max_dist) max_dist <- aux
	}
	max_dist
}

kMeans <- function(X, k, episilon = 0.01) {
	
	n <- dim(X)[1]                                      # Number of lines (observations)
	m <-dim(X)[2]                                       # Number of columns (dimension)
	
	C <- matrix(sample(0:1, k * m, replace = T), k, m)  # Centroids matrix
	C_old <- matrix(0, k, m)                            # Last interaction matrix 
	U <- matrix(0, n, k)                                # Participation matrix n x k
	
	t <- 0                                              # interaction counter
	dif <- Inf
	while(dif > episilon) {
		t <- t + 1                                      # count one interation
		dif <- max.euclidian(C, C_old, k)               # check threshold
		C_old <- C                                      # update old C
		
		print(paste("interaction: ", t, "episilon: ", dif))
		
		# Caculate distances and associate observations to centroids
		i <- 0
		d <- unname(as.matrix(dist(rbind(C, X)))[(k+1):(k+n), 1:k])
		for(i in 1:n) {
			index <- which.min(d[i, ])		              # Find index of closest centroid
			
	    # index <- min.euclidian(X[i, ], C, k)        
			U[i, ] <- 0                                 # Clean before new custer
			U[i, index] <- 1                            # Add belonged cluster
		}
		
		print("calculate distances to centroids")
		
		# Calculate mean and associate to centroids
		i <- 0
		for(i in 1:k) {
			tmp <- U[U[, i]  == 1, ]
			if(length(tmp) > 0){
				C[i,] <- colMeans(tmp)
			}
		}
		
	}
	
	return(data.frame(interaction = t, centroids = C))
}

result <- kMeans(X, 2)
