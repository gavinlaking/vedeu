# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe TopHorizontal do

      let(:described) { Vedeu::Cells::TopHorizontal }
      let(:instance)  { described.new }

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:top_horizontal) }
      end

    end # TopHorizontal

  end # Cells

end # Vedeu
