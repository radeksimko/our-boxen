require boxen::personal

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

node default {
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  osx::recovery_message {
  	'If you found this laptop, please call +44 7733 425 274 ASAP or send email to radek.simko@gmail.com':
  }

  include osx::global::expand_save_dialog
  include osx::finder::empty_trash_securely
  include osx::finder::show_hidden_files
  include osx::finder::show_all_filename_extensions

  osx::dock::hot_corner { 'Top Left':
    action => "Start Screen Saver"
  }

  include osx::no_network_dsstores
}
