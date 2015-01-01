require 'test_helper'

module Vedeu

  module DSL

    describe Keymap do

      let(:described) { Vedeu::DSL::Keymap.new(model) }
      let(:model)     { Vedeu::Keymap.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Keymap) }
        it { assigns(described, '@model', model) }
      end

      describe '#interface' do
        subject { described.interface('hydrogen', 'helium') }

        it { return_type_for(subject, Array) }
        it { return_value_for(subject, ['hydrogen', 'helium']) }
      end

      describe '#key' do
        let(:value_or_values) { ['j', :down] }

        subject {
          described.key(value_or_values) do
            key('f') { :some_action }
          end
        }

        context 'when a block was not given' do
          subject { described.key(value_or_values) }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when a key was not given' do
          let(:value_or_values) {}

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        it { skip }
        # it { return_type_for(subject, Vedeu::Keymap) }
      end

    end # Keymap

  end # DSL

end # Vedeu
