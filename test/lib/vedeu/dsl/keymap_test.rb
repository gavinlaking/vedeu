require 'test_helper'

module Vedeu

  module DSL

    describe Keymap do

      let(:described) { Vedeu::DSL::Keymap }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Keymap.new('_test_') }

      describe '#initialize' do
        subject { instance }

        it { return_type_for(subject, described) }
        it { assigns(subject, '@model', model) }
      end

      describe '#key' do
        let(:value_or_values) { ['j', :down] }

        subject { instance.key(*value_or_values) { :some_action } }

        context 'when a block was not given' do
          subject { instance.key(value_or_values) }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when a key was not given' do
          let(:value_or_values) {}

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when an invalid key was given (nil)' do
          let(:value_or_values) { ['v', nil] }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when an invalid key was given (empty)' do
          let(:value_or_values) { ['v', ''] }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when the key is valid' do
          before { model.stubs(:add).returns(Vedeu::Keymap) }

          it { return_value_for(subject, ['j', :down]) }
        end

        context 'when the key is not valid' do
          before { Vedeu.keymaps_repository.stubs(:valid?).raises(KeyInUse) }

          it { proc { subject }.must_raise(KeyInUse) }
        end
      end

      describe '#name' do
        let(:value) { 'gold' }

        subject { instance.name(value) }

        it 'defines the name of the keymap' do
          subject
          model.name.must_equal(value)
        end
      end

    end # Keymap

  end # DSL

end # Vedeu
