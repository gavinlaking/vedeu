# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe BottomRight do

      let(:described) { Vedeu::Cells::BottomRight }
      let(:instance)  { described.new }

      describe '#as_html' do
        subject { instance.as_html }

        it { subject.must_equal('&#x2518;') }
      end

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:bottom_right) }
      end

    end # BottomRight

  end # Cells

end # Vedeu
