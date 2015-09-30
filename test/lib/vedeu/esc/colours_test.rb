require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Colours do

      let(:described) { Vedeu::EscapeSequences::Colours }

      describe 'foreground colour methods' do
        it { described.black.must_equal("\e[30m") }
        it { described.red.must_equal("\e[31m") }
        it { described.green.must_equal("\e[32m") }
        it { described.yellow.must_equal("\e[33m") }
        it { described.blue.must_equal("\e[34m") }
        it { described.magenta.must_equal("\e[35m") }
        it { described.cyan.must_equal("\e[36m") }
        it { described.light_grey.must_equal("\e[37m") }
        it { described.default.must_equal("\e[39m") }
        it { described.dark_grey.must_equal("\e[90m") }
        it { described.light_red.must_equal("\e[91m") }
        it { described.light_green.must_equal("\e[92m") }
        it { described.light_yellow.must_equal("\e[93m") }
        it { described.light_blue.must_equal("\e[94m") }
        it { described.light_magenta.must_equal("\e[95m") }
        it { described.light_cyan.must_equal("\e[96m") }
        it { described.white.must_equal("\e[97m") }

        it 'returns an escape sequence for the foreground colour and resets ' \
           'after calling the block' do
          described.cyan do
            'ununpentium'
          end.must_equal("\e[36mununpentium\e[39m")
        end
      end

      describe '.codes' do
        it { described.codes.must_be_instance_of(Hash) }
        it { described.must_respond_to(:foreground_codes) }
      end

      describe '.background_codes' do
        it { described.background_codes.must_be_instance_of(Hash) }
      end

      describe 'background colour methods' do
        it { described.on_black.must_equal("\e[40m") }
        it { described.on_red.must_equal("\e[41m") }
        it { described.on_green.must_equal("\e[42m") }
        it { described.on_yellow.must_equal("\e[43m") }
        it { described.on_blue.must_equal("\e[44m") }
        it { described.on_magenta.must_equal("\e[45m") }
        it { described.on_cyan.must_equal("\e[46m") }
        it { described.on_light_grey.must_equal("\e[47m") }
        it { described.on_default.must_equal("\e[49m") }
        it { described.on_dark_grey.must_equal("\e[100m") }
        it { described.on_light_red.must_equal("\e[101m") }
        it { described.on_light_green.must_equal("\e[102m") }
        it { described.on_light_yellow.must_equal("\e[103m") }
        it { described.on_light_blue.must_equal("\e[104m") }
        it { described.on_light_magenta.must_equal("\e[105m") }
        it { described.on_light_cyan.must_equal("\e[106m") }
        it { described.on_white.must_equal("\e[107m") }

        it 'returns an escape sequence for the background colour and resets ' \
           'after calling the block' do
          described.on_red do
            'livermorium'
          end.must_equal("\e[41mlivermorium\e[49m")
        end
      end

    end # Colours

  end # EscapeSequences

end # Vedeu
