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

        context 'when the value is nil' do
          let(:_value) {}

          it { instance.instance_variable_get('@value').must_equal('') }
        end

        context 'when the valus is not nil' do
          it { instance.instance_variable_get('@value').must_equal(_value) }
        end

        context 'when the width is nil' do
          let(:width) {}

          before { Vedeu.stubs(:width).returns(40) }

          it { instance.instance_variable_get('@width').must_equal(40) }
        end

        context 'when the width is not nil' do
          it { instance.instance_variable_get('@width').must_equal(width) }
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

      describe '#size' do
        subject { instance.size }

        it { subject.must_equal(8) }
      end

      describe '#to_s' do
        subject { instance.to_s }

        it { subject.must_equal('Aluminium') }
      end

    end # Title

  end # Borders

end # Vedeu
