require 'test_helper'

module Vedeu

  module Cells

    describe RightVertical do

      let(:described) { Vedeu::Cells::RightVertical }
      let(:instance)  { described.new }

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:right_vertical) }
      end

    end # RightVertical

  end # Cells

end # Vedeu
