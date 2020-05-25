#ZSH profile


#if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
#  exec startx
#fi

setterm -blength 0

#exec xmodmap .Xmodmap

export EDITOR='vim'
xdg-mime default org.pwmt.zathura.desktop application/pdf
export NNN_USE_EDITOR=1

XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

export PATH=$PATH:/home/caleb/.local/bin/


