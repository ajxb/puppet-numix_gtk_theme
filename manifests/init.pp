# Class: numix_gtk_theme
#
# Manage installation and configuration of numix-gtk-theme along with
# recommended font roboto, installing from ppa
#
# @example Declaring the class
#   class { 'numix_gtk_theme':
#     group => 'agroup',
#     user  => 'auser',
#   }
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure the theme for
class numix_gtk_theme (
  String $group = $numix_gtk_theme::params::group,
  String $user  = $numix_gtk_theme::params::user,
) inherits numix_gtk_theme::params {
  assert_type(String[1], $group)
  assert_type(String[1], $user)

  class { 'numix_gtk_theme::install':
    group   => $group,
    user    => $user,
    require => [
      Group[$group],
      User[$user],
    ],
  }

  class { 'numix_gtk_theme::config':
    group   => $group,
    user    => $user,
    require => [
      Group[$group],
      User[$user],
    ],
  }

  contain numix_gtk_theme::install
  contain numix_gtk_theme::config

  Class['numix_gtk_theme::install']
    -> Class['numix_gtk_theme::config']
}
