# frozen_string_literal: true

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

      describe '#text' do
        subject { instance.text }

        it { subject.must_equal('') }
      end

    end # Char

  end # Cells

end # Vedeu
