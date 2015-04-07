require 'test_helper'

module Vedeu

  describe Colour do

    let(:described)  { Vedeu::Colour }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        background: '',
        foreground: ''
      }
    }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@attributes').
                    must_equal(attributes) }
    end

    describe '#background' do
      subject { instance.background }

      it { subject.must_be_instance_of(Vedeu::Background) }

      context 'with a background' do
        let(:attributes) {
          {
            background: '#000000'
          }
        }

        it { subject.to_s.must_equal("\e[48;2;0;0;0m") }
        it { subject.to_html.must_equal('#000000') }
      end

      context 'without a background' do
        let(:attributes) { {} }

        it { subject.to_s.must_equal('') }
        it { subject.to_html.must_equal('') }
      end
    end

    describe '#background=' do
      let(:value) { '#000000' }

      subject { instance.background = (value) }

      it { subject.must_equal(value) }
    end

    describe '#eql?' do
      let(:other) { instance }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new(background: '#ff0000') }

        it { subject.must_equal(false) }
      end
    end

    describe '#foreground' do
      subject { instance.foreground }

      it { subject.must_be_instance_of(Vedeu::Foreground) }

      context 'with a foreground' do
        let(:attributes) {
          {
            foreground: '#ff0000'
          }
        }

        it { subject.to_s.must_equal("\e[38;2;255;0;0m") }
        it { subject.to_html.must_equal('#ff0000') }
      end

      context 'without a foreground' do
        let(:attributes) { {} }

        it { subject.to_s.must_equal('') }
        it { subject.to_html.must_equal('') }
      end
    end

    describe '#foreground=' do
      let(:value) { '#ff0000' }

      subject { instance.foreground = (value) }

      it { subject.must_equal(value) }
    end

    describe '#to_s' do
      subject { instance.to_s }

      it { subject.must_be_instance_of(String) }

      context 'with both background and foreground' do
        let(:attributes) {
          {
            foreground: '#ff0000',
            background: '#000000'
          }
        }

        it { subject.must_equal("\e[38;2;255;0;0m\e[48;2;0;0;0m") }
      end

      context 'when the foreground is missing' do
        let(:attributes) {
          {
            background: '#000000'
          }
        }

        it { subject.must_equal("\e[48;2;0;0;0m") }
      end

      context 'when the background is missing' do
        let(:attributes) {
          {
            foreground: '#ff0000',
          }
        }

        it { subject.must_equal("\e[38;2;255;0;0m") }
      end

      context 'when both are missing' do
        let(:attributes) { {} }

        it { subject.must_equal('') }
      end
    end

  end # Colour

end # Vedeu
