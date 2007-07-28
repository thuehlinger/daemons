
SCRIPT_DIR = File.split(File.expand_path(__FILE__))[0]

$LOAD_PATH << File.join(SCRIPT_DIR, '../lib')


require 'pp'

require 'daemons'


options = {
  :dir_mode => :script,
  :dir => 'tmp',
  :multiple => true
}

Daemons.run(File.join(SCRIPT_DIR,'testapp.rb'), options)

