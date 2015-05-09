require 'spec_helper'

module Daemons
  describe Exception do
    it { is_expected.to be_a RuntimeError }
  end

  describe RuntimeException do
    it { is_expected.to be_a Exception }
  end

  describe CmdException do
    it { is_expected.to be_a Exception }
  end

  describe Error do
    it { is_expected.to be_a Exception }
  end

  describe TimeoutError do
    it { is_expected.to be_a Error }
  end

  describe SystemError do
    subject { described_class.new message, system_error }
    let(:message) { "sample message" }
    let(:system_error) { "sample system error" }

    it { is_expected.to be_a Error }

    describe '#system_error' do
      it { expect(subject.system_error).to eq system_error }
    end
  end
end
