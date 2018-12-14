require File.expand_path('../lib/daemons/version', __FILE__)

Gem::Specification.new do |s|
  s.name = %q{daemons}
  s.version = Daemons::VERSION
  s.authors = ["Thomas Uehlinger"]
  s.license = "MIT"
  s.email = %q{thomas.uehinger@gmail.com}
  s.homepage = %q{https://github.com/thuehlinger/daemons}
  s.summary = %q{A toolkit to create and control daemons in different ways}
  s.description = <<-EOF
    Daemons provides an easy way to wrap existing ruby scripts (for example a
    self-written server)  to be run as a daemon and to be controlled by simple
    start/stop/restart commands.

    You can also call blocks as daemons and control them from the parent or just
    daemonize the current process.

    Besides this basic functionality, daemons offers many advanced features like
    exception backtracing and logging (in case your ruby script crashes) and
    monitoring and automatic restarting of your processes if they crash.
  EOF

  s.metadata = {
    "documentation_uri" => "http://www.rubydoc.info/gems/daemons",
  }
  
  s.files = `git ls-files README.md LICENSE Releases lib examples`.split

  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'pry-byebug', '~> 3.0.0'
end
