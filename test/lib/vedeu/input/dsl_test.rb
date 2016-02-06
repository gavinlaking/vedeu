# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Input

    describe DSL do

      let(:described) { Vedeu::Input::DSL }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Input::Keymap.new(name: _name) }
      let(:_name)     { :vedeu_input_dsl }

      describe '.keymap' do
        subject {
          described.keymap(_name) do
            # ...
          end
        }

        context 'when a name is not given' do
          let(:_name) {}

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when a name is given' do
          context 'when a block is not given' do
            subject { described.keymap(_name) }

            it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
          end

          context 'when a block is given' do
            it { subject.must_be_instance_of(Vedeu::Input::Keymap) }
          end
        end
      end

      describe '#key=' do
        it { instance.must_respond_to(:key=) }
      end

      describe '#key' do
        let(:keys) { ['j', :down] }

        subject { instance.key(*keys) { :some_action } }

        context 'when a block was not given' do
          subject { instance.key(keys) }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when a key was not given' do
          let(:keys) {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when an invalid key was given (nil)' do
          let(:keys) { ['a', nil] }

          it { subject.must_equal(['a']) }
        end

        context 'when an invalid key was given (empty)' do
          let(:keys) { ['b', ''] }

          it { subject.must_equal(['b']) }
        end

        context 'when the key is valid (not already defined)' do
          before { model.stubs(:add).returns(Vedeu::Input::Keymap) }

          it { subject.must_equal(['j', :down]) }
        end

        context 'when the key is not valid (already defined)' do
          # @todo Add more tests.
        end
      end

    end # DSL

  end # Input

end # Vedeu
