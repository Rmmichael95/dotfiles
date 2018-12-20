augroup filetypedetect
    " Video
    autocmd BufRead,BufNewFile *.avi,*.mp4,*.mkv,*.mov,*.mpg set filetype=video
    " Audio
    autocmd BufRead,BufNewFile *.mp3,*.flac,*.wav,*.ogg set filetype=audio
    " Mail
    autocmd BufRead,BufNewFile *mutt-* set ft=mail
    " calcurse
    autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set ft=markdown
    " mathmatica
    autocmd BufNewFile,BufRead *.wl,*.wls set ft=mma
    " CSS
    autocmd BufNewFile,BufRead *.scss,*.sass set ft=scss.css
    " Diff
    autocmd BufRead,BufEnter  *.patch,*.rej,*.diff set ft=diff
augroup end
