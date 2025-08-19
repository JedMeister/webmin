Webmin - Web based interface for system administration
======================================================

Webmin is a powerful and flexible web-based server management control panel,
written in Perl. See the [Webmin website][0] for more info.

This respoitory contains the source of the Turnkey Linux Webmin Debian
packages.

Source package notes
--------------------

Webmin upstream provide a Debian package (maintained by Jamie Cameron, lead
Webmin dev) but unfortunately, or not - depending on your preference, it
includes all modules in the one package.

In the spirit of keeping TurnKey images as lean as possible, this Debian
package source repository creates a minimal core `webmin` package and
individual `webmin-<plugin>` packages. Which supports only installing the
relevant Webmin plugins.

TurnKey Webmin source repository includes:
- Webmin "core" source code from upstream "webmin-minimal" tarball - unpacked
  to `webmin_core` - unmodified source
- Webmin plugin source code from upstream full "webmin" tarball - individual
  plugin source unpacked to `module/<name>`/`theme/<name>` as relevant -
  unmodified source; only plugins supported on Debian are included
- 'buildsrc' update script:
    - check for upstream updates
    - download, verify and unpack source tarballs to relevant locations
      (unrequired source discarded)
    - generate updated `debian/control` file
- `plugins_deb_rules.sh` script - to generate `plugin` Debian package source
  on the fly - called by `debian/rules` at build time
- use of Debian `quilt` system during package build to apply TurnKey specific
  patches to original unmodified Webmin source code

Note that this repository was significantly refactored in 2025. For details of
the changes, please see `docs/UPDATE.2025.md`. The legacy TurnKey Webmin source
with full git history can be found in the [`turnkey/webmin-archive`][1]
repository.

[0]: https://webmin.com/
[1]: https://github.com/turnkeylinux/webmin-archive
