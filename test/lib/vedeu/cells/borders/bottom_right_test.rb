# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe BottomRight do

      let(:described) { Vedeu::Cells::BottomRight }
      let(:instance)  { described.new }

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:bottom_right) }
      end

    end # BottomRight

  end # Cells

end # Vedeu
