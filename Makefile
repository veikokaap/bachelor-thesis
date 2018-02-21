
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
PDF-READER = xdg-open



# Builds the whole thing

all: pdf open

# Does not do bib

raw: raw-pdf open

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

# Open the PDF created
open:
	$(PDF-READER) $(TARGET-FOLDER)/$(OUTPUT-PDF)

folders:
	mkdir -p $(TARGET-FOLDER)
