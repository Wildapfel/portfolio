library(affy)
library(preprocessCore) 
library(matrixStats)


load_cel_files <- function(raw_cel_paths) {

    # You can also directly merge from multiple exps.

    raw_cel_paths <- unlist(strsplit(raw_cel_paths, ",")[[1]])
    cel_files = list()
    for (path in raw_cel_paths){
        for (f in list.files(path)){
            cel_files <- append(cel_files, (paste(path, "/", f, sep="", "")))
        }
    }
    cel_files_vec <- unlist(cel_files, use.names=FALSE) 

    return(cel_files_vec)

}


load_cel_files_from_gse_list <- function(raw_cel_path, gse_list) {

    # Only from a single RAW path. 

    cel_files  <- list()
    for (gsm_id in gse_list) {
        cel_sel <- paste(raw_cel_path, "/", gsm_id, ".CEL.gz", sep = "")
        cel_files <- append(cel_files, cel_sel)
    }
    cel_vec <- unlist(cel_files, use.names=FALSE) 

    return(cel_vec)

}


preprocess <- function(affy_data, method, freeze) {

    #
    # Preprocessing
    # -------------
    # - Background Correction
    # - DQN or Standardascled wiht either mean/median and sd/mads
    # - This also includes a log2 transformation (internally)
    # 

    rma_data    <- NULL
    expr_matrix <- NULL
    means       <- NULL
    sds         <- NULL
    medians     <- NULL
    mads        <- NULL
    params      <- NULL

    print(method)

    if (method == "DQN") {
        print("DQN")
        # Disribution Quantile Normalization
        rma_data <- rma(affy_data, normalize=TRUE, background=TRUE) 
        expr_matrix <- exprs(rma_data)
    } else if (method == "DQN_EXT") {
        print("DQN_EXT")
        expr_matrix <- exprs(rma(affy_data, normalize=FALSE, background=TRUE))
        median0 <- rowMedians(expr_matrix)    
        mads0 <- rowMads(expr_matrix)
        expr_matrix <- exprs(rma(affy_data, normalize=TRUE, background=TRUE)) 
        median1 <- rowMedians(expr_matrix)    
        mads1 <- rowMads(expr_matrix)
        shift <- median1 - median0
        scale <- mads1 / (mads0 + 1e-6)
    } else if (method == "MEAN_SD") { 
        print("MEAN_SD")
        rma_data <- rma(affy_data, normalize=FALSE, background=TRUE) 
        expr_matrix <- exprs(rma_data)
        means <- rowMeans(expr_matrix)      
        sds <- rowSds(expr_matrix)        
        expr_matrix <- (expr_matrix - means) / sds
    } else if (method == "MEDIAN_MAD") {
        print("MEDIAN_MAD")
        # Robust Scaling with median and mad
        rma_data <- rma(affy_data, normalize=FALSE, background=TRUE) 
        expr_matrix <- exprs(rma_data)
        medians <- rowMedians(expr_matrix)      
        mads <- rowMads(expr_matrix)        
        expr_matrix <- (expr_matrix - medians) / mads
    } else {
        print("Not a valid preprocessing.")
        quit()
    }

    if (!freeze) {
        return(expr_matrix)
    }

    else {
        if (method == "DQN") {
            # DQN_MEDIAN_MAD
            dqn_medians <- rowMedians(expr_matrix)
            dqn_mads <- rowMads(expr_matrix)
            params <- list(method = "DQN_MEDIAN_MAD", dqn_medians = dqn_medians, dqn_mads = dqn_mads)
        } else if (method == "DQN_EXT") {
            params <- list(method = "MEDIAN_MAD_SHIFT", shift = shift, scale = scale)
        } else if (method == "MEAN_SD") {
            params <- list(method = "MEAN_SD", means = means, sds = sds)
        } else if (method == "MEDIAN_MAD") {
            params <- list(method = "MEDIAN_MAD", median = medians, mads = mads)
        }
        return (list(
            expr_matrix = expr_matrix,
            params = params
        ))
    }
}

preprocess_from_frozen_params <- function(affy_data, params) {

    #
    # I assume:
    # ---------
    # Index 1 : method (sanity check)
    # Index 2 : mean or median
    # Index 3 : sd or mad
    # 

    # bg_data <- bg.correct(affy_data, method="rma") 
    # expr_matrix <-log2(pm(bg_data))
    rma_data <- rma(affy_data, normalize=FALSE, background=TRUE) 
    expr_matrix <- exprs(rma_data)     
    # expr_matrix <- (expr_matrix - params[[2]]) / params[[3]]

    if (params$method == "DQN_MEDIAN_MAD" || params$method == "MEAN_SD" || params$method == "MEDIAN_MAD") {
        # subtract center, divide by spread
        expr_matrix <- (expr_matrix - params[[2]]) / params[[3]]
    } else if (params$method == "MEDIAN_MAD_SHIFT") {
        # DQN_EXT style: add shift, multiply by scale
        expr_matrix <- (expr_matrix + params$shift) * params$scale
    } else {
        stop("Unknown method in frozen parameters")
    }

    return(expr_matrix)

}
