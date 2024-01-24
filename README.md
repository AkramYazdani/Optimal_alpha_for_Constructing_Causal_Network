# Colorectal_Cancer_Causal_Network
Identifying optimal alpha for constructing transcriptomic causal network.

The gene expression data used in this study are publicly available in Gene Expression Omnibus at GSE196576. 

We initially employed k-mean clustering and clustered genes in 4 classes. We then built a data-driven network for each cluster based on an order-independent implementation of the conditional independence properties, i.e., directed acyclic graph (DAG), learning PC-algorithm.

The identified signatures belonged to cluster 1 and 3. Therefore, we provided the list of genes in these two clusters (cluster_1.txt, cluster_3.txt).

The calculated Hamming distance for various alpha values is provided in hamming_distance_data_cluster_1and3.csv.

The code for identifying the optimal alpha based on piecewise regression is provided in optimal_alpha_network_HDbased.R.

All the gene expression values were adjusted for immune cell abundances estimated from RNA-seq data (CIBERSORTx_Results.csv) as described in the method section.

