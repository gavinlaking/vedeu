require 'test_helper'

module Vedeu

  module Input

    describe DSL do

      let(:described) { Vedeu::Input::DSL }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Input::Keymap.new(name: '_test_') }

      describe '#key' do
        let(:value_or_values) { ['j', :down] }

        subject { instance.key(*value_or_values) { :some_action } }

        it { instance.must_respond_to(:key=) }

        context 'when a block was not given' do
          subject { instance.key(value_or_values) }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when a key was not given' do
          let(:value_or_values) {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when an invalid key was given (nil)' do
          let(:value_or_values) { ['v', nil] }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when an invalid key was given (empty)' do
          let(:value_or_values) { ['v', ''] }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when the key is valid (not already defined)' do
          before { model.stubs(:add).returns(Vedeu::Input::Keymap) }

          it { subject.must_equal(['j', :down]) }
        end

        context 'when the key is not valid (already defined)' do
        end
      end

      describe '#name' do
        let(:_value) { 'gold' }

        subject { instance.name(_value) }

        it { instance.must_respond_to(:name=) }

        it 'defines the name of the keymap' do
          subject
          model.name.must_equal(_value)
        end
      end

    end # DSL

  end # Input

end # Vedeu
