require 'test_helper'

module Vedeu

  describe ColourTranslator do

    let(:described) { Vedeu::ColourTranslator }
    let(:instance)  { described.new(colour) }
    let(:colour)    { '#ff0000' }

    describe 'alias methods' do
      it { instance.must_respond_to(:value) }
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@colour').must_equal(colour) }
    end

    describe '.coerce' do
      let(:_value) {}

      subject { described.coerce(_value) }

      context 'when the value is nil' do
        it { subject.must_be_instance_of(Vedeu::ColourTranslator) }

        it {
          Vedeu::Background.coerce(_value).
            must_be_instance_of(Vedeu::Background)
        }
        it { Vedeu::Background.coerce(_value).colour.must_equal('') }
        it {
          Vedeu::Foreground.coerce(_value).
            must_be_instance_of(Vedeu::Foreground)
        }
        it { Vedeu::Foreground.coerce(_value).colour.must_equal('') }
      end

      context 'when the value is a Vedeu::Background' do
        let(:_value) { Vedeu::Background.new }

        it { subject.must_equal(_value) }
      end

      context 'when the value is a Vedeu::Foreground' do
        let(:_value) { Vedeu::Foreground.new }

        it { subject.must_equal(_value) }
      end

      context 'when the value is not a polymorphic Colour' do
        let(:_value) { '#aadd00' }

        it { subject.must_be_instance_of(Vedeu::ColourTranslator) }
      end
    end

    describe '#empty?' do
      subject { instance.empty? }

      context 'when there is no colour' do
        let(:colour) {}

        it { subject.must_equal(true) }
      end

      context 'when there is a colour' do
        it { subject.must_equal(false) }
      end
    end

    describe '#eql?' do
      let(:other) { instance }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new('#ff00ff') }

        it { subject.must_equal(false) }
      end
    end

    describe '#escape_sequence' do
      subject { instance.escape_sequence }

      context 'when no colour is given' do
        let(:colour) {}

        it { subject.must_equal('') }
      end

      context 'when the colour is a terminal named colour; e.g. :red' do
        let(:colour) { :red }

        it 'raises an exception since the subclasses Background and ' \
           'Foreground handle this' do
          proc { subject }.must_raise(Vedeu::NotImplemented)
        end
      end

      context 'when the colour is a terminal numbered colour; e.g. 122' do
        let(:colour) { 122 }

        it 'raises an exception since the subclasses Background and ' \
           'Foreground handle this' do
          proc { subject }.must_raise(Vedeu::NotImplemented)
        end
      end

      context 'when the colour is a HTML/CSS colour (RGB specified)' do
        let(:colour) { '#ff0000' }

        it 'raises an exception since the subclasses Background and ' \
           'Foreground handle this' do
          proc { subject }.must_raise(Vedeu::NotImplemented)
        end
      end

      context 'when the colour is not supported' do
        let(:colour) { [:not_supported] }

        before { instance.stubs(:registered?).returns(false) }

        it { subject.must_equal('') }
      end
    end

    describe '#to_html' do
      subject { instance.to_html }

      context 'when no colour is given' do
        let(:colour) {}

        it { subject.must_equal('') }
      end

      context 'when the colour is a terminal named colour; e.g. :red' do
        let(:colour) { :red }

        it { subject.must_equal('') }
      end

      context 'when the colour is a terminal numbered colour; e.g. 122' do
        let(:colour) { 122 }

        it { subject.must_equal('') }
      end

      context 'when the colour is a HTML/CSS colour (RGB specified)' do
        let(:colour) { '#ff0000' }

        it { subject.must_equal('#ff0000') }
      end

      context 'when the colour is not supported' do
        let(:colour) { [:not_supported] }

        it { subject.must_equal('') }
      end
    end

  end # ColourTranslator

end # Vedeu
