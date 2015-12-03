require 'test_helper'

module Vedeu

  module Cells

    describe Vertical do

      let(:described) { Vedeu::Cells::Vertical }
      let(:instance)  { described.new }

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:vertical) }
      end

    end # Vertical

  end # Cells

end # Vedeu
