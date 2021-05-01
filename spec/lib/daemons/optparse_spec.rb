require 'spec_helper'

describe Daemons::Optparse do

  let(:controller) { Daemons::Controller.new }
  subject(:optparse) { described_class.new(controller) }

  describe "#parse" do
    subject { optparse.parse(args) }
    [
      {given: [],                               expect: {}},
      {given: ["-t"],                           expect: {ontop: true}},
      {given: ["--ontop"],                      expect: {ontop: true}},
      {given: ["-s"],                           expect: {shush: true}},
      {given: ["--shush"],                      expect: {shush: true}},
      {given: ["-f"],                           expect: {force: true}},
      {given: ["--force"],                      expect: {force: true}},
      {given: ["-n"],                           expect: {no_wait: true}},
      {given: ["--no_wait"],                    expect: {no_wait: true}},
      {given: ["--pid_delimiter", "a.b"],       expect: {pid_delimiter: "a.b"}},
      {given: ["--force_kill_waittime", "42"],  expect: {force_kill_waittime: 42}},
      {given: ["--signals_and_waits", "TERM:20|KILL:20"],  expect: {signals_and_waits: "TERM:20|KILL:20"}},
      {given: ["-l"],                           expect: {log_output: true}},
      {given: ["--log_output"],                 expect: {log_output: true}},
      {given: ["--logfilename", "FILE"],        expect: {logfilename: "FILE"}},
      {given: ["--output_logfilename", "FILE"], expect: {output_logfilename: "FILE"}},
      {given: ["--log_dir", "/dir/"],           expect: {log_dir: "/dir/"}},
      {given: ["--syslog"],                     expect: {log_output_syslog: true}},
      {given: [
          "-t", "-s", "-f", "-n",
          "--pid_delimiter", "a.b",
          "--force_kill_waittime", "42",
          "-l", "--logfilename", "LF",
          "--output_logfilename", "OLF",
          "--log_dir", "/dir/",
          "--syslog"
        ], expect: {
          ontop: true,
          shush: true,
          force: true,
          no_wait: true,
          pid_delimiter: "a.b",
          force_kill_waittime: 42,
          log_output: true,
          log_output_syslog: true,
          logfilename: "LF",
          output_logfilename: "OLF",
          log_dir: "/dir/"
        }
      }
    ].each do |test_options|
      context "with #{test_options[:given]}" do
        let(:args) { test_options[:given] }
        it "returns correctly parsed options" do
          expect(subject).to eql test_options[:expect]
        end
      end
    end
  end

end
