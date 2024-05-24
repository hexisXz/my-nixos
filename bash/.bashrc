# Provide a nice prompt if the terminal supports it.
if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
  PROMPT_COLOR="1;31m"
  ((UID)) && PROMPT_COLOR="1;32m"
  if [ -n "$INSIDE_EMACS" ]; then
    # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
    PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
  else
    PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
  fi
  if test "$TERM" = "xterm"; then
    PS1="\[\033]2;\h:\u:\w\007\]$PS1"
  fi
fi


neofetch
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='eza -al'
alias ll='eza -l'
alias rr='ranger'
#alias htop='btop -t'
#alias top='btop -t'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias ex='tar -xvf'
alias ed="ed -p 'ed:'"
alias nixosrebuild='sudo nixos-rebuild switch'
alias nixosconfig='sudo vim /etc/nixos/configuration.nix'
alias screenshot='grimblast save screen ~/Pictures/screenshot.png'
alias nixosre='sudo nixos-rebuild switch --flake /etc/nixos#default'
alias dvtm='abduco -c dvtm-session dvtm -M'
alias dvtm-restore='abduco -a dvtm-session'
