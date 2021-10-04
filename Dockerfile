FROM r-base

## install necessary Rpackages for GSVA analysis
# Install packages to be able to run GSVA analysis in parallel
RUN apt-get update && apt-get install -y \
	libcurl4-openssl-dev \
	libssl-dev \
	libxml2-dev \
	libfftw3-dev \
	libfftw3-doc
RUN R -e "install.packages(c('BiocManager'), repos='http://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "BiocManager::install(c('qusage', 'GSEABase', 'GSVA'), version='3.13', update=TRUE, ask=FALSE)"

COPY . /usr/local/src/scripts/
WORKDIR /usr/local/src/scripts/

RUN ["chmod", "+x", "calc_GSVA_with_resampling.R"]
RUN ["chmod", "+x", "func_sampling_same_dist.R"]
