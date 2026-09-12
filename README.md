# Stalwart's dotfiles

Some of these config files contain hardcoded paths
and expect the repo root to be `/home/stalwart/.dotswt`.

Clone the repo:

```sh
git clone https://github.com/TheStalwart/dotswt.git ~/.dotswt
```

Install [dotbot](https://github.com/anishathalye/dotbot):

```sh
pipx install uv
~/.local/bin/uv tool install dotbot
```

Deploy dotfiles:

```sh
~/.local/bin/dotbot -d ~/.dotswt/ -c ~/.dotswt/dotbot.yaml
```
