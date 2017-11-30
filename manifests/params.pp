# numix_gtk_theme::params
#
# Handles the module default parameters
#
class numix_gtk_theme::params {
  $group = undef
  $user  = undef

  # Check that the desktop is defined and supported, error if not
  if ($facts['desktop'] != undef and $facts['desktop']['type'] != undef) {
    case $facts['desktop']['type'] {
      'cinnamon': {}
      default:    {
        fail("Desktop ${facts['desktop']['type']} is not supported")
      }
    }
  } else {
    fail('fact desktop.type is not defined, please ensure this fact is defined and run again')
  }

  # Check that the Operating System is supported, error if not
  case $facts['operatingsystem'] {
    'Ubuntu': {}
    default: {
      fail("${facts['operatingsystem']} not supported")
    }
  }
}
