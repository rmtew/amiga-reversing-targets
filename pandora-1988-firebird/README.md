# Pandora (1988 Firebird), Amiga absolute export

Build from the repository root:

```sh
python build.py --target pandora --vasm /path/to/vasmm68k_mot
```

This is the original fixed-address BK-decoded raw gameplay program, loaded at `$20000`, not the experimental relocation or DOS-hosted variant. It assembles to 376,832 bytes with SHA-256 `70480017cbedb4ed1d28c0bb190917720b8d2780914c37622b0df92c070aee8f`. Its 126 required INCBINs are extracted graphic/audio/data spans. Original disk media and compiled payloads are not included. The program hash is exact; this export is not a whole-disk rebuild or emulator boot proof.
