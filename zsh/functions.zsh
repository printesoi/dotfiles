function mkdircd()
{
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

function git_files()
{
    git status &> /dev/null || return 1

    case "$1" in
        "m"|"M") regex=" M";;
        "d"|"D") regex=" D";;
        "a"|"A") regex="A ";;
        "u"|"U") regex="\?\?";;
        *) return 2;;
    esac
    git status --porcelain | sed -nre "s/^$regex (.*)$/\1/p"
}

function encrypt_aes()
{
    [[ -z "$1" ]] && return 1;
    [[ -f "$1" ]] || return 2;
    FILE="$1"
    openssl aes-256-cbc -salt -a -in "$FILE" -out "$FILE.aes"
}

function decrypt_aes()
{
    [[ -z "$1" ]] && return 1;
    [[ -f "$1" ]] || return 2;
    FILE="$1"
    # TODO decrypt based on the extension
    openssl aes-256-cbc -d -a -in "$FILE" -out "${FILE:r}"
}
