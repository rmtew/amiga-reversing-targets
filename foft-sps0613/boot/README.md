# FOFT SPS 0613 boot member

From the repository root, with Python 3.10+ and an externally installed vasm Motorola 68000 assembler:

```sh
python build.py --target foft-boot --vasm /path/to/vasmm68k_mot
```

foft-boot: **4000 bytes**, SHA-256 `b52575d366313c1648976925c368e7a990d30477e7a099301dcabb031a3939a1`.

The verifier checks source/assets before assembly and checks the rebuilt payload. Outputs go under `build/` and are not repository files. Required INCBIN files and generated symbol includes are supplied at their relative paths. No original media, SDK installation or framework checkout is needed to build these exports.

These listings are generated disassemblies with project-authored annotations. They represent original instructions and may contain inline original data; INCBIN files are extracted original game assets. Full disk reconstruction and emulator boot are separate qualification levels. See the root provenance document for origins and the framework link for original-media regeneration.
