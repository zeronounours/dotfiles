# Dotfiles

A repository with all my dotfiles. This repository uses [Dotbot][dotbot] for
the installation.

## Overview


## Installation

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
* `parts` are parts of files given as configuration for Dotbot.
See [parts](#parts)
* `configs` are groups of `parts`. See [configs](#configs)
* `hosts` are groups of `configs`. See [hosts](#hosts)

The script `manage` should be used to manage configuration and to load or
remove configs and profiles from the current host.
See `manage --help` for more information.

#### parts

Parts are YAML files which is a part of a full Dotbot play. Refer to the
[documentation][config_doc] for their format. They are defined in `meta/parts`.

Here is an example:

```yaml
---
# meta/parts/i3/base.yaml

# defines dynamic dir where config part should be added
- env:
    i3dyn: $dyndir/i3.d

# generate the i3 config and link it in user home
- defer:
    id: i3_conf_gen
    tasks:
      - concat:
          $dyndir/i3.conf: $i3dyn
      - link:
          ~/.config/i3/config: $dyndir/i3.conf

---
# meta/parts/i3/i3.yaml

- link:
    $i3dyn/10_base:               i3/10_base
    $i3dyn/11_default_variables:  i3/11_default_variables
    $i3dyn/20_layout:             i3/20_layout
    $i3dyn/30_keybindings:        i3/30_keybindings
    $i3dyn/50_windows_behaviors:  i3/50_windows_behaviors

...
```

Two parts are defined here:
- `base.yaml`: define an environment to be able link files in a dynamic config
directory and to concat all files in it at the end.
- `i3.yaml`: use the dynamic directory to link basic config files.

#### configs

Configs are groups of `parts`. Parts of a config are concatenated to create
a full Dotbot play. They are defined in `meta/configs`.

Each line should be the name of a part. Every config is also prepended with the
global part `meta/base.yaml` and appended with `meta/end.yaml`.

A very simple templating syntax is implemented for configs, to be able to
create more complexe workflows. It relies on `eval` so be careful with what
you do. An bash syntax is then possible. The function `current_host_has` may
be used to check if a config is loaded (or will be in the current run).

Any line starting with `#` is also considered as a comment and will be ignored.

For instance, the following `python` config add bash configurations related to
python, if bash is already loaded:
```
# add bash/base to get the dyndir configuration
$(if current_host_has bash/bash; then echo "bash/base"; fi)
python/core
$(if current_host_has bash/bash; then echo "python/bash"; fi)
```

It is possible to define **dependencies** of the config. When loading a config
all dependencies will be loaded first. **There is no protection against
loop**, so be careful. To define dependencies, add lines starting with
`dependency=`. You may have several dependencies.

#### hosts

Hosts are group of configs. They are defined in `meta/host`. Each line
should be the name of a config. A dedicated command `hosts` is implemented
to manage versioning of hosts config files. It is the recommended way to
manage host config files.

### Debugging
To debug the execution of [dotbot][dotbot], the environment variable
`DOTFILES_DEBUG` may be set to any non-null value.

[dotbot]: https://git.io/dotbot
[config_doc]: https://github.com/anishathalye/dotbot#configuration
