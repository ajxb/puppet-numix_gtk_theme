# numix_gtk_theme::install
#
# Handles the ppa setup, the numix-gtk-theme and fonts-roboto packages
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure the theme for
class numix_gtk_theme::install (
  String $group = $numix_gtk_theme::params::group,
  String $user  = $numix_gtk_theme::params::user,
) inherits numix_gtk_theme::params {
  assert_type(String[1], $group)
  assert_type(String[1], $user)

  include apt
  apt::ppa { 'ppa:numix/ppa': }

  package { 'numix-gtk-theme':
    ensure => 'latest',
  }

  package { 'fonts-roboto':
    ensure => 'latest',
  }

  # Clone numix-cinnamon theme
  vcsrepo { '/tmp/numix-cinnamon':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/zagortenay333/numix-cinnamon.git',
  }

  file { "/home/${user}/.themes":
    ensure => 'directory',
    group  => $group,
    mode   => '0700',
    owner  => $user,
  }

  file { "/home/${user}/.themes/Numix-Cinnamon":
    ensure    => 'directory',
    group     => $group,
    mode      => '0700',
    owner     => $user,
    recurse   => true,
    source    => 'file:///tmp/numix-cinnamon/Numix-Cinnamon',
    require   => File["/home/${user}/.themes"],
    subscribe => Vcsrepo['/tmp/numix-cinnamon'],
  }

  Apt::Ppa['ppa:numix/ppa']
    ~> Class['apt::update']
    -> Package['numix-gtk-theme']
}
