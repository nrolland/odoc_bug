#! /bin/bash

set -eu

die() {
    >&2 echo "$1"
    exit 1
}

lang="${1:-}"
if [[ -z $lang ]]; then
    die "language is not given"
fi

msg="
    🎉  happy hacking
"
here_abs="$(cd "$(dirname "$0")" > /dev/null; pwd)"

if [ "$lang" == "ocaml" ]; then
    # dune build @doc -w
    # exclude the logs folder, watch for changes in project mysite.com and refresh active chrome tab
    # open -a "Google Chrome" _build/default/_doc/_html/index.html
    echo "starting stuff for ocaml"
    dir="./_build/default/_doc/_html/"
    echo "watching $dir"
    echo "run :"
    echo "cd $here_abs && dune build @doc -w"
    echo $msg
    open -a "Google Chrome" _build/default/_doc/_html/index.html
    fswatch -o "$dir" | xargs -n1 -I{} osascript ./reloadActiveChromeTab.scpt
else
if [ "$lang" == "haskell" ]; then
    # open -a "Google Chrome" $(stack path --dist-dir)/doc/html/$(basename "$PWD")/index.html
    echo "starting stuff for haskell"
    #dir="$here_abs/$(stack path --dist-dir)/doc/html/$(basename "$PWD")/"
    dir="$(stack path --local-doc-root)/all"
    echo "watching $dir"
    echo "run :"
    echo "cd $here_abs && stack build --haddock --file-watch"
    echo $msg
    open -a "Google Chrome" "$dir/index.html"
    fswatch -o "$dir" | xargs -n1 -I{} osascript ./reloadActiveChromeTab.scpt
else
    echo "did not recognise $lang possible choices are ocaml and haskell"
fi
fi


#tmpdir="$(mktemp -d tmp.XXXX)"

#/Users/nrolland/clones/recursion-cat/.stack-work/install/x86_64-osx/5f5874663d88650ac4403be29247b8bcd784826779089202f6357983c30f8110/8.10.7/doc/recursion-cat    -0.1.0.0/doc-index.html

#/Users/nrolland/clones/recursion-cat/.stack-work/install/x86_64-osx/5f5874663d88650ac4403be29247b8bcd784826779089202f6357983c30f8110/8.10.7/doc/all/index.html
#/Users/nrolland/clones/recursion-cat/.stack-work/install/x86_64-osx/5f5874663d88650ac4403be29247b8bcd784826779089202f6357983c30f8110/8.10.7/doc/all/index.html