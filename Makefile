BUILD_PKG=./node_modules/.bin/pkg --out-path ./build ./git-remote-elwood-studio.js


clean:
	@echo "cleanning..."
	rm -rf ./build

build:
	@echo "building...";
	${BUILD_PKG} -t latest-linux-x64,latest-linux-arm64

all: clean build