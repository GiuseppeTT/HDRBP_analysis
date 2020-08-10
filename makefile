.PHONY: \
    drake \
    background_drake \
    clean \
	dependencies

drake:
	Rscript main.R

background_drake:
	rm -f nohup.out
	nohup Rscript main.R &

clean:
	Rscript -e "drake::clean(destroy = TRUE)"

dependencies:
	Rscript -e "install.packages('renv')"
	Rscript -e "renv::restore()"
