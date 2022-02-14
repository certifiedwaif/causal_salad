FROM rocker/rstudio

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y gnupg software-properties-common
# RStudio needs this to display plots in the IDE.
RUN apt-get install -y libxt-dev

RUN mkdir -p ~/.R && \
    echo 'MAKEFLAGS=-j 4"' && \
        echo 'PKG_LIBS+=-pthread' >> ~/.R/Makevars
RUN R -e 'install.packages("devtools")'

# Install dependencies for Causal Salad.
RUN R -e 'remotes::install_github("stan-dev/cmdstanr")'
RUN R -e 'devtools::install_github("rmcelreath/rethinking")'
RUN R -e 'cmdstanr::install_cmdstan(cores=4)'

# Install dependencies for RMarkdown rendering.
RUN R -e 'install.packages(c("base64enc", "htmltools", "jquerylib", "markdown", "rmarkdown", "tinytex"))'
# You need a TeX installation to render to PDF.
RUN apt-get install -y texlive

WORKDIR /home/rstudio
COPY causal_salad.Rmd /home/rstudio
