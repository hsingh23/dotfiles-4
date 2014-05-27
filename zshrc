HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=20000

# Allow extended glob patterns (like '**/' is actually '(*/)#')
setopt extended_glob

# Add to path
PATH=~/.cabal/bin:$PATH
PATH=~/.bin:$PATH

# Add to completions
fpath=(~/dotfiles/zsh/plugins/completions/src $fpath)

# Initialize colors
# Necessary for
#     $ echo "$fg[blue] hello world"
# Like is uesd in zsh-colors
autoload -U colors
colors

# Other modules we want to source
. ~/.zsh/zsh_aliases

##############################
# Key bidings
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# Initialize antigen-hs
. ~/.zsh/antigen-hs/init.zsh

# Python autocompletion (http://stackoverflow.com/a/246779/621449)
export PYTHONSTARTUP=~/.pythonrc

# Import omz stuff
. ~/.zsh/from-omz.zsh

# -- Import Spotify specific stuff --
# This should only be done from my work computer and the file might contain
# confidentialities and should therefor not be checked in!
[[ -s "$HOME/.zsh/spotify.zsh" ]] && . ~/.zsh/spotify.zsh

. ~/.zsh/plugin-configs.zsh
