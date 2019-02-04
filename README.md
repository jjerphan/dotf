# dotf: small tool to track dotfiles changes ⚙

## Setup (that can be adapted) 🔨

```bash
$ git clone --bare git@github.com:jjerphan/dotf.git $HOME/.dotf
$ alias dotf='/usr/bin/git --git-dir=$HOME/.dotf/ --work-tree=$HOME'
$ dotf checkout -f # ⚠ this will erase previous config
$ exit # and it's done !
```
