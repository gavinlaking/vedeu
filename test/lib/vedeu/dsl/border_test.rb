require 'test_helper'

module Vedeu

  module DSL

    describe Border do

      let(:described)  { Vedeu::DSL::Border }
      let(:instance)   { described.new(model) }
      let(:model)      { Vedeu::Border.new(interface, attributes) }
      let(:interface)  { mock('Interface') }
      let(:attributes) { {} }
      let(:boolean)    { true }

      describe '#initialize' do
        subject { instance }

        it { return_type_for(subject, Vedeu::DSL::Border) }

        it { subject.instance_variable_get('@model').must_equal(model) }
      end

      describe '#bottom_left' do
        let(:char) { 'C' }

        subject { instance.bottom_left(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'C') }
      end

      describe '#bottom_right' do
        let(:char) { 'D' }

        subject { instance.bottom_right(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'D') }
      end

      describe '#horizontal' do
        let(:char) { 'H' }

        subject { instance.horizontal(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'H') }
      end

      describe '#show_bottom' do
        subject { instance.show_bottom(boolean) }

        it { return_type_for(subject, TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#show_left' do
        subject { instance.show_left(boolean) }

        it { return_type_for(subject, TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#show_right' do
        subject { instance.show_right(boolean) }

        it { return_type_for(subject, TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#show_top' do
        subject { instance.show_top(boolean) }

        it { return_type_for(subject, TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#top_left' do
        let(:char) { 'A' }

        subject { instance.top_left(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'A') }
      end

      describe '#top_right' do
        let(:char) { 'B' }

        subject { instance.top_right(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'B') }
      end

      describe '#vertical' do
        let(:char) { 'V' }

        subject { instance.vertical(char) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'V') }
      end

    end # Border

  end # DSL

end # Vedeu
