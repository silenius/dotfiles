#!/bin/sh

umask 022

install_files() {
    local src dst curdir dstdir dstlink

    if [ -z "$src" ] ; then
        src="$1"; dst="$2"; shift 2;
        cd "$src";
    fi

    for i in * .* ; do

        [ "$i" = "." -o "$i" = ".." -o "$i" = "*" ] && continue;

        curdir="$(pwd)";
        dstdir="$dst${curdir#$src}";

        [ ! -d "$dstdir" ] && mkdir -p "$dstdir";

        if [ -d "$i" ] ; then
            cd "$i";
            install_files;
            cd ..
        elif [ -f "$i" ] ; then
            dstlink="$dstdir/$i";
            if [ -L "$dstlink" ] ; then
                if [ $(stat -f %Y "$dstlink") != "$curdir/$i" ] ; then
                    echo "===>>> WARNING: $dstlink already exists"
                fi
            elif [ ! -f "$dstlink" ] ; then
                echo "===>>> Linking $curdir/$i to $dstlink";
                ln -s "$curdir/$i" "$dstlink";
            fi
        fi
    done
}

root="$(pwd)";

echo "===>>> Installing dotfiles ..."
install_files "$root" "$HOME";
