require 'test_helper'

module Vedeu

  describe Colour do

    let(:described)  { Vedeu::Colour }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        background: background,
        foreground: foreground,
      }
    }
    let(:background) {}
    let(:foreground) {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it {
        instance.instance_variable_get('@background').
          must_be_instance_of(Vedeu::Background)
      }
      it {
        instance.instance_variable_get('@foreground').
          must_be_instance_of(Vedeu::Foreground)
      }
    end

    describe '.coerce' do
      let(:attributes) {
        {
          background: background,
          foreground: foreground,
        }
      }
      let(:background) {}
      let(:foreground) {}
      let(:_value) {}

      subject { described.coerce(_value) }

      it { subject.must_be_instance_of(Vedeu::Colour) }

      context 'when the value is nil' do
        it { subject.foreground.colour.must_equal('') }
        it { subject.background.colour.must_equal('') }
      end

      context 'when the value is a Vedeu::Colour' do
        let(:background) { '#ff00ff' }
        let(:foreground) { '#220022' }
        let(:_value)     { Vedeu::Colour.new(attributes) }

        it { subject.foreground.colour.must_equal('#220022') }
        it { subject.background.colour.must_equal('#ff00ff') }
        it { subject.to_s.must_equal("\e[38;2;34;0;34m\e[48;2;255;0;255m") }
      end

      context 'when the value is a Hash' do
        context 'when the hash has a :colour defined' do
          context 'when the value of :colour is a Vedeu::Colour' do
            let(:background) { '#002200' }
            let(:foreground) { '#00ff00' }
            let(:_value) {
              {
                colour: Vedeu::Colour.new(attributes),
              }
            }

            it { subject.foreground.colour.must_equal('#00ff00') }
            it { subject.background.colour.must_equal('#002200') }
            it { subject.to_s.must_equal("\e[38;2;0;255;0m\e[48;2;0;34;0m") }
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

              it { subject.foreground.colour.must_equal('') }
              it { subject.background.colour.must_equal('#7700ff') }
              it {
                subject.to_s.must_equal("\e[48;2;119;0;255m")
              }
            end

            context 'and a :foreground is defined' do
              let(:_value) {
                {
                  colour: {
                    foreground: '#220077'
                  }
                }
              }

              it { subject.foreground.colour.must_equal('#220077') }
              it { subject.background.colour.must_equal('') }
              it {
                subject.to_s.must_equal("\e[38;2;34;0;119m")
              }
            end

            context 'and neither a :background or :foreground is defined' do
              let(:_value) {
                {
                  colour: 'wrong'
                }
              }

              it { subject.foreground.colour.must_equal('') }
              it { subject.background.colour.must_equal('') }
              it { subject.to_s.must_equal('') }
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

            it { subject.foreground.colour.must_equal('') }
            it { subject.background.colour.must_equal('#000022') }
            it { subject.to_s.must_equal("\e[48;2;0;0;34m") }
          end

          context 'when the hash has a :foreground defined' do
            let(:_value) {
              {
                foreground: '#aadd00'
              }
            }

            it { subject.foreground.colour.must_equal('#aadd00') }
            it { subject.background.colour.must_equal('') }
            it { subject.to_s.must_equal("\e[38;2;170;221;0m") }
          end

          context 'when neither a :background or :foreground is defined' do
            let(:_value) {
              {
                irrelevant: true
              }
            }

            it { subject.foreground.colour.must_equal('') }
            it { subject.background.colour.must_equal('') }
            it { subject.to_s.must_equal('') }
          end
        end
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

    describe '#foreground=' do
      let(:_value) { '#ff0000' }

      subject { instance.foreground = (_value) }

      it { subject.must_equal(_value) }
    end

    describe '#to_s' do
      subject { instance.to_s }

      it { subject.must_be_instance_of(String) }

      context 'with both background and foreground' do
        let(:background) { '#000000' }
        let(:foreground) { '#ff0000' }

        it { subject.must_equal("\e[38;2;255;0;0m\e[48;2;0;0;0m") }
      end

      context 'when the foreground is missing' do
        let(:background) { '#000000' }

        it { subject.must_equal("\e[48;2;0;0;0m") }
      end

      context 'when the background is missing' do
        let(:foreground) { '#ff0000' }

        it { subject.must_equal("\e[38;2;255;0;0m") }
      end

      context 'when both are missing' do
        it { subject.must_equal('') }
      end
    end

  end # Colour

end # Vedeu
