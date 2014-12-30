require 'test_helper'

module Vedeu

  module DSL

    describe Border do

      let(:described)  { Vedeu::DSL::Border.new(model) }
      let(:model)      { Vedeu::Border.new(interface, attributes) }
      let(:interface)  { mock('Interface') }
      let(:attributes) { {} }
      let(:boolean)    { true }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Border) }

        it { assigns(described, '@model', model) }
      end

      describe '#bottom_left' do
        let(:char) { 'C' }

        subject { described.bottom_left(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'C') }
      end

      describe '#bottom_right' do
        let(:char) { 'D' }

        subject { described.bottom_right(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'D') }
      end

      describe '#horizontal' do
        let(:char) { 'H' }

        subject { described.horizontal(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'H') }
      end

      describe '#show_bottom' do
        subject { described.show_bottom(boolean) }

        it { return_type_for(subject, TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#show_left' do
        subject { described.show_left(boolean) }

        it { return_type_for(subject, TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#show_right' do
        subject { described.show_right(boolean) }

        it { return_type_for(subject, TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#show_top' do
        subject { described.show_top(boolean) }

        it { return_type_for(subject, TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#top_left' do
        let(:char) { 'A' }

        subject { described.top_left(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'A') }
      end

      describe '#top_right' do
        let(:char) { 'B' }

        subject { described.top_right(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'B') }
      end

      describe '#vertical' do
        let(:char) { 'V' }

        subject { described.vertical(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'V') }
      end

    end # Border

  end # DSL

end # Vedeu
