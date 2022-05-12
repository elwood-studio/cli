#!/bin/sh
# Copyright 2022 Elwood Studio, Inc. All rights reserved. MIT license.
# inspired by deno_install (https://github.com/denoland/deno_install)

set -e

if ! command -v unzip >/dev/null; then
	echo "Error: unzip is required to install Elwood Studio." 1>&2
	exit 1
fi

case $(uname -sm) in
"Darwin x86_64") target="macos-x64" ;;
"Darwin arm64") target="macos-arm64" ;;
*) target="linux-x64" ;;
esac

dl_uri="https://github.com/elwood-studio/cli/releases/latest/download/elwood-studio-${target}.zip"
dest="${ELWOOD_STUDIO_HOME:-$HOME/.elwood-studio}"
bin="$dest/bin"
exe="$bin/elwood-studio"

if [ ! -d "$bin" ]; then
	mkdir -p "$bin"
fi

curl --fail --location --progress-bar --output "$exe.zip" "$uri"
unzip -d "$bin" -o "$exe.zip"
chmod +x "$exe"
rm "$exe.zip"

echo "Elwood Studio was installed successfully to $exe"

if command -v elwood-studio >/dev/null; then
	echo "Run 'elwood-studio --help' to get started"
else
	case $SHELL in
	/bin/zsh) shell_profile=".zshrc" ;;
	*) shell_profile=".bash_profile" ;;
	esac
	echo "Manually add the directory to your \$HOME/$shell_profile (or similar)"
	echo "  export ELWOOD_STUDIO_HOME=\"$dest\""
	echo "  export PATH=\"\$ELWOOD_STUDIO_HOME/bin:\$PATH\""
	echo "Run '$exe --help' to get started"
fi