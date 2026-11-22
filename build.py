"""Assemble and verify the published exports; requires Python and external vasm."""
from pathlib import Path
import argparse,hashlib,json,os,shutil,subprocess,sys
ROOT=Path(__file__).resolve().parent

def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 data=json.loads((ROOT/'exports.json').read_text());p=argparse.ArgumentParser(description=__doc__)
 p.add_argument('--vasm',default=os.environ.get('VASM'));p.add_argument('--target',action='append',choices=[x['id'] for x in data['targets']]);p.add_argument('--all',action='store_true');p.add_argument('--verify-files-only',action='store_true');a=p.parse_args()
 for row in data['files']:
  path=ROOT/row['path']
  if not path.is_file() or path.stat().st_size!=row['size'] or digest(path)!=row['sha256']:raise SystemExit('File identity mismatch: '+row['path'])
 if a.verify_files_only:print('All export file identities match.');return
 executable=a.vasm or shutil.which('vasmm68k_mot') or shutil.which('vasmm68k_mot.exe')
 if not executable:p.error('install vasm and pass --vasm /path/to/vasmm68k_mot or set VASM')
 executable=str(Path(executable).resolve()) if Path(executable).exists() else executable
 selected=[x for x in data['targets'] if not a.target or a.all or x['id'] in a.target]
 for row in selected:
  output=ROOT/row['output'];output.parent.mkdir(exist_ok=True)
  subprocess.run([executable,'-m68000','-no-opt','-Fbin','-quiet','-o',str(output),row['entry']],cwd=ROOT/row['directory'],check=True)
  actual=digest(output)
  if output.stat().st_size!=row['size'] or actual!=row['sha256']:raise SystemExit('Rebuilt payload mismatch: '+row['id'])
  print(row['id']+': '+str(row['size'])+' bytes SHA-256 '+actual+' OK')
if __name__=='__main__':main()
