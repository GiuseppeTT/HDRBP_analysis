.PHONY: \
    drake \
    log_drake \
    background_drake \
    clean \
    dependencies \
    docker_build \
    docker_push \
    docker_run \
    docker_stop \
    docker_bash \
    _docker_drake \
    docker_drake

drake:
	Rscript main.

log_drake:
	Rscript main.R > log/drake.log 2>&1

background_drake:
	rm -f nohup.out
	nohup Rscript main.R &

clean:
	Rscript -e "drake::clean(destroy = TRUE)"

dependencies:
	Rscript -e "install.packages('renv')"
	Rscript -e "renv::restore()"



docker_build:
	docker build -t hdrbp_analysis .
	docker tag hdrbp_analysis giuseppett/hdrbp_analysis

docker_push:
	docker push giuseppett/hdrbp_analysis

docker_run:
	docker run -d --rm --name hdrbp_analysis giuseppett/hdrbp_analysis

docker_stop:
	docker stop hdrbp_analysis

docker_bash:
	docker exec -ti hdrbp_analysis bash

_docker_drake:
	docker cp config.yml hdrbp_analysis:/home/rstudio/HDRBP_analysis
	docker exec hdrbp_analysis make log_drake
	docker cp hdrbp_analysis:/home/rstudio/HDRBP_analysis/result result

docker_drake:
	rm -f nohup.out
	nohup make _docker_drake &
