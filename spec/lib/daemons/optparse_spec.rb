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
      {given: [
          "-t", "-s", "-f", "-n", "--pid_delimiter", "a.b"
        ], expect: {
          ontop: true,
          shush: true,
          force: true,
          no_wait: true,
          pid_delimiter: "a.b"
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
