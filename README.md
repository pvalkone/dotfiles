These are my dotfiles. There are many like them, but these ones are mine.

To install my Git configuration using [GNU Stow](https://www.gnu.org/software/stow/):

    $ cd ~
    $ git clone https://github.com/pvalkone/dotfiles.git
    $ cd dotfiles
    $ stow git
    $ ls -alF ~/.gitconfig
    lrwxrwxrwx 1 pvalkone pvalkone 23 Mar 19 23:35 /home/pvalkone/.gitconfig -> dotfiles/git/.gitconfig
