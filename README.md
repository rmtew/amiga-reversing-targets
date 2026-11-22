# Buildable launch-target exports

Fresh rendered outputs for Federation of Free Traders SPS 0613, retail Conqueror SPS 1275, Starglider II retail Amiga/Atari ST, and Pandora (1988 Firebird) Amiga. Analysis journals, annotations as structured facts, and original-media recovery recipes live in [amiga-reversing2](https://github.com/rmtew/amiga-reversing2/tree/9269d4a3f7893ae6139e64f7e811c5e2329a3ede).

## Build and verify

Install Python 3.10+ and the [vasm assembler](http://sun.hasenbraten.de/vasm/) with the Motorola syntax / 68000 backend. The tested assembler is vasm 2.0e, m68k backend 2.8, Motorola syntax module 3.19d. Follow the tool's own license and build instructions; no assembler binary/source or SDK is vendored here.

```sh
python build.py --all --vasm /path/to/vasmm68k_mot
# Or select one export:
python build.py --target sgii-amiga --vasm /path/to/vasmm68k_mot
# Validate the checkout without an assembler:
python build.py --verify-files-only
```

On Windows, pass the path to `vasmm68k_mot.exe`. `VASM` may be set instead of passing `--vasm`. The verifier checks every tracked export input and each output size/SHA-256. Build output stays in ignored `build/`. Original media, private files, the framework, SDK headers and Python packages are not build dependencies.

| Export | Output bytes | SHA-256 |
|---|---:|---|
| foft-main | 489472 | `85e2684b03badc7308e7eaa059b7c717441808798f55b4642e1d8b1895914c9b` |
| foft-boot | 4000 | `b52575d366313c1648976925c368e7a990d30477e7a099301dcabb031a3939a1` |
| foft-music-5 | 29578 | `3fa229a343d5fa6e050abc696911c36e55d5ee96cc7b2d852dbdd4404b299190` |
| conqueror | 300368 | `6428d23379667b19c7397721ed31a2a90369be99865440692ba95c6bf265f24c` |
| sgii-amiga | 419308 | `334f83ec3bdb30e36b2e5c741b7788e4a3489ee15811d11e1e52ef83bd28a938` |
| sgii-st | 419308 | `20c19400180d7e846b78aa615b68446293f8ca54015c4f4a42a77f03b24e8260` |

| pandora | 376832 | `70480017cbedb4ed1d28c0bb190917720b8d2780914c37622b0df92c070aee8f` |

These are exact decoded program/member builds. They are not proof that a whole original disk has been recreated or that an emulator boots/runs the result. No original disk images or compiled/rebuilt payloads are tracked.

The repository includes generated disassembly (with authored names/comments and inline original data), platform wrappers and 165 required extracted INCBIN assets. See [PROVENANCE.md](PROVENANCE.md) and `exports.json` for scope and file identities. Regeneration from your pinned original media belongs in the framework; it is not needed for export-only assembly.
