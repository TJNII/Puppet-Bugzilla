# bugzilla webhead: Configure a Bugzilla web server
class bugzilla::webhead (
  $bugzilla_admin_email,
  $bugzilla_admin_name,
  $bugzilla_admin_password,
  ) {

    if $operatingsystem != "debian" {
      fail("bugzilla::webhead only supports Debian at this time.")
    }

    package { 'bugzilla3':
      ensure => installed,
    }

    file { '/usr/share/bugzilla3/web/data/answerfile':
      ensure  => file,
      require => Package['bugzilla3'],
      content  => template("bugzilla/webhead/answerfile.erb"),
    }
  }
            
