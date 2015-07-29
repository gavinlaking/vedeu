require 'test_helper'

module Vedeu

  module DSL

    describe Border do

      let(:described)  { Vedeu::DSL::Border }
      let(:instance)   { described.new(model, client) }
      let(:model)      { Vedeu::Border.new(attributes) }
      let(:client)     {}
      let(:attributes) { { name: 'borders' } }
      let(:boolean)    { true }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '.border' do
        it { described.must_respond_to(:border) }
      end

      describe '#bottom_left' do
        let(:char) { 'C' }

        subject { instance.bottom_left(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('C') }
      end

      describe '#bottom_right' do
        let(:char) { 'D' }

        subject { instance.bottom_right(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('D') }
      end

      describe '#disable!' do
        subject { instance.disable! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#enable!' do
        subject { instance.enable! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#horizontal' do
        let(:char) { 'H' }

        subject { instance.horizontal(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('H') }
      end

      describe '#show_bottom' do
        subject { instance.show_bottom(boolean) }

        it { instance.must_respond_to(:bottom) }
        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end

        it { instance.must_respond_to(:bottom) }
      end

      describe '#hide_bottom!' do
        subject { instance.hide_bottom! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_bottom!' do
        subject { instance.show_bottom! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#show_left' do
        subject { instance.show_left(boolean) }

        it { subject.must_be_instance_of(TrueClass) }

        it { instance.must_respond_to(:left) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#hide_left!' do
        subject { instance.hide_left! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_left!' do
        subject { instance.show_left! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#show_right' do
        subject { instance.show_right(boolean) }

        it { subject.must_be_instance_of(TrueClass) }

        it { instance.must_respond_to(:right) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#hide_right!' do
        subject { instance.hide_right! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_right!' do
        subject { instance.show_right! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#show_top' do
        subject { instance.show_top(boolean) }

        it { subject.must_be_instance_of(TrueClass) }

        it { instance.must_respond_to(:top) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#hide_top!' do
        subject { instance.hide_top! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_top!' do
        subject { instance.show_top! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#title' do
        let(:_value) { 'Some title'}

        subject { instance.title(_value) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('Some title') }
      end

      describe '#top_left' do
        let(:char) { 'A' }

        subject { instance.top_left(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('A') }
      end

      describe '#top_right' do
        let(:char) { 'B' }

        subject { instance.top_right(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('B') }
      end

      describe '#use' do
        before {
          Vedeu.border 'some_border' do
            title 'Some border'
          end
          Vedeu.border 'other_border' do
            title use('some_border').title
          end
        }
        after { Vedeu.borders.reset }

        subject { instance.use('other_border').title }

        it 'allows the use of another models attributes' do
          subject
          Vedeu.borders.by_name('other_border').title.must_equal('Some border')
        end
      end

      describe '#vertical' do
        let(:char) { 'V' }

        subject { instance.vertical(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('V') }
      end

    end # Border

  end # DSL

end # Vedeu
