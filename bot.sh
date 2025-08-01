#!/usr/bin/env bash
#
# Daily Logger by Moiz Haider
#
# Personal activity tracker
#
# Deploy locally for daily logging
# 
# Logs daily entries automatically
#
info="Log: $(date)"
echo "System: $OSTYPE"

case "$OSTYPE" in
    darwin*)
        cd "`dirname $0`" || exit 1
        ;;

    linux*)
        cd "$(dirname "$(readlink -f "$0")")" || exit 1
        ;;

    msys*)
        # Windows Git Bash support
        cd "$(dirname "$0")" || exit 1
        ;;

    *)
        echo "OS unsupported (submit an issue on GitHub!)"
        # Continue anyway, try the basic approach
        cd "$(dirname "$0")" || exit 1
        ;;
esac

echo "$info" >> data.txt
echo "$info"
echo

# Detect current branch (main, master, etc)
branch=$(git rev-parse --abbrev-ref HEAD)

# Save changes
git add data.txt
git commit -m "$info"
git push origin "$branch"

# Return to previous directory (if OLDPWD is set)
if [ -n "$OLDPWD" ]; then
    cd -
fi
