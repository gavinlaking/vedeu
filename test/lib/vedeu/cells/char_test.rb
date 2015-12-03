require 'test_helper'

module Vedeu

  module Cells

    describe Char do

      let(:described)  { Vedeu::Cells::Char }
      let(:instance)   { described.new }

      describe '#cell?' do
        subject { instance.cell? }

        it { subject.must_equal(false) }
      end

    end # Char

  end # Cells

end # Vedeu
