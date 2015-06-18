require 'test_helper'

module Vedeu

  module Generator

    describe Application do

      let(:described) { Vedeu::Generator::Application }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'my_first_app' }

      before do
        FileUtils.stubs(:cp_r)
        FileUtils.stubs(:mkdir)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.generate' do
        subject { described.generate(_name) }
      end

      describe '#generate' do
        it { instance.must_respond_to(:generate) }
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

    end # Application

  end # Generator

end # Vedeu
