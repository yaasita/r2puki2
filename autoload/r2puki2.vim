" vim: set sw=4 et fdm=marker:
"
"
" r2puki2.vim - Convert RedmineWiki to Pukiwiki
"
" Version: 1.0
" Maintainer:	yaasita < https://github.com/yaasita/r2puki2 >
" Last Change:	2014/04/22.

function! r2puki2#s:convertpukiwiki() "{{{
    silent! %s/^h1\. \(.\+\)\n\+/* \1\r/
    silent! %s/^h2\. \(.\+\)\n\+/** \1\r/
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
endfunction "}}}
function! r2puki2#s:convertredmine() "{{{
    if (&ft == "markdown")
        " heading
        silent! %s/\v^# (.+)/h1. \1\r/
        silent! %s/\v^## (.+)/h2. \1\r/
        silent! %s/\v^### (.+)/h3. \1\r/
        " list
        silent! %s/\v^(\-|\+) /* /
        silent! %s/\v^    (\-|\+) /** /
        silent! %s/\v^        (\-|\+) /*** /
        " pre
        silent! %s/\v^\n\s{4}(.+)/\r<pre>\r    \1/
        silent! %s/\v^\s{4}(.+)\n\n/    \1\r<\/pre>\r\r/
        " image
        silent! %s/\v^!\[(.+)\]\((.+)\)/\r!\2!\r/
        " quote
        silent! %s/\v`(.{-})`/ *\1* /g
        set ft=redmine
    endif
endfunction "}}}
