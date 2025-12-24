# Article-specific diagrams
DIAGRAMS = envelope-10-lines envelope-comparison

# Generate targets
LATTE_PDFS = $(addsuffix -latte.pdf,$(DIAGRAMS))
MOCHA_PDFS = $(addsuffix -mocha.pdf,$(DIAGRAMS))
LATTE_SVGS = $(addsuffix -latte.svg,$(DIAGRAMS))
MOCHA_SVGS = $(addsuffix -mocha.svg,$(DIAGRAMS))

# Default target: build all SVGs
all: $(LATTE_SVGS) $(MOCHA_SVGS)

# Build latte version PDF
%-latte.pdf: %.tex
	pdflatex -jobname=$*-latte '\def\theme{latte}\input{$*.tex}'

# Build mocha version PDF
%-mocha.pdf: %.tex
	pdflatex -jobname=$*-mocha '\def\theme{mocha}\input{$*.tex}'

# Convert PDF to SVG
%.svg: %.pdf
	pdf2svg $< $@

# Clean up intermediate files
clean:
	rm -f *.aux *.log

# Clean everything including outputs
distclean: clean
	rm -f $(LATTE_PDFS) $(MOCHA_PDFS) $(LATTE_SVGS) $(MOCHA_SVGS)

.PHONY: all clean distclean
