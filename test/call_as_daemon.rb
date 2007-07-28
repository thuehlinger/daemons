SCRIPT_DIR = File.split(File.expand_path(__FILE__))[0]

$LOAD_PATH << File.join(SCRIPT_DIR, '../lib')


require 'pp'

require 'daemons'

print Daemonize::call_as_daemon(File.join(SCRIPT_DIR, 'tmp/call_as_daemon.log')) {
  print "hello"
}