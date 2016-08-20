if exists('g:loaded_markdown_paste')
  finish
endif
let g:loaded_markdown_paste = 1

if executable('xclip') && executable('pandoc')
  command! MarkdownPaste :r !xclip -sel clip -t text/html -o | pandoc -f html -t markdown

  " The following one is useful when pasting from a messy site (e.g. Quora).
  " After :MarkdownPasteClean, doing :%s/\\\n\\/\r/ also helps.
  command! MarkdownPasteClean :r !xclip -sel clip -t text/html -o | pandoc -f html -t markdown-raw_html-native_divs-native_spans-link_attributes --wrap=none
endif
