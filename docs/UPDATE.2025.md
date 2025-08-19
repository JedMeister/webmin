The TurnKey Webmin Debian package source repo was significantly refactored in
2025.

The resulting Debian binary packages are essentially the same, however the
source code in this repository is significantly different to that provided
previously.

Updates/improvements include:

- `buildsrc` script to build the source tree contained in this repository:
    - greater transparency:
        - source preparation no longer a "black box"
        - Webmin source code unmodified so can be easily compared
          against upstream
    - support for checking for upstream updates and quicker/easier source
      update from upstream when desired - opening the door for future
      automation
    - new/removed plugins automatically detected
    - only plugins compatiable with Debian are included
    - `debian/control` file generated on the fly and binary package names
      sorted, making `debian/control` file changes easy to see
    - please see the `README.md` in the root of this repo for more info about
      the `buildsrc` script and/or `./buildsrc --help`

- raw "virgin" upstream Webmin source code (from unpacked upstream
  tarballs) now included directly in repo - instead of upstream webmin-minimal
  tarball and plugin tarballs created by TurnKey:
    - easier to view upstream code changes between TurnKey Webmin versions
    - greater transparency - source code changes in this repo can be easily
      compared/verified against upstream changes
    - reduced repository size and smaller growth over time

- updated Debian packaging:
    - TurnKey patches/changes now applied at package build time via Debian
      `quilt` patches (see `debian/patches/`):
        - greater transparency - TurnKey changes immediately obvious
        - easier to push patches back upstream if/when relevant
        - easier to track TurnKey specific changes to Webmin source
    - `debian/control` binary packages now sorted (by `buildsrc` - see above)
    - "reproducable" packaging

The git history of the TurnKey Webmin package source has been pruned. The first
commit (commit ID f5b3319) is now the HEAD of the archived TurnKey source code
repository (commit ID 9eb82bf - Webmin v2.102). The archive containing all
previous git history has been moved to:
    https://github.com/turnkeylinux/webmin-archive/
