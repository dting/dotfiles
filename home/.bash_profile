if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
