# I use this to put rsync commands I often use. It's useful since I tend to
# forgot them otherwise and it's easier to do backwards history search if the
# command names are different.

rsync-dotfiles () {
  # Usage:
  #
  # rsync-dotfiles my.ssh.server.com:

  if ! [[ $1 =~ ':' ]]
  then
    echo "Error, no colon (:) in path, maybe use :/home/arash as suffix?"
    return 1
  fi
  local files_to_rsync
  files_to_rsync=( .antigen-hs \
                   dotfiles .gitconfig .gitignore-global .pythonrc \
                   .vim .vimrc .zsh .zshrc .tmux.conf \
                   .ssh/rc \
                   )
  local excludes
  excludes=(\
      --exclude='.git/' \
      --exclude='YouCompleteMe/' \
      --exclude='xmonad/' \
  )
  # We use --relative to Keep folder structure http://serverfault.com/q/39522,
  # for say .ssh/rc
  (cd $HOME && \
      rsync \
        --relative \
        --verbose --links --recursive $excludes $files_to_rsync $1)
}

rsync-repos-generic () {
  # Rsync repositories
  #
  # Use like this:
  #
  # rsync-repos () {
  #   local src=~/spotify/repos
  #   local dst=/home/arash/spotify
  #   rsync-repos-generic $src $dst $@
  # }

  local src=$1
  local dst_path=$2
  local dst_hostname=$3
  local optional_qualifier=$4

  if [[ $optional_qualifier != "" ]]
  then
    dst_path+="/$(basename $src)"
    src+="/$optional_qualifier"
  fi

  local excludes
  excludes=(\
    --exclude='.git/' \
    --exclude='.tox/' \
    --exclude='*.pyc' \
    --exclude='*.swp' \
    --exclude='*.jar' \
  )
  rsync --verbose --links --recursive $excludes \
    $src "$dst_hostname:$dst_path"
}

fssh () {
  # First ssh to a new machine, first rsync-dotifles, then ssh
  rsync-dotfiles "${1}:"
  ssh "${1}"
}
