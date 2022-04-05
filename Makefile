BUILD_PKG=./node_modules/.bin/pkg ./git-remote-elwood-studio.js


clean:
	@echo "cleanning..."
	rm -rf ./dist

setup:
	@echo "setup..."
	yarn

dist:
	@echo "building...";
	${BUILD_PKG} --out-path ./dist/linux -t latest-linux-x64,latest-linux-arm64
	${BUILD_PKG} --out-path ./dist/alpine -t latest-alpine-x64,latest-alpine-arm64,
	${BUILD_PKG} --out-path ./dist/mac -t latest-mac-x64,latest-mac-x64-arm64

all: setup clean dist