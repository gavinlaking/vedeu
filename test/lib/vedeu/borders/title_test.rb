require 'test_helper'

module Vedeu

  module Borders

    describe Title do

      let(:described) { Vedeu::Borders::Title }
      let(:instance)  { described.new(_value, width) }
      let(:_value)    { 'Aluminium' }
      let(:width)     { 10 }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
        it { instance.instance_variable_get('@width').must_equal(width) }
      end

      describe '.coerce' do
        subject { described.coerce(_value, width) }

        context 'when the value is an instance of Vedeu::Borders::Title' do
          let(:_value) { Vedeu::Borders::Title.new('Aluminium', 10) }

          it { subject.must_equal(_value) }
        end

        context 'when the value is not an instance of Vedeu::Borders::Title' do
          it { subject.must_equal(instance) }
        end
      end

      describe '#characters' do
        subject { instance.characters }

        it { subject.must_equal([' ', 'A', 'l', 'u', 'm', 'i', 'n', ' ']) }
      end

      describe '#empty?' do
        subject { instance.empty? }

        context 'when the value is empty' do
          let(:_value) { '' }

          it { subject.must_equal(true) }
        end

        context 'when the value is not empty' do
          it { subject.must_equal(false) }
        end
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

      describe '#size' do
        subject { instance.size }

        it { subject.must_equal(8) }
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
