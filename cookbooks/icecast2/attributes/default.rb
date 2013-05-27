default['icecast']['home'] = '/home/icecast'
default['icecast']['basedir'] = '/usr/local/share/icecast'
default['icecast']['location'] = 'location'
default['icecast']['admin'] = 'admin'

default['icecast']['limits']['clients'] = 500
default['icecast']['limits']['sources'] = 2
default['icecast']['limits']['threadpool'] = 5
default['icecast']['limits']['queue-size'] = 524288
default['icecast']['limits']['client-timeout'] = 30
default['icecast']['limits']['header-timeout'] = 15
default['icecast']['limits']['source-timeout'] = 10
default['icecast']['limits']['burst-on-connect'] = 1
default['icecast']['limits']['burst-size'] = 65535

default['icecast']['authentication']['source-password'] = 'hackme'
default['icecast']['authentication']['relay-password'] = 'hackme'
default['icecast']['authentication']['admin-user'] = 'admin'
default['icecast']['authentication']['admin-password'] = 'hackme'


default['icecast']['hostname'] = 'localhost'
default['icecast']['listen-socket']['port'] = 8000

default['icecast']['mounts'] = []

lavoz = {
  'name' => '/lavoz',
  #'intro' => '/laberintoQueEs.mp3',
  'dump-file' => 'lavoz.mp3',
  'authentication' => {
    type: 'url',
    options: [
      { name: 'listener_add',     value: 'http://localhost:3000/listener_add' },
      { name: 'listener_remove',  value: 'http://localhost:3000/listener_remove'},
      { name: 'auth_header',      value: 'icecast-auth-user: 1' },
      { name: 'mount_add',        value: 'http://localhost:3000/program_add' },
      { name: 'mount_remove',     value: 'http://localhost:3000/program_remove'}
    ]
  }
}

default['icecast']['mounts'] << lavoz
