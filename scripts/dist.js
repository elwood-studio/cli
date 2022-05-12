const { join, basename, extname } = require('path');
const { rm, mkdir, readdir, unlink } = require('fs/promises');

const { exec } = require('pkg');
const AdmZip = require('adm-zip');

const targets = ['node16-linux-x64', 'node16-macos-x64'];

async function main() {
  const buildDir = join(__dirname, '../build');
  const distDir = join(__dirname, '../dist');

  await rm(distDir, { force: true, recursive: true });
  await mkdir(distDir);

  const builds = await readdir(buildDir);

  for (const file of builds) {
    for (const target of targets) {    
      const out = join(
        distDir,
        `${basename(file, extname(file))}-${target.replace('node16-', '')}`,
      )
      

      await exec([
        join(buildDir, file),
        '--output',
        out,
        '-t',
        target,        
      ]);

      const zip = new AdmZip()
      zip.addLocalFile(out);
      zip.writeZip(`${out}.zip`);

      unlink(out);

    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err.message);
    process.exit(1);
  });
