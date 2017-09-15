FROM openanalytics/r-base

MAINTAINER Enrico Anello "enrico.anello@fao.org"


# system libraries of general use
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
    default-jre \
    default-jdk \
    libxml2 \
    libxml2-dev \
    texlive-latex-base \
    texlive-latex-extra


 # install dependencies of the LBI app
RUN R -e "install.packages(c('shiny', 'rmarkdown','shinythemes','TropFishR', 'devtools'), repos='https://cloud.r-project.org/')"
RUN R -e "devtools::install_github('AnalytixWare/ShinySky')"
RUN R -e "devtools::install_github('daattali/shinyjs')"

RUN mkdir /root/TropFishRElefanShinyApp
COPY TropFishR_ELEFAN_ShinyApp /root/TropFishRElefanShinyApp

COPY Rprofile.site /usr/lib/R/etc/
 
EXPOSE 3838

CMD ["R", "-e shiny::runApp('/root/TropFishRElefanShinyApp',port=3838,host='0.0.0.0')"]