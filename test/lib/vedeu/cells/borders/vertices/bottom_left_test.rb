# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe BottomLeft do

      let(:described) { Vedeu::Cells::BottomLeft }
      let(:instance)  { described.new }

      describe '#as_html' do
        subject { instance.as_html }

        it { subject.must_equal('&#x2514;') }
      end

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:bottom_left) }
      end

    end # BottomLeft

  end # Cells

end # Vedeu
