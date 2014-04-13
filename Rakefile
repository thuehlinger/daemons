require 'rubygems'

require 'rake/gempackagetask'
require 'rake/packagetask'
require 'rake/rdoctask'

task :default => [:package]

desc "Create the RDOC html files"
rd = Rake::RDocTask.new("rdoc") do |rdoc|
  rdoc.rdoc_dir = 'html'
  rdoc.title    = "Daemons"
  rdoc.options << '--line-numbers' << '--inline-source' << '--main' << 'README'
  rdoc.rdoc_files.include('README', 'TODO', 'Releases')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
