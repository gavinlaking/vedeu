require 'test_helper'

module Vedeu

  module Generator

    class HelpersTestClass

      include Vedeu::Generator::Helpers

      def initialize(name)
        @name = name
      end

    end # HelpersTestClass

    describe Helpers do

      let(:described) { Vedeu::Generator::Helpers }
      let(:instance)  { Vedeu::Generator::HelpersTestClass.new(_name) }
      let(:_name)     { 'my_first_app' }

      describe '#app_name' do
        subject { instance.app_name }

        # it { subject.must_equal('MyFirstApp') }
      end

      describe '#make_directory' do
        let(:destination) {}

        subject { instance.make_directory(destination) }
      end

      describe '#copy_file' do
        let(:source)      {}
        let(:destination) {}

        subject { instance.copy_file(source, destination) }
      end

      describe '#make_file' do
        let(:source)      {}
        let(:destination) {}

        subject { instance.make_file(source, destination) }
      end

      describe '#touch_file' do
        let(:destination) {}

        subject { instance.touch_file(destination) }
      end

      describe '#name' do
        let(:_name) { 'My_First_APP' }

        subject { instance.name }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal('my_first_app') }
      end

      describe '#name_as_class' do
        subject { instance.name_as_class }

        context 'when the name is a single value' do
          let(:_name) { 'VEDEU' }

          it { subject.must_equal('Vedeu') }
        end

        context 'when the name is an underscored value' do
          it { subject.must_equal('MyFirstApp') }
        end

        context 'when the name contains hyphens' do
          let(:_name) { 'hyphenated-APP' }

          it { subject.must_equal('HyphenatedApp')}
        end
      end

      describe '#output' do
        let(:_message) { 'This is a test message.' }

        before { Vedeu.stubs(:log_stdout) }

        subject { instance.output(_message) }

        it { subject.must_be_instance_of(String) }

        it {
          Vedeu.expects(:log_stdout).
            with(type: :info, message: _message)
          subject
        }

        it { subject.must_equal(_message) }
      end

      describe '#parse' do
        let(:source) {}

        subject { instance.parse(source) }
      end

      describe '#source' do
        subject { instance.source }

        it { subject.must_be_instance_of(String) }

        it { subject.must_match('vedeu/cli/generator/templates/application/.') }
      end

    end # Helpers

  end # Generator

end # Vedeu
