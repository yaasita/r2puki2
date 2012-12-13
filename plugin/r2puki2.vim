" vim: set sw=4 et fdm=marker:
"
"
" r2puki2.vim - Convert RedmineWiki to Pukiwiki
"
" Version: 1.0
" Maintainer:	yaasita < https://github.com/yaasita/r2puki2 >
" Last Change:	2012/12/14.

command! TOpukiwiki call <SID>convertpukiwiki()
"Function: s:convertpukiwiki() {{{1
function! s:convertpukiwiki()
    silent! %s/^h1\. \(.\+\)\n\+/* \1\r/
    silent! %s/^h2\. \(.\+\)\n\+/** \1\r/
    silent! %s/^h3\. \(.\+\)\n\+/*** \1\r/
    silent! %s/^h3\. \(.\+\)\n\+/*** \1\r/
    silent! %s/{{toc}}/#contents/
    silent! %s/^!\([^!]\+\)!/\&ref(\1);/

    let lnum = 1
    let inpre = 0
    while lnum <= line("$")
        let cline = getline(lnum)
        if ( match(cline,"<pre>") > -1 )
            let inpre = 1
        elseif ( match(cline,"</pre>") > -1 )
            let inpre = 0
        endif

        if ( inpre == 1 )
            exec lnum . "s/^/ /"
        endif
        let lnum += 1
    endwhile
    silent! g/<\/\?pre>/d
endfunction
