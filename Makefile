
clean:
	@echo "cleanning..."
	rm -rf ./dist ./build ./node_modules

setup:
	@echo "setup..."
	yarn
	yarn upgrade

build:
	@echo "build..."
	rm -rf ./build
	node ./scripts/build.js

dist:
	@echo "packaging...";
	rm -rf ./dist
	node ./scripts/dist.js

all: clean setup build dist


.PHONY: build dist