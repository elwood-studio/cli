BUILD_PKG=./node_modules/.bin/pkg 


clean:
	@echo "cleanning..."
	rm -rf ./dist ./build ./node_modules

setup:
	@echo "setup..."
	yarn

build:
	@echo "build..."
	yarn ncc build git-remote-elwood-studio.js -t -o ./build
	mv ./build/index.js ./build/git-remote-elwood-studio.js

dist:
	@echo "building...";
	${BUILD_PKG} ./build/git-remote-elwood-studio.js --out-path ./dist -t latest-linux-x64,latest-linux-arm64,latest-alpine-x64,latest-alpine-arm64,latest-mac-x64,latest-mac-x64-arm64

all: clean setup build dist