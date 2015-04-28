require 'spec_helper'

describe Daemons do
  let(:script) {
    'spec/support/test_script.rb'
  }
  let(:shell_args) {
    ['run']
  }
  let(:options) {
    { ARGV: shell_args }
  }

  describe '.run' do
    let(:group) {
      instance_double 'ApplicationGroup'
    }
    let(:controller) {
      instance_double 'Controller', group: group, catch_exceptions: ->{}, run: ->{}
    }
    let(:ctrl_instance) {
      described_class.instance_variable_get :@controller
    }
    let(:group_instance) {
      described_class.instance_variable_get :@group
    }

    before do
      allow(Daemons::Controller)
        .to receive(:new)
        .and_return controller

      allow(controller)
        .to receive(:catch_exceptions)
        .and_yield

      Daemons.run script, options
    end


    it { expect(ctrl_instance).to eq controller }
    it { expect(group_instance).to eq group }
    it { expect(controller).to have_received :catch_exceptions }
    it { expect(controller).to have_received :run }

    context 'with custom options hash' do
      let(:options) {
        { foo: "bar", ARGV: shell_args }
      }

      it 'passes a custom options had to the controller' do
        expect(Daemons::Controller)
          .to have_received(:new)
          .with(options, shell_args)
      end
    end

    context 'when options does NOT include :ARGV' do
      pending
    end
  end
end
