require 'test_helper'

module Vedeu

  module Borders

    describe Title do

      let(:described) { Vedeu::Borders::Title }
      let(:instance)  { described.new(_value, width, chars) }
      let(:_value)    { 'Aluminium' }
      let(:width)     { 10 }
      let(:chars)     { [] }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
        it { instance.instance_variable_get('@width').must_equal(width) }
        it { instance.instance_variable_get('@chars').must_equal(chars) }
      end

      describe '.render' do
        subject { described.render(_value, width, chars) }

        # @todo Add more tests.
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new('Vanadium') }

          it { subject.must_equal(false) }
        end
      end

      describe '#render' do
        let(:top_border) {}

        subject { instance.render(top_border) }

        context 'when the title is empty' do
          # @todo Add more tests.
        end

        context 'when the title is not empty' do
          # @todo Add more tests.
        end
      end

      describe '#to_s' do
        subject { instance.to_s }

        it { subject.must_equal('Aluminium') }
      end

      describe '#value' do
        subject { instance.value }

        it { instance.must_respond_to(:title) }
        it { instance.must_respond_to(:caption) }

        context 'when the value is nil' do
          let(:_value) {}

          it { subject.must_equal('') }
        end

        context 'when the value is not nil' do
          it { subject.must_equal('Aluminium') }
        end
      end

    end # Title

  end # Borders

end # Vedeu
