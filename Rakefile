require 'rake'
require 'rdoc/task'

task :default do
  sh %{rake -T}
end

desc 'Create the RDOC html files'
rd = Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'html'
  rdoc.title    = 'Daemons'
  rdoc.options << '--line-numbers' << '--inline-source' << '--main' << 'README.md'
  rdoc.rdoc_files.include('README.md', 'Releases', 'LICENSE')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
