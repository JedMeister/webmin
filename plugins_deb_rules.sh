#!/bin/bash -e
#
# simple script to build module/theme tarballs and generate maintainer scripts
# intended to be run from the install target of the debian/rules file

if [[ "$DH_VERBOSE" -ne 0 ]]; then
    set -x
fi

PROGNAME="${progname:-$(awk '/^Source/ {print $2}' debian/control)}"
BUILDROOT="${buildroot:-"debian/$PROGNAME"}"
TMP="${tmp:-debian/tmp}"
TIMESTAMP="2025-01-01 00:00:00Z"

for plugin in modules/* themes/*; do

    plugin_name=$(basename "$plugin")
    plugin_dir="$(dirname "${plugin/s}")-archives"
    plugin_tar_file="$plugin_name.wb${plugin:0:1}.gz"
    plugin_path="$BUILDROOT-$plugin_name/usr/share/$PROGNAME/$plugin_dir"
    mkdir -p "$plugin_path"
    plugin_tar_path="$plugin_path/$plugin_tar_file"

    tar --sort=name --mtime="$TIMESTAMP" --format=posix \
        --owner=0 --group=0 --numeric-owner \
        --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime,delete=mtime \
        -C "$(dirname "$plugin")" -cf "$plugin_tar_path" "$plugin_name"

    maint_script="debian/$PROGNAME-$plugin_name"

    cat > "$maint_script.postinst" <<EOF
#!/bin/sh
set -e

export PERL5LIB=/usr/share/$PROGNAME
cd /usr/share/$PROGNAME
./install-module.pl $plugin_dir/$plugin_tar_file

#DEBHELPER#
EOF
    if [[ -e "debian/postinst.d/$plugin_name" ]]; then
        cat "debian/postinst.d/$plugin_name" >> "$maint_script.postinst"
    fi
    cat > "$maint_script.postrm" <<EOF
#!/bin/sh
set -e

rm -rf /usr/share/$PROGNAME/$plugin_name

#DEBHELPER#
EOF
    for post_script in "$maint_script.postinst" "$maint_script.postrm"; do
        sed -i "s|^-e #!/bin/sh|#!/bin/sh|" "$post_script"
        touch -d "$TIMESTAMP" "$post_script"
    done
done

exit 0
