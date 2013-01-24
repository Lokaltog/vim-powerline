function! Powerline#Functions#vcscommand#GetBranch(symbol) " {{{
   " VCSCommandGetStatusLine is actually:
   " [b:VCSCommandVCSType b:VCSCommandBufferInfo] or ''
   " it should be possible to test the first var to choose a different branch
   " symbol as per the discussion in issue #100
   let ret = VCSCommandGetStatusLine()

   if ret != ''
      let ret = a:symbol . ' ' . substitute(ret, '\[\(.\+\)\]', '\1', 'g')
   endif

   return ret
endfunction " }}}
