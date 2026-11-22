# Starglider II retail Amiga and Atari ST

From the repository root, with Python 3.10+ and an externally installed vasm Motorola 68000 assembler:

```sh
python build.py --target sgii-amiga --vasm /path/to/vasmm68k_mot
python build.py --target sgii-st --vasm /path/to/vasmm68k_mot
```

sgii-amiga: **419308 bytes**, SHA-256 `334f83ec3bdb30e36b2e5c741b7788e4a3489ee15811d11e1e52ef83bd28a938`.

sgii-st: **419308 bytes**, SHA-256 `20c19400180d7e846b78aa615b68446293f8ca54015c4f4a42a77f03b24e8260`.

The verifier checks source/assets before assembly and checks the rebuilt payload. Outputs go under `build/` and are not repository files. Required INCBIN files and generated symbol includes are supplied at their relative paths. No original media, SDK installation or framework checkout is needed to build these exports.

These listings are generated disassemblies with project-authored annotations. They represent original instructions and may contain inline original data; INCBIN files are extracted original game assets. Full disk reconstruction and emulator boot are separate qualification levels. See the root provenance document for origins and the framework link for original-media regeneration.
