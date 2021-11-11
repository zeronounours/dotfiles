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
./manage add default
```

### More advanced usages
Dotfiles uses [Dotbot][dotbot] as the installation engine. It is configured
with three levels of abstraction :
* `parts` are parts of files given as configuration for Dotbot. Refer to the
[documentation][config_doc] for their format. They are defined in `meta/parts`.
* `configs` are groups of `parts`. Parts of a config are concatenated to create
a full config file, given to Dotbot. They are defined in `meta/configs`. Each
line should be the name of a part. Every config is also prepended with the
global part `meta/base.yaml` and appended with `meta/end.yaml`.
* `hosts` are groups of `configs`. They are defined in `meta/host`. Each line
should be the name of a config. A dedicated command `hosts` is implemented
to manage versioning of hosts config files.


The script `manage` should be used to manage configuration and to load or
remove configs and profiles from the current host.
See `install --help` for more information.

### Debugging
To debug the execution of [dotbot][dotbot], the environment variable
`DOTFILES_DEBUG` may be set to any non-null value.

[dotbot]: https://git.io/dotbot
[config_doc]: https://github.com/anishathalye/dotbot#configuration
