# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{daemons}
  s.version = "1.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thomas Uehlinger"]
  #s.autorequire = %q{daemons}
  s.date = %q{2011-03-29}
  s.description = %q{Daemons provides an easy way to wrap existing ruby scripts (for example a self-written server)  to be run as a daemon and to be controlled by simple start/stop/restart commands.  You can also call blocks as daemons and control them from the parent or just daemonize the current process.  Besides this basic functionality, daemons offers many advanced features like exception  backtracing and logging (in case your ruby script crashes) and monitoring and automatic restarting of your processes if they crash.}
  s.email = %q{th.uehlinger@gmx.ch}
  s.extra_rdoc_files = ["README", "Releases", "TODO"]
  s.files = [
    "Rakefile", 
    "Releases", 
    "TODO", 
    "README", 
    "LICENSE", 
    "setup.rb", 
    "lib/daemons.rb", 
    "examples/run", 
    "examples/call", 
    "examples/daemonize" 
  ]
  s.files += Dir['lib/daemons/*.rb']
  s.files += Dir['examples/run/*.rb']
  s.files += Dir['examples/call/*.rb']
  s.files += Dir['examples/daemonize/*.rb']
  
  s.has_rdoc = true
  s.homepage = %q{http://daemons.rubyforge.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{daemons}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A toolkit to create and control daemons in different ways}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
