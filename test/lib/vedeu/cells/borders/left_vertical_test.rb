# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe LeftVertical do

      let(:described) { Vedeu::Cells::LeftVertical }
      let(:instance)  { described.new }

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:left_vertical) }
      end

    end # LeftVertical

  end # Cells

end # Vedeu
