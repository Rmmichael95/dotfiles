#
#~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

exec startx

PATH="$HOME/.nvm/.node_modules/bin:$PATH"
export npm_config_prefix=~/.nvm/.node_modules
export TERM=st
