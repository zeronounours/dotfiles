Dotfiles
========

A repository with all my dotfiles. This repository uses [Dotbot][dotbot] for
the installation.

Overview
--------


Installation
------------

### Simple installation
Clone and run the installation script:
```bash
git clone https://github.com/zeronounours/dotfiles.git
cd dotfiles
./install add default
```

### More advanced usages
Dotfiles uses [Dotbot][dotbot] as the installation engine. It is configured
with three types of meta config files:
* `configs` are files given as configuration for Dotbot. Refer to the
[documentation][config_doc] for their format.
* `profiles` are groups of `configs`. Each line should be the name of a config.
* `hosts` are per-host configuration. Each line can either refer to a profile
or to a config. `hosts` are useful to keep the configuration of each host in
your VCS.

The script `install` should be used to manage configuration and to load or
remove configs and profiles from the current host.
See `install --help` for more information.


[dotbot]: https://git.io/dotbot
[config_doc]: https://github.com/anishathalye/dotbot#configuration
