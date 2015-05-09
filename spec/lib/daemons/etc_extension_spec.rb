require 'spec_helper'

describe Etc do
  describe '#groupname' do
    subject { Etc.groupname gid }

    context 'when there is a match' do
      let(:gid) { 1 }
      it { is_expected.to be_a String }
    end

    context 'when there is NOT a match' do
      let(:gid) { 1_000_000 }
      it { is_expected.to be_nil }
    end
  end

  describe '#username' do
    subject { Etc.username uid }

    context 'when there is a match' do
      let(:uid) { 1 }
      it { is_expected.to be_a String }
    end

    context 'when there is NOT a match' do
      let(:uid) { 1_000_000 }
      it { is_expected.to be_nil }
    end
  end
end
