
# Thesis make

# Names
TARGET-FOLDER = build
SOURCE-FILE = thesis.tex
OUTPUT=thesis
OUTPUT-PDF = ${OUTPUT}.pdf
BIB=bib
LOG=pdf-latex.log

# Env
RM = rm -rf
PDFLATEX = pdflatex
PDFLATEX-ARGS = -synctex=1 -shell-escape -interaction=nonstopmode --output-directory=${TARGET-FOLDER}



# Builds the whole thing

all: pdf copy-release

# Does not do bib

raw: raw-pdf

# Create the PDF

pdf: bib raw-pdf

# Create PDF without taking the bib into account

raw-pdf:
	$(PDFLATEX) $(PDFLATEX-ARGS)  $(SOURCE-FILE)

bib: folders
	$(PDFLATEX) $(PDFLATEX-ARGS)  $(SOURCE-FILE)
	TEXMFOUTPUT="${TARGET-FOLDER}:" BIBINPUTS="${BIB}:" bibtex $(TARGET-FOLDER)/$(OUTPUT)
	$(PDFLATEX) $(PDFLATEX-ARGS)  $(SOURCE-FILE)

# Clean up

clean:
	$(RM) $(TARGET-FOLDER)

folders:
	mkdir -p $(TARGET-FOLDER)

copy-release: 
	cp $(TARGET-FOLDER)/$(OUTPUT-PDF) $(TARGET-FOLDER)/$(OUTPUT)-release.pdf
