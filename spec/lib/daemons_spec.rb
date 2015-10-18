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
  let(:group) {
    instance_double 'ApplicationGroup'
  }
  let(:controller) {
    instance_double 'Controller',
      group: group,
      catch_exceptions: ->{},
      run: ->{}
  }

  def stub_controller
    allow(Daemons::Controller)
      .to receive(:new)
      .and_return controller

    allow(controller)
      .to receive(:catch_exceptions)
      .and_yield
  end

  describe '.run' do
    let(:ctrl_instance) {
      described_class.instance_variable_get :@controller
    }
    let(:group_instance) {
      described_class.instance_variable_get :@group
    }

    before do
      stub_controller
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
  end

  describe '.run_proc' do
    let(:app_name) { 'my_app' }
    let(:block) { ->{} }
    let(:test_object) { double }
    let(:dir_mode) { :normal }
    let(:dir) {
      File.expand_path '.'
    }
    let(:routine_block) {
      ->{ test_object.run }
    }
    let(:options) {
      { ARGV: shell_args,
        app_name: app_name,
        mode: :proc,
        proc: routine_block,
        dir_mode: dir_mode,
        dir: dir }
    }

    context 'when options[:dir_mode] is nil' do
      let(:dir_mode) { nil }

      before do
        allow(test_object)
          .to receive(:run)

        stub_controller
        Daemons.run_proc(app_name, options, &routine_block)
      end

      it do
        expect(Daemons::Controller)
          .to have_received(:new)
          .with options, shell_args
      end

      it do
        expect(controller)
          .to have_received(:run)
      end
    end
  end
end
