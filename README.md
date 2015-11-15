These are my dotfiles. There are many like them, but these ones are mine.

To install my Git configuration (for example) using [GNU Stow](https://www.gnu.org/software/stow/):

    $ cd ~
    $ git clone https://github.com/pvalkone/dotfiles.git
    $ cd dotfiles
    $ stow git
    $ ls -alF ~/.gitconfig
    lrwxrwxrwx 1 pvalkone pvalkone 23 Mar 19 23:35 /home/pvalkone/.gitconfig -> dotfiles/git/.gitconfig

As another example, to install my ZSH configuration using [Boxen](https://github.com/boxen), edit
`/opt/boxen/repo/modules/people/manifests/pvalkone.pp` (replace `pvalkone` with your GitHub username)
and add the following:

    $home     = "/Users/${::boxen_user}"
    $my       = "${home}/my"
    $dotfiles = "${my}/dotfiles"

    file { $my:
      ensure  => directory
    }

    repository { $dotfiles:
      source  => 'pvalkone/dotfiles',
      require => File[$my]
    }

    file { "${home}/.zshrc":
      ensure  => link,
      target  => "${dotfiles}/zsh/.zshrc",
      require => Repository[$dotfiles]
    }
