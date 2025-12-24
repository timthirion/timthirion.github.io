# Find all diagram directories that contain Makefiles
DIAGRAM_DIRS := $(dir $(wildcard assets/diagrams/*/Makefile))

.PHONY: all diagrams clean-diagrams serve build help

# Default target
all: diagrams

# Build all diagrams
diagrams:
	@echo "Building all diagrams..."
	@for dir in $(DIAGRAM_DIRS); do \
		echo "  Building $$dir"; \
		$(MAKE) -C $$dir || exit 1; \
	done
	@echo "All diagrams built successfully!"

# Clean all diagram build artifacts
clean-diagrams:
	@echo "Cleaning all diagram artifacts..."
	@for dir in $(DIAGRAM_DIRS); do \
		echo "  Cleaning $$dir"; \
		$(MAKE) -C $$dir clean; \
	done

# Clean all diagrams completely (including SVGs)
distclean-diagrams:
	@echo "Removing all diagram outputs..."
	@for dir in $(DIAGRAM_DIRS); do \
		echo "  Distclean $$dir"; \
		$(MAKE) -C $$dir distclean; \
	done

# Build diagrams and start Jekyll development server
serve: diagrams
	@echo "Starting Jekyll server..."
	bundle exec jekyll serve --future

# Build diagrams and build static site
build: diagrams
	@echo "Building Jekyll site..."
	bundle exec jekyll build

# Show help
help:
	@echo "Available targets:"
	@echo "  make diagrams          - Build all diagrams"
	@echo "  make clean-diagrams    - Clean intermediate files (.aux, .log)"
	@echo "  make distclean-diagrams - Remove all outputs (including SVGs)"
	@echo "  make serve             - Build diagrams and start Jekyll server"
	@echo "  make build             - Build diagrams and build Jekyll site"
	@echo "  make help              - Show this help message"
