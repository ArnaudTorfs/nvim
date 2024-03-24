nmap <F12> :source \\Client\C$\Users\EOCATOR\Documents\nvim\init.vim
nmap <space>4 $
xmap <space>4 $
nmap <space>6 ^
xmap <space>6 ^
"nmap ; :

set clipboard+=unnamed  " use the clipboards of vim and win

nnoremap <silent> <space>b :call VSCodeNotify('workbench.action.tasks.build')<CR>

nnoremap <silent> <space>f :call VSCodeNotify('editor.action.formatDocument')<CR>
nnoremap <silent> <space>[ :call VSCodeNotify('workbench.action.navigateBack')<CR>
nnoremap <silent> <space>] :call VSCodeNotify('workbench.action.navigateForward')<CR>

"Harpoon
nnoremap <silent> <space>hn :call VSCodeNotify('vscode-harpoon.editEditors')<CR>

nnoremap <silent> <space>h1 :call VSCodeNotify('vscode-harpoon.gotoEditor1')<CR>
nnoremap <silent> <space>h2 :call VSCodeNotify('vscode-harpoon.gotoEditor2')<CR>
nnoremap <silent> <space>h3 :call VSCodeNotify('vscode-harpoon.gotoEditor3')<CR>
nnoremap <silent> <space>h4 :call VSCodeNotify('vscode-harpoon.gotoEditor4')<CR>
nnoremap <silent> <space>h5 :call VSCodeNotify('vscode-harpoon.gotoEditor5')<CR>

nnoremap <silent> <space>hm1 :call VSCodeNotify('vscode-harpoon.addEditor1')<CR>
nnoremap <silent> <space>hm2 :call VSCodeNotify('vscode-harpoon.addEditor2')<CR>
nnoremap <silent> <space>hm3 :call VSCodeNotify('vscode-harpoon.addEditor3')<CR>
nnoremap <silent> <space>hm4 :call VSCodeNotify('vscode-harpoon.addEditor4')<CR>
nnoremap <silent> <space>hm5 :call VSCodeNotify('vscode-harpoon.addEditor5')<CR>

nnoremap <silent> ca :call VSCodeNotify('editor.action.quickFix')<CR>
nnoremap <silent> do :call VSCodeNotify('editor.action.showHover')<CR>

nnoremap <silent> <space>n :call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <silent> <space><space> :call VSCodeNotify('workbench.action.openRecent')<CR>

nnoremap <silent> <space>t :call VSCodeNotify('workbench.view.testing.focus')<CR>
nnoremap <silent> <space>ta :call VSCodeNotify('testing.runAll')<CR>
nnoremap <silent> <space>td :call VSCodeNotify('testing.debugLastRun')<CR>

"Navigate Windows
nnoremap <silent> <space>wh :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <space>wl :call VSCodeNotify('workbench.action.navigateRight')<CR>
nnoremap <silent> <space>wk :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <space>wj :call VSCodeNotify('workbench.action.navigateDown')<CR>

nnoremap <silent> gcc :call VSCodeNotify('editor.action.commentLine')<CR>
xnoremap <silent> gcc :call VSCodeNotify('workbench.action.addComment')<CR>

nnoremap <silent> gr :call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap <silent> gi :call VSCodeNotify('editor.action.goToImplementation')<CR>
nnoremap <silent> ]e :call VSCodeNotify('editor.action.marker.next')<CR>
nnoremap <silent> [e :call VSCodeNotify('editor.action.marker.next')<CR>

nnoremap <silent> <space>z :call VSCodeNotify('workbench.action.toggleZenMode')<CR>

nnoremap <silent> <space>db :call VSCodeNotify('editor.debug.action.toggleBreakpoint')<CR>
nnoremap <silent> <space>dc :call VSCodeNotify('workbench.action.debug.continue')<CR>
nnoremap <silent> <space>ds :call VSCodeNotify('workbench.action.debug.stepOver')<CR>
nnoremap <silent> <space>dk :call VSCodeNotify('workbench.action.debug.stop')<CR>