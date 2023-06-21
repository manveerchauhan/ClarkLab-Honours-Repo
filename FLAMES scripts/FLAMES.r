# R script used to generate flames output files from BLAZE generated whitelist.csv file
# USAGE (type in terminal) - Rscript FLAMES.R [/path/to/fastq] [/path/to/whitelist.csv] [path/to/outputDirectory]


# Install the FLAMES package if needed
#if (!requireNamespace("BiocManager", quietly = TRUE))
  #install.packages("BiocManager")
#BiocManager::install("FLAMES")

main <- function() {

    suppressPackageStartupMessages(
        library("FLAMES")
    )


    # Define the variables that are unique to the sample-------------------------
    args <- commandArgs(trailingOnly = TRUE)

    # Check that the number of arguments parsed into the function are correct
    if (length(args) != 3) {
        stop("Please provide the correct number of arguments.
        \nUSAGE: Rscript FLAMES.R [/path/to/fastq] [/path/to/whitelist.csv] [path/to/outputDirectory]")
    }

    fastqfile <- args[1]
    whitelist <- args[2]
    output <- args[3]


    # Define global variables (these shouldn't change between samples)-----------
    minimap2_path <- "~/.conda/envs/minimap2/bin/minimap2"
    # Define reference files
    GTF <- "/data/gpfs/projects/punim0646/manveer/gencode.v43.chr_patch_hapl_scaff.annotation.gtf.gz"
    transcriptome <- "/data/gpfs/projects/punim0646/manveer/gencode.v43.transcripts.fa"
    # Enter the path for the config file
        configPath <- "/data/gpfs/projects/punim0646/manveer/config_file_57972.json"

    # Run FLAMES-----------------------------------------------------------------
    sce <- sc_long_pipeline(fastq = fastqfile, outdir = output, reference_csv = whitelist, annotation = GTF, 
        genome_fa = transcriptome, match_barcode = TRUE, minimap2_dir = minimap2_path, 
        config_file = configPath)
    
    message("Complete")
}

suppressWarnings(
    main()
)