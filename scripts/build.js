const { join, basename, dirname, extname } = require('path');
const { rm, writeFile, mkdir, readdir } = require('fs/promises');

const ncc = require('@vercel/ncc');

async function main() {
  const binDir = join(__dirname, '../bin');
  const buildDir = join(__dirname, '../build');

  await rm(buildDir, { force: true, recursive: true });
  await mkdir(buildDir);

  const packages = await readdir(binDir);

  for (const file of packages) {
    const { code } = await ncc(join(binDir, file), {
      minify: false,
      sourceMap:false,
      externals: ['cpu-features']
    });

    await writeFile(join(buildDir, file), code);
  }
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err.message);
    process.exit(1);
  });
