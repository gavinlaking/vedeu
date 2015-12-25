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

    end # Colours

  end # EscapeSequences

end # Vedeu
