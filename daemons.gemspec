require File.expand_path('../lib/daemons/version', __FILE__)

Gem::Specification.new do |s|
  s.name = %q{daemons}
  s.version = Daemons::VERSION
  s.date = %q{2013-06-26}
  s.authors = ["Thomas Uehlinger"]
  s.email = %q{th.uehlinger@gmx.ch}
  s.homepage = %q{http://rubygems.org/gems/daemons}
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

  s.files = [
    "Rakefile",
    "Releases",
    "README.md",
    "LICENSE",
    "setup.rb",
    "lib/*.rb",
    "lib/**/*.rb",
    "examples/**/*.rb",
  ]
end
