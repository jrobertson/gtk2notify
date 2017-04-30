Gem::Specification.new do |s|
  s.name = 'gtk2notify'
  s.version = '0.2.4'
  s.summary = 'Similar in functionality to libnotify'
  s.authors = ['James Robertson']
  s.files = Dir['lib/gtk2notify.rb']
  s.add_runtime_dependency('gtk2svg', '~> 0.3', '>=0.3.12')
  s.signing_key = '../privatekeys/gtk2notify.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/gtk2notify'
end
