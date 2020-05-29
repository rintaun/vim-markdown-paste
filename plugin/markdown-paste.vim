if exists('g:loaded_markdown_paste')
  finish
endif
let g:loaded_markdown_paste = 1

if executable('xclip') && executable('pandoc')
  command! MarkdownPaste :r !xclip -sel clip -t text/html -o | pandoc -f html -t markdown
  " The following one is useful when pasting from a messy site (e.g. Quora).
  " After :MarkdownPasteClean, doing :%s/\\\n\\/\r/ also helps.
  command! MarkdownPasteClean :r !xclip -sel clip -t text/html -o | pandoc -f html -t markdown-raw_html-native_divs-native_spans-link_attributes --wrap=none

elseif executable('clipdown') && executable('pbpaste')
  command! MarkdownPaste :r !osascript -e 'the clipboard as «class HTML»' | perl -ne 'print chr foreach unpack("C*",pack("H*",substr($_,11,-3)))' | pandoc -f html -t markdown_strict-raw_html --wrap=none
  command! HTMLPaste :r !pbpaste | pandoc -f html -t markdown_strict-raw_html --wrap=none

  map <F6> :MarkdownPaste<CR>
  map <F7> :HTMLPaste<CR>
endif
