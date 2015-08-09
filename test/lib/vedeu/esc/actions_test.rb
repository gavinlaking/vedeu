require 'test_helper'

module Vedeu

  module EscapeSequences

  	describe Actions do

      let(:described) { Vedeu::EscapeSequences::Actions }

      before { Vedeu::Terminal.stubs(:size).returns([80, 25]) }

      describe 'action methods' do
        it { described.hide_cursor.must_equal("\e[?25l") }
        it { described.show_cursor.must_equal("\e[?25h") }
        it { described.cursor_position.must_equal("\e[6n") }
        it { described.bg_reset.must_equal("\e[49m") }
        it { described.blink.must_equal("\e[5m") }
        it { described.blink_off.must_equal("\e[25m") }
        it { described.bold.must_equal("\e[1m") }
        it { described.bold_off.must_equal("\e[22m") }
        it { described.dim.must_equal("\e[2m") }
        it { described.fg_reset.must_equal("\e[39m") }
        it { described.negative.must_equal("\e[7m") }
        it { described.positive.must_equal("\e[27m") }
        it { described.reset.must_equal("\e[0m") }
        it { described.underline.must_equal("\e[4m") }
        it { described.underline_off.must_equal("\e[24m") }
      end

      describe '.characters' do
        it { described.characters.must_be_instance_of(Hash) }
      end

  	end # Actions

  end # EscapeSequences

end # Vedeu
