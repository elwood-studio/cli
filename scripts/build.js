const { join, basename, dirname, extname } = require('path');
const { rm, writeFile, mkdir } = require('fs/promises');
const { fileURLToPath } = require('url');

const ncc = require('@vercel/ncc');
const { exec } = require('pkg');

const targets = ['node16-linux-x64'];
const pkgs = ['workflow-runner.js'];

async function main() {
  const binDir = join(__dirname, '../bin');
  const buildDir = join(__dirname, '../build');
  const outDir = join(__dirname, '../dist');

  await rm(outDir, { force: true, recursive: true });
  await rm(buildDir, { force: true, recursive: true });

  await mkdir(outDir);
  await mkdir(buildDir);

  for (const pkgName of pkgs) {
    const { code } = await ncc(join(binDir, pkgName), {
      minify: true,
    });

    await writeFile(join(buildDir, pkgName), code);

    for (const target of targets) {
      await exec([
        join(binDir, pkgName),
        '--output',
        join(
          outDir,
          `elwood-studio-${basename(pkgName, extname(pkgName))}-${target}`,
        ),
        '-t',
        target,
      ]);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err.message);
    process.exit(1);
  });
