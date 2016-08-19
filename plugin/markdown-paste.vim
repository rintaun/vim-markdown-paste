if executable('xclip') && executable('pandoc')
  function! MarkdownPaste()
    return system('xclip -sel clip -t text/html -o | pandoc -f html -t markdown')
  endfunction

  " The following one is useful when pasting from a messy site (e.g. Quora).
  " After :MarkdownCleanPaste, doing :%s/\\\n\\/\r/ also helps.
  function! MarkdownCleanPaste()
    return system('xclip -sel clip -t text/html -o | pandoc -f html -t markdown-raw_html-native_divs-native_spans-link_attributes --wrap=none')
  endfunction

  " inoremap <expr> <C-r><C-m> '<C-r>=system("xclip -sel clip -t text/html -o | pandoc -f html -t markdown-raw_html-native_divs-native_spans-link_attributes --wrap=none", @'.v:register.')<CR>'
  inoremap <C-r><C-m><C-m> <C-r>=MarkdownPasteFunc()<CR>
endif

