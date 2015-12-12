require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Mouse do

      let(:described) { Vedeu::EscapeSequences::Mouse }

      describe '.mouse_x10_on' do
        it { described.mouse_x10_on.must_equal("\e[?9h") }
      end

      describe '.mouse_x10_on' do
        it { described.mouse_x10_off.must_equal("\e[?9l") }
      end

      describe '.mouse_on' do
        it { described.mouse_on.must_equal("\e[?1000h") }
      end

      describe '.mouse_off' do
        it { described.mouse_off.must_equal("\e[?1000l") }
      end

    end # Mouse

  end # EscapeSequences

end # Vedeu
