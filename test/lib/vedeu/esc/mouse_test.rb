require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Mouse do

      let(:described) { Vedeu::EscapeSequences::Mouse }

      describe 'mouse methods' do
        it { described.mouse_x10_on.must_equal("\e[?9h") }
        it { described.mouse_x10_off.must_equal("\e[?9l") }
        it { described.mouse_on.must_equal("\e[?1000h") }
        it { described.mouse_off.must_equal("\e[?1000l") }
      end

      describe '.mouse_codes' do
        it { described.mouse_codes.must_be_instance_of(Hash) }
      end

    end # Mouse

  end # EscapeSequences

end # Vedeu
