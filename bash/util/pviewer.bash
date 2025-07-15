#!/usr/bin/env bash

# fzf builtin preview window

OFFSET=4

FZF_SEARCH=(
	'--exact'
	'--smart-case'
	'--scheme=default'
	'--nth=1'
	'--with-nth=1'
	'--accept-nth=1'
	#'--disabled'
)

FZF_IO=(
    '--ansi'
    '--sync'
    '--prompt= > '
)
#
# [[ "$1" =~ "^[-q]" ]] && \
#   FZF_QUERY_RESULTS=$1 || \
#   FZF_QUERY_RESULTS= && \
  # echo $FZF_QUERY_RESULTS
FZF_STYLE_PRESET='minimal'
FZF_COLOR_COLSPEC='16'
FZF_TERM_WIDTH=$((COLUMNS - OFFSET))

if command -v bat >/dev/null 2>&1; then
  preview_program=(
    'bat'
    '--color=always'
    '--tabs=1'
    '--wrap=never'
    "--terminal-width=$FZF_TERM_WIDTH"
    '--italic-text=always'
    '--style=numbers,changes'
  )
else
  preview_program=('cat')
fi

FZF_PREVIEW_CMD="([[ -f {} ]] && \
  $(printf '%q ' "${preview_program[@]}") {} || \
  ([[ -d {} ]] && eza -lAR --color=always {} || \
  echo 'Not a file or directory'))"
FZF_PREVIEW_WINDOW_OPT='right:60%,nowrap,cycle,nofollow,info,nohidden,~1'
FZF_PREVIEW_BORDER='sharp'
FZF_PREVIEW_LABEL='echo {}'
FZF_PREVIEW_LABEL_POS='0'
FZF_HEADER_STR=''
FZF_BORDER_STYLE='none'
FZF_HEADER_LINES_BORDER='none'
FZF_HEADER_LABEL='none'
FZF_HEADER_LABEL_POS='0'
FZF_HEADER_LINES_N='0'

function foo:fzf() {
  :
}

function __pviewer() {
  fzf \
    "${FZF_SEARCH[@]}" \
    "${FZF_IO[@]}" \
    --query="$FZF_QUERY_RESULTS"\
    --style="$FZF_STYLE_PRESET" \
    --color="$FZF_COLOR_COLSPEC" \
    --preview="$FZF_PREVIEW_CMD" \
    --preview-window="$FZF_PREVIEW_WINDOW_OPT" \
    --preview-border="$FZF_PREVIEW_BORDER" \
    --preview-label="$FZF_PREVIEW_LABEL" \
    --preview-label-pos="$FZF_PREVIEW_LABEL_POS" \
    --header="$FZF_HEADER_STR" \
    --header-lines="$FZF_HEADER_LINES_N" \
    --header-border="$FZF_BORDER_STYLE" \
    --header-lines-border="$FZF_HEADER_LINES_BORDER" \
    --header-label="$FZF_HEADER_LABEL" \
    --header-label-pos="$FZF_HEADER_LABEL_POS"
}

# Public function
function pviewer() { __pviewer "$@"; }
alias pv='pviewer'
