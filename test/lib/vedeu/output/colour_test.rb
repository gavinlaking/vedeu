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
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@attributes').must_equal(attributes) }
    end

    describe '.coerce' do
      let(:_value) {}

      subject { described.coerce(_value) }

      it { subject.must_be_instance_of(described) }

      context 'when the value is nil' do
        it { subject.must_be_instance_of(described) }
        it { subject.attributes.must_equal({ background: '', foreground: '' }) }
      end

      context 'when the value is a Vedeu::Colour' do
        let(:attributes) {
          {
            background: '#ff00ff',
            foreground: '#220022',
          }
        }
        let(:_value) { Vedeu::Colour.new(attributes) }

        it { subject.must_be_instance_of(described) }
        it { subject.attributes.must_equal(attributes) }
      end

      context 'when the value is a Hash' do
        context 'when the hash has a :colour defined' do
          context 'when the value of :colour is a Vedeu::Colour' do
            let(:attributes) {
              {
                background: '#002200',
                foreground: '#00ff00',
              }
            }
            let(:_value) {
              {
                colour: Vedeu::Colour.new(attributes),
              }
            }

            it { subject.must_be_instance_of(described) }
            it { subject.attributes.must_equal(attributes) }
          end

          context 'when the value of :colour is a Hash' do
            context 'and a :background is defined' do
              let(:_value) {
                {
                  colour: {
                    background: '#7700ff'
                  }
                }
              }

              it { subject.must_be_instance_of(described) }
              it { subject.attributes.must_equal({
                background: '#7700ff',
                foreground: '',
              }) }
            end

            context 'and a :foreground is defined' do
              let(:_value) {
                {
                  colour: {
                    foreground: '#220077'
                  }
                }
              }

              it { subject.must_be_instance_of(described) }
              it { subject.attributes.must_equal({
                background: '',
                foreground: '#220077',
              }) }
            end

            context 'and neither a :background or :foreground is defined' do
              let(:_value) {
                {
                  colour: 'wrong'
                }
              }

              it { subject.must_be_instance_of(described) }
              it { subject.attributes.must_equal({
                background: '',
                foreground: '',
              }) }
            end
          end
        end

        context 'when the hash does not have a :colour defined' do
          context 'when the hash has a :background defined' do
            let(:_value) {
              {
                background: '#000022'
              }
            }

            it { subject.must_be_instance_of(described) }
            it { subject.attributes.must_equal({
              background: '#000022',
              foreground: '',
            }) }
          end

          context 'when the hash has a :foreground defined' do
            let(:_value) {
              {
                foreground: '#aadd00'
              }
            }

            it { subject.must_be_instance_of(described) }
            it { subject.attributes.must_equal({
              background: '',
              foreground: '#aadd00',
            }) }
          end

          context 'when neither a :background or :foreground is defined' do
            let(:_value) {
              {
                irrelevant: true
              }
            }

            it { subject.must_be_instance_of(described) }
            it { subject.attributes.must_equal({
              background: '',
              foreground: '',
            }) }
          end
        end
      end
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
      let(:_value) { '#000000' }

      subject { instance.background = (_value) }

      it { subject.must_equal(_value) }
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
      let(:_value) { '#ff0000' }

      subject { instance.foreground = (_value) }

      it { subject.must_equal(_value) }
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
