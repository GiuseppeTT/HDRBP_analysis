.PHONY: \
    drake \
    background_drake \
    clean

drake:
	Rscript main.R

background_drake:
	rm -f nohup.out
	nohup Rscript main.R &

clean:
	Rscript -e "drake::clean(destroy = TRUE)"
