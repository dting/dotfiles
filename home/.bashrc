# Add `~/bin` to the `$PATH`
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

if ! which brew > /dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
  eval `dircolors ~/.dir_colors`
fi

for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal" killall

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

source $NVM_DIR/nvm.sh
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# VirtualEnv
source /usr/local/bin/virtualenvwrapper.sh
export PIP_REQUIRE_VIRTUALENV=true

gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export PATH="$HOME/bin:$PATH"
