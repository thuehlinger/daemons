require 'spec_helper'

describe Daemons do
  describe '.run' do

    subject { described_class.run script, options }

    let(:script) {
      'spec/support/test_script.rb'
    }
    let(:shell_args) {
      ['run']
    }
    let(:options) {
      { ARGV: shell_args }
    }

    it { expect(subject).to be_a Daemons::ApplicationGroup }
  end
end
