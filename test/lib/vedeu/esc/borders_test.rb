require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Borders do

      let(:described) { Vedeu::EscapeSequences::Borders }

      before { Vedeu::Terminal.stubs(:size).returns([80, 25]) }

      describe 'border methods' do
        it { described.border_on.must_equal("\e(0") }
        it { described.border_off.must_equal("\e(B") }

        it { described.bottom_right.must_equal("\x6A") }
        it { described.top_right.must_equal("\x6B") }
        it { described.top_left.must_equal("\x6C") }
        it { described.bottom_left.must_equal("\x6D") }
        it { described.horizontal.must_equal("\x71") }
        it { described.vertical_left.must_equal("\x74") }
        it { described.vertical_right.must_equal("\x75") }
        it { described.horizontal_bottom.must_equal("\x76") }
        it { described.horizontal_top.must_equal("\x77") }
        it { described.vertical.must_equal("\x78") }
      end

      describe '.characters' do
        it { described.characters.must_be_instance_of(Hash) }
      end

    end # Borders

  end # EscapeSequences

end # Vedeu
