docker build -t causal_inference . && \
    docker run --rm -p 8787:8787 -e PASSWORD=rstudio -v $(pwd):/home/rstudio causal_inference
