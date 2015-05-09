require 'spec_helper'

module Daemons
  describe Application do
    subject(:application) { described_class.new group, additional_options }

    let(:app_name) { 'my_app' }
    let(:group)    { ApplicationGroup.new app_name }
    let(:options)  { Hash.new }
    let(:log_dir)  { nil }
    let(:dir_mode) { nil }
    let(:user)     { nil }
    let(:options)  {
      {
        log_dir:  log_dir,
        dir_mode: dir_mode,
        user:     user,
        group:    group
      }
    }
    let(:additional_options) {
      {}
    }

    before do
      allow(group)
        .to receive(:options)
        .and_return options
    end

    describe '#app_argv' do
      let(:app_argv) { "some value" }

      it 'allows an arbitrary value to be set' do
        application.app_argv = app_argv
        expect(application.app_argv).to eq app_argv
      end
    end

    describe '#controller_argv' do
      let(:controller_argv) { "some value" }

      it 'allows an arbitrary value to be set' do
        application.controller_argv = controller_argv
        expect(application.controller_argv).to eq controller_argv
      end
    end

    describe '#pid' do
      subject { application.pid }
      it { is_expected.to be_a PidMem }
    end

    describe '#group' do
      subject { application.group }
      it { is_expected.to eq group }
    end

    describe '#options' do
      subject { application.options }
      it { is_expected.to eq options }
    end

    describe '#show_status_callback=' do
      context 'when the Daemons::Application responds to the supplied method' do
        let(:callback_method) { :inspect }

        it 'sets the callback method on the instance' do
          expect {
            subject.show_status_callback = callback_method
          }.not_to raise_error
        end
      end

      context 'when it does NOT respond' do
        let(:callback_method) { :non_existant_method }

        it 'raises a NameError' do
          expect {
            subject.show_status_callback = callback_method
          }.to raise_error NameError
        end
      end
    end

    describe '#change_privilege' do
      before do
        allow(CurrentProcess)
          .to receive(:change_privilege)
          .with(user, group)
      end

      context 'with :user' do
        let(:user) { double :user }

        before { application.change_privilege }

        it 'changes privileges on the user' do
          expect(CurrentProcess)
            .to have_received(:change_privilege)
            .with(user, group)
        end
      end
    end

    describe '#logdir' do
      subject { application.logdir }

      context 'with :log_dir' do
        let(:log_dir) { '/path/to/logs/' }

        it { is_expected.to eq log_dir }
      end

      context 'without :log_dir' do
        let(:log_dir) { nil }

        context 'and :dir_mode is :system' do
          let(:dir_mode) { :system }

          it { is_expected.to eq '/var/log' }
        end

        context 'and :dir_mode is other' do
          let(:pidfile_dir) { '/path/to/pid' }

          before do
            allow(application)
              .to receive(:pidfile_dir)
              .and_return pidfile_dir
          end

          it { is_expected.to eq pidfile_dir }
        end
      end
    end

    describe '#output_logfilename' do
      subject { application.output_logfilename }

      context 'when an output_logfilename is specified' do
        let(:output_logfilename) {
          'logname.log'
        }
        let(:additional_options) {
          { output_logfilename: output_logfilename }
        }

        it { is_expected.to eq output_logfilename }
      end

      context 'when an output_logfilename is NOT specified' do
        it { is_expected.to eq app_name + '.output' }
      end
    end

    describe '#logfilename' do
      subject { application.logfilename }

      context 'when an logfilename is specified' do
        let(:logfilename) {
          'logname.log'
        }
        let(:additional_options) {
          { logfilename: logfilename }
        }

        it { is_expected.to eq logfilename }
      end

      context 'when a logfilename is NOT specified' do
        it { is_expected.to eq app_name + '.log' }
      end
    end
  end
end
