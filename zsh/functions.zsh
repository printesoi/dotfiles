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
