# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Colours

    describe Colour do

      let(:described)  { Vedeu::Colours::Colour }
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

        context 'when a background is given' do
          let(:background) { '#ff0000' }

          it do
            instance.instance_variable_get('@background').must_equal(background)
          end
        end

        context 'when a background is not given' do
          let(:background) {}
          let(:expected)   { Vedeu::Colours::Background.new }

          it do
            instance.instance_variable_get('@background').must_equal(expected)
          end
        end

        context 'when a foreground is given' do
          let(:foreground) { '#ff00ff' }

          it do
            instance.instance_variable_get('@foreground').must_equal(foreground)
          end
        end

        context 'when a foreground is not given' do
          let(:foreground) {}
          let(:expected)   { Vedeu::Colours::Foreground.new }

          it do
            instance.instance_variable_get('@foreground').must_equal(expected)
          end
        end
      end

      describe '.coerce' do
        let(:_value) {}

        subject { described.coerce(_value) }

        it { subject.must_be_instance_of(described) }

        context 'when the value is nil' do
          it { subject.foreground.colour.must_equal('') }
          it { subject.background.colour.must_equal('') }
        end

        context 'when the value is a Vedeu::Colour' do
          let(:background) { '#ff00ff' }
          let(:foreground) { '#220022' }
          let(:_value)     { Vedeu::Colours::Colour.new(attributes) }

          it { subject.foreground.colour.must_equal('#220022') }
          it { subject.background.colour.must_equal('#ff00ff') }
          it { subject.to_s.must_equal("\e[38;2;34;0;34m\e[48;2;255;0;255m") }
        end

        context 'when the value is a Hash' do
          context 'when the hash has a :colour defined' do
            context 'when the value of :colour is a Vedeu::Colours::Colour' do
              let(:background) { '#002200' }
              let(:foreground) { '#00ff00' }
              let(:_value) {
                {
                  colour: Vedeu::Colours::Colour.new(attributes),
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
                it { subject.to_s.must_equal("\e[48;2;119;0;255m") }
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
                it { subject.to_s.must_equal("\e[38;2;34;0;119m") }
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

      describe '.default' do
        subject { described.default }

        it { subject.must_be_instance_of(Vedeu::Colours::Colour) }
      end

      describe '#attributes' do
        let(:expected) {
          {
            background: Vedeu::Colours::Background.new,
            foreground: Vedeu::Colours::Foreground.new,
          }
        }

        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(expected) }
      end

      describe '#background' do
        subject { instance.background }

        it { subject.must_be_instance_of(Vedeu::Colours::Background) }

        # @todo Add more tests.
      end

      describe '#background?' do
        subject { instance.background? }

        context 'when the background is set' do
          let(:background) { '#ff0000' }

          it { subject.must_equal(true) }
        end

        context 'when the background is not set' do
          it { subject.must_equal(false) }
        end
      end

      describe '#background=' do
        let(:_value) { '#000000' }

        subject { instance.public_send(:background=, _value) }

        it { subject.must_be_instance_of(Vedeu::Colours::Background) }
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

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#foreground' do
        subject { instance.foreground }

        it { subject.must_be_instance_of(Vedeu::Colours::Foreground) }

        # @todo Add more tests.
      end

      describe '#foreground?' do
        subject { instance.foreground? }

        context 'when the foreground is set' do
          let(:foreground) { '#ff00ff' }

          it { subject.must_equal(true) }
        end

        context 'when the foreground is not set' do
          it { subject.must_equal(false) }
        end
      end

      describe '#foreground=' do
        let(:_value) { '#ff0000' }

        subject { instance.public_send(:foreground=, _value) }

        it { subject.must_be_instance_of(Vedeu::Colours::Foreground) }
      end

      describe '#to_h' do
        subject { instance.to_h }

        it { subject.must_be_instance_of(Hash) }

        context 'with both background and foreground' do
          let(:background) { '#000000' }
          let(:foreground) { '#ff0000' }
          let(:expected)   {
            {
              colour: {
                background: '#000000',
                foreground: '#ff0000',
              }
            }
          }

          it { subject.must_equal(expected) }
        end

        context 'when the foreground is missing' do
          let(:background) { '#000000' }
          let(:expected)   {
            {
              colour: {
                background: '#000000',
                foreground: '',
              }
            }
          }

          it { subject.must_equal(expected) }
        end

        context 'when the background is missing' do
          let(:foreground) { '#ff0000' }
          let(:expected)   {
            {
              colour: {
                background: '',
                foreground: '#ff0000',
              }
            }
          }

          it { subject.must_equal(expected) }
        end

        context 'when both are missing' do
          let(:expected)   {
            {
              colour: {
                background: '',
                foreground: '',
              }
            }
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#to_hash' do
        it { instance.must_respond_to(:to_hash) }
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

  end # Colours

end # Vedeu
