#!/bin/sh

ROOTSRC="$HOME/Documents/Code"
ADOCDIR="$ROOTSRC/Autodoc"
OUTPUT="$ADOCDIR/Files"

# Custom labels per directory
label_for_dir() {
    case "$1" in
        # Add metadata
        .)              printf "(top-level project files)\n" ;;
        doc)            printf "(documentation-related files)\n" ;;
        include)        printf "(header and interface files)\n" ;;
        src)            printf "(core source code files)\n" ;;
        util)           printf "(utility scripts)\n" ;;
        sys)            printf "(shared system files)\n" ;;
        sys/unix)       printf "(UNIX-specific build files)\n" ;;
        sys/unix/hints) printf "(UNIX-specific configuration hints)\n" ;;
        *)              return ;;
    esac
}

# Output header
output_header() {
    printf "This file lists all files in the complete Autodoc 1.0 distribution,\n"
    printf "organized according to their standard layout on UNIX systems.\n"
    printf "It shows which files each version requires, so you can remove or\n"
    printf "skip unnecessary ones when transferring Autodoc to another system.\n\n"
    printf "(Note: This list excludes Git-related dotfiles.)\n\n"
} > "$OUTPUT"

# Output footer
output_footer() {
    printf "NOTE: This list reflects the full source distribution of Autodoc 1.0.\n"
    printf "      Some files may not appear in minimal runtime environments, as they are\n"
    printf "      only required during development, documentation generation, or build-time.\n\n"
    printf "      All files listed here should remain in the source tree to ensure a complete\n"
    printf "      and functional build, even if they are not part of the final output.\n"
} >> "$OUTPUT"

# Output a directory section
output_dir() {
    relpath="$1"
    label="$(label_for_dir "$relpath")"

    printf "%s:\n" "${relpath:-.}" >> "$OUTPUT"
    [ -n "$label" ] && printf "%s\n" "$label" >> "$OUTPUT"

    # List and format files into 4 columns
    find "$relpath" -maxdepth 1 -type f ! -name '*.html' ! -name "$(basename "$OUTPUT")" \
        -printf "%f\n" | sort | pr -T -4 >> "$OUTPUT"

    printf "\n" >> "$OUTPUT"
}

# CD into the Autodoc directory
cd "$ADOCDIR" || exit 1

output_header

# Output top-level files, aswell as subdirectories
output_dir "."
find . -mindepth 1 -type d | sed 's|^\./||' | sort | while read -r dir; do
    output_dir "$dir"
done

output_footer
