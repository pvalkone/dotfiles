# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme agnoster

# All built-in plugins can be found at ~/.oh-my-fish/plugins/
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Enable plugins by adding their name separated by a space to the line below.
set fish_plugins archlinux peco theme

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

set PATH $PATH /opt/bin

set -x LESS "-R"
set -x LESSOPEN "| pygmentize -O style=solarizeddark -f console256 -g %s"
set -x JAVA_HOME "/usr/lib/jvm/default"
set -x SCALA_HOME "/usr/share/scala"

alias g "git"
