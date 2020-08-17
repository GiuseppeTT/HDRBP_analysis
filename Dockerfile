FROM rocker/tidyverse:latest

# Not necessary, just to include the project library
RUN true \
    && git clone https://github.com/GiuseppeTT/HDRBP.git home/rstudio/HDRBP

RUN true \
    && git clone https://github.com/GiuseppeTT/HDRBP_analysis.git home/rstudio/HDRBP_analysis \
    && cd /home/rstudio/HDRBP_analysis \
    && apt-get update && sudo apt-get install -y libgmp3-dev libmpfr-dev \
    && make dependencies

COPY data/ /home/rstudio/HDRBP_analysis/data/

WORKDIR /home/rstudio/HDRBP_analysis
