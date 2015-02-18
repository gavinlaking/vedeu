require 'test_helper'

module Vedeu

  describe Translator do

    let(:described) { Vedeu::Translator }
    let(:instance)  { described.new(colour) }
    let(:colour)    { '#ff0000' }

    describe '#initialize' do
      it { instance.must_be_instance_of(Translator) }
      it { instance.instance_variable_get('@colour').must_equal(colour) }
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
          proc { subject }.must_raise(NotImplemented)
        end
      end

      context 'when the colour is a terminal numbered colour; e.g. 122' do
        let(:colour) { 122 }

        it 'raises an exception since the subclasses Background and ' \
           'Foreground handle this' do
          proc { subject }.must_raise(NotImplemented)
        end
      end

      context 'when the colour is a HTML/CSS colour (RGB specified)' do
        let(:colour) { '#ff0000' }

        it 'raises an exception since the subclasses Background and ' \
           'Foreground handle this' do
          proc { subject }.must_raise(NotImplemented)
        end
      end

      context 'when the colour is not supported' do
        let(:colour) { [:not_supported] }

        it { subject.must_equal('') }
      end
    end

  end # Translator

end # Vedeu
