require 'test_helper'

module Vedeu

  module Cells

    describe BottomLeft do

      let(:described) { Vedeu::Cells::BottomLeft }
      let(:instance)  { described.new }

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:bottom_left) }
      end

    end # BottomLeft

  end # Cells

end # Vedeu
