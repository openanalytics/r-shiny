FROM openanalytics/r-base

LABEL maintainer="daan.seynaeve@openanalytics.eu"

RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.0.0 \
    && rm -rf /var/lib/apt/lists/*
    
RUN echo $http_proxy
RUN echo $https_proxy
RUN echo $no_proxy

# packages needed for basic shiny functionality
RUN R -e "options(internet.info = 0); install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org')"

# set host and port
COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838
