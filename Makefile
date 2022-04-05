BUILD_PKG=./node_modules/.bin/pkg ./git-remote-elwood-studio.js


clean:
	@echo "cleanning..."
	rm -rf ./dist

setup:
	@echo "setup..."
	yarn

dist:
	@echo "building...";
	${BUILD_PKG} --out-path ./dist/linux -t latest-linux-x64,latest-linux-arm64,latest-alpine
	${BUILD_PKG} --out-path ./dist/alpine -t latest-alpine
	${BUILD_PKG} --out-path ./dist/mac -t latest-mac

all: setup clean dist