# numix_gtk_theme

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with numix_gtk_theme](#setup)
    * [What numix_gtk_theme affects](#what-numix_gtk_theme-affects)
    * [Beginning with numix_gtk_theme](#beginning-with-numix_gtk_theme)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The numix_gtk_theme module installs the
[Numix GTK theme](https://github.com/numixproject/numix-gtk-theme) from
[ppa](https://launchpad.net/~numix/+archive/ubuntu/ppa) along with
[Numix-Cinnamon](https://github.com/zagortenay333/numix-cinnamon) from Git
and recommended font [Roboto](https://fonts.google.com/specimen/Roboto) on
Linux Mint.

## Setup

### What numix_gtk_theme affects

* apt configuration to include the Numix ppa
* gsettings to configure user specific use of Numix theme and Roboto fonts

### Beginning with numix_gtk_theme

To install numix-gtk-theme, numix-cinnamon and fonts-roboto:

```puppet
class { 'numix_gtk_theme':
  group => 'agroup',
  user  => 'auser',
}
```

## Usage

The default numix_gtk_theme class installs numix-gtk-theme, numix-cinnamon and
fonts-roboto. To use default configuration:

```puppet
class { 'numix_gtk_theme':
  group => 'agroup',
  user  => 'auser',
}
```

To configure the Cinnamon desktop the following fact must be defined:
```yaml
desktop:
  type: cinnamon
```

Note : In order for this module to work on Linux Mint the OS related facts
need to be overridden to present the machine to Puppet as an Ubuntu 16.04
variant. This works around poor direct support for Linux Mint in the Puppet
universe. An example of the fact overrides that can be used to achieve this
are as follows:

```yaml
lsbdistcodename: xenial
lsbdistdescription: Ubuntu 16.04.3 LTS
lsbdistid: Ubuntu
lsbdistrelease: "16.04"
lsbmajdistrelease: "16.04"
operatingsystem: Ubuntu
operatingsystemmajrelease: "16.04"
operatingsystemrelease: "16.04"
os:
  distro:
    codename: xenial
    description: Ubuntu 16.04.3 LTS
    id: Ubuntu
    release:
      full: "16.04"
      major: "16.04"
  family: Debian
  name: Ubuntu
  release:
    full: "16.04"
    major: "16.04"
osfamily: Debian
```
## Reference

### Classes

#### Public classes

* `numix_gtk_theme`: Installs numix-gtk-theme, numix-cinnamon and fonts-roboto

#### Private classes

* `numix_gtk_theme::config`: Handles the configuration of the theme and fonts
* `numix_gtk_theme::params`: Handles the module default parameters
* `numix_gtk_theme::install`: Handles the ppa setup, the numix-gtk-theme,
numix-cinnamon and fonts-roboto packages

### Parameters

The following parameters are available in the `numix_gtk_theme` class:

#### `user`

Data type: String.

The user to configure. Note this parameter is mandatory and should be passed to
the class on instantiation.

Default value: 'undef'.

#### `group`

Data type: String.

The group associated with the user. Note this parameter is mandatory and should
be passed to the class on instantiation.

Default value: 'undef'.

## Limitations

This module has only been tested against Linux Mint 18.3.  This module is
specific to Linux Mint only.

As numix-gtk-theme is a desktop theme this module will only produce tangible
results when used with a desktop variant of Linux Mint Cinnamon.

## Development

### Contributing

Before starting your work on this module, you should fork the project to your
GitHub account. This allows you to freely experiment with your changes. When
your changes are complete, submit a pull request. All pull requests will be
reviewed and merged if they suit some general guidelines:

* Changes are located in a topic branch
* For new functionality, proper tests are written
* Changes should not solve certain problems on special environments
* Your change does not handle third party software for which dedicated Puppet
modules exist
  * such as creating databases, installing webserver etc.
* Changes follow the recommended Puppet style guidelines from the
[Puppet Language Style Guide](https://docs.puppet.com/puppet/latest/style_guide.html)

### Branches

Choosing a proper name for a branch helps us identify its purpose and possibly
find an associated bug or feature. Generally a branch name should include a
topic such as `bug` or `feature` followed by a description and an issue number
if applicable. Branches should have only changes relevant to a specific issue.

```
git checkout -b bug/service-template-typo-1234
git checkout -b feature/config-handling-1235
```

### Running tests

This project contains tests for [rspec-puppet](http://rspec-puppet.com/) to
verify functionality. For detailed information on using this tool, please see
the relevant documentation.

#### Testing quickstart

```
gem install bundler
bundle install
rake spec
```
