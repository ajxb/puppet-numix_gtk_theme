# numix_gtk_theme::config
#
# Configures the Numix theme and Roboto font as system defaults
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure the theme for
class numix_gtk_theme::config (
  String $group = $numix_gtk_theme::params::group,
  String $user  = $numix_gtk_theme::params::user,
) inherits numix_gtk_theme::params {
  assert_type(String[1], $group)
  assert_type(String[1], $user)

  gnome::gsettings { 'org.cinnamon.desktop.wm.preferences_theme':
    key    => 'theme',
    schema => 'org.cinnamon.desktop.wm.preferences',
    user   => $user,
    value  => '\'Numix\'',
  }

  gnome::gsettings { 'org.cinnamon.desktop.interface_gtk-theme':
    key    => 'gtk-theme',
    schema => 'org.cinnamon.desktop.interface',
    user   => $user,
    value  => '\'Numix\'',
  }

  gnome::gsettings { 'org.cinnamon.theme_name':
    key    => 'name',
    schema => 'org.cinnamon.theme',
    user   => $user,
    value  => '\'Numix-Cinnamon\'',
  }

  $dirs = [
    "/home/${user}/.config",
    "/home/${user}/.config/gtk-3.0",
  ]

  file { $dirs:
    ensure => 'directory',
    group  => $group,
    mode   => '0700',
    owner  => $user,
  }

  # Configure gtk-3 settings
  file { "/home/${user}/.config/gtk-3.0/settings.ini":
    ensure  => file,
    group   => $group,
    mode    => '0664',
    owner   => $user,
    source  => 'puppet:///modules/numix_gtk_theme/settings.ini',
    require => File[$dirs],
  }

  gnome::gsettings { 'org.cinnamon.desktop.interface_font-name':
    key    => 'font-name',
    schema => 'org.cinnamon.desktop.interface',
    user   => $user,
    value  => '\'Roboto 9\'',
  }

  gnome::gsettings { 'org.nemo.desktop_font':
    key    => 'font',
    schema => 'org.nemo.desktop',
    user   => $user,
    value  => '\'Roboto 10\'',
  }

  gnome::gsettings { 'org.gnome.desktop.interface_document-font-name':
    key    => 'document-font-name',
    schema => 'org.gnome.desktop.interface',
    user   => $user,
    value  => '\'Roboto 10\'',
  }

  gnome::gsettings { 'org.gnome.desktop.interface_monospace-font-name':
    key    => 'monospace-font-name',
    schema => 'org.gnome.desktop.interface',
    user   => $user,
    value  => '\'Monospace 9\'',
  }

  gnome::gsettings { 'org.cinnamon.desktop.wm.preferences_titlebar-font':
    key    => 'titlebar-font',
    schema => 'org.cinnamon.desktop.wm.preferences',
    user   => $user,
    value  => '\'Roboto Medium 9\'',
  }
}
