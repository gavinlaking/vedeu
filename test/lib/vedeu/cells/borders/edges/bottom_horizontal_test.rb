# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe BottomHorizontal do

      let(:described) { Vedeu::Cells::BottomHorizontal }
      let(:instance)  { described.new }

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:bottom_horizontal) }
      end

    end # BottomHorizontal

  end # Cells

end # Vedeu
