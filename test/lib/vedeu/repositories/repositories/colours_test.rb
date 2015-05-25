require 'test_helper'

module Vedeu

  describe Colours do

    let(:described) { Vedeu::Colours }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@storage').must_equal({}) }
    end

    describe '#register' do
      let(:colour)          { 'ff0000' }
      let(:escape_sequence) { 'fake_escape_sequence' }

      subject { instance.register(colour, escape_sequence) }

      it { subject.must_equal('fake_escape_sequence') }
    end

    describe '#registered?' do
      let(:colour) {}

      subject { instance.registered?(colour) }

      context 'when the colour is registered' do
        let(:colour) { '#aa0000' }

        before { instance.register(colour, 'fake_escape_sequence') }

        it { subject.must_equal(true) }
      end

      context 'when the colour is not registered' do
        it { subject.must_equal(false) }
      end
    end

    describe '#reset!' do
      subject { instance.reset! }

      it { subject.must_be_instance_of(Hash) }

      it { subject.must_equal({}) }
    end

    describe '#retrieve' do
      let(:colour) {}

      subject { instance.retrieve(colour) }

      context 'when the colour can be found' do
        let(:colour) { '#bb0000' }

        before { instance.register(colour, 'fake_escape_sequence') }

        it { subject.must_equal('fake_escape_sequence') }
      end

      context 'when the colour cannot be found' do
        it { subject.must_equal('') }
      end
    end

    describe '#retrieve_or_register' do
      let(:colour)          { '#cc0000' }
      let(:escape_sequence) { 'escape_sequence' }

      subject { instance.retrieve_or_register(colour, escape_sequence) }

      context 'when the colour is registered' do
        let(:colour) { '#cc0000' }

        before { instance.register(colour, 'fake_escape_sequence') }

        it { subject.must_equal('fake_escape_sequence') }
      end

      context 'when the colour is not registered' do
        it { subject.must_equal('escape_sequence') }
      end
    end

  end # Colours

end # Vedeu
