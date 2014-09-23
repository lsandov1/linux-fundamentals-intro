MD_SLIDES = markdown/slides.md
MD_LAB = markdown/lab.md

.PHONY: all

all: slidy/index.html slidy/lab.html

slidy/index.html: $(MD_SLIDES) slidy.slides.template Makefile
	pandoc -t slidy --slide-level 2 --template slidy.slides.template -o $@ $(MD_SLIDES)

slidy/lab.html: $(MD_LAB) slidy.lab.template Makefile
	pandoc -t slidy --slide-level 2 --template slidy.lab.template -o $@ $(MD_LAB)

clean:
	-rm -f slidy/*.html
