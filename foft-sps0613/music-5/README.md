# FOFT SPS 0613 music-5 member

From the repository root, with Python 3.10+ and an externally installed vasm Motorola 68000 assembler:

```sh
python build.py --target foft-music-5 --vasm /path/to/vasmm68k_mot
```

foft-music-5: **29578 bytes**, SHA-256 `3fa229a343d5fa6e050abc696911c36e55d5ee96cc7b2d852dbdd4404b299190`.

The verifier checks source/assets before assembly and checks the rebuilt payload. Outputs go under `build/` and are not repository files. Required INCBIN files and generated symbol includes are supplied at their relative paths. No original media, SDK installation or framework checkout is needed to build these exports.

These listings are generated disassemblies with project-authored annotations. They represent original instructions and may contain inline original data; INCBIN files are extracted original game assets. Full disk reconstruction and emulator boot are separate qualification levels. See the root provenance document for origins and the framework link for original-media regeneration.
