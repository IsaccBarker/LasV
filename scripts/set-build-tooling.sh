# To avoid running in a subprocessed shell (thus muting the export commands),
# start execution with a period/dot (.).

if [[ "$1" == "" ]]; then
    echo "Please providing a target (e.g. x86_64-elf) as an argument."

    exit
fi

export CC="$1-gcc"
export AS="$1-as"
export LD="$1-ld"

