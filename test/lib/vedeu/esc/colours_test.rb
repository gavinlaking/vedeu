# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Colours do

      let(:described) { Vedeu::EscapeSequences::Colours }

      describe '.background_codes' do
        let(:expected) {
          {
            black:         40,
            red:           41,
            green:         42,
            yellow:        43,
            blue:          44,
            magenta:       45,
            cyan:          46,
            light_grey:    47,
            default:       49,
            dark_grey:     100,
            light_red:     101,
            light_green:   102,
            light_yellow:  103,
            light_blue:    104,
            light_magenta: 105,
            light_cyan:    106,
            white:         107,
          }
        }

        it { described.background_codes.must_be_instance_of(Hash) }
        it { described.background_codes.must_equal(expected) }
      end

      describe '.background_colour' do
        subject { described.background_colour }
      end

      describe '.colour' do
        subject { described.colour }
      end

      describe '.foreground_codes' do
        let(:expected) {
          {
            black:         30,
            red:           31,
            green:         32,
            yellow:        33,
            blue:          34,
            magenta:       35,
            cyan:          36,
            light_grey:    37,
            default:       39,
            dark_grey:     90,
            light_red:     91,
            light_green:   92,
            light_yellow:  93,
            light_blue:    94,
            light_magenta: 95,
            light_cyan:    96,
            white:         97,
          }
        }

        it { described.foreground_codes.must_be_instance_of(Hash) }
        it { described.foreground_codes.must_equal(expected) }
      end

      describe '.foreground_colour' do
        it { described.must_respond_to(:foreground_colour) }
      end

      describe '.valid_codes' do
        subject { described.valid_codes }

        it { subject.must_be_instance_of(Array) }
      end

      describe '.valid_name?' do
        let(:named_colour) {}

        subject { described.valid_name?(named_colour) }

        context 'when the named_colour is a Symbol' do
          context 'and the named_colour is valid' do
            let(:named_colour) { :on_light_green }

            it { subject.must_equal(true) }
          end

          context 'and the named_colour is invalid' do
            let(:named_colour) { :beige }

            it { subject.must_equal(false) }
          end
        end

        context 'when the named_colour is not a Symbol' do
          it { subject.must_equal(false) }
        end
      end

    end # Colours

  end # EscapeSequences

end # Vedeu
