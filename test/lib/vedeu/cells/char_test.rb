# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe Char do

      let(:described)  { Vedeu::Cells::Char }
      let(:instance)   { described.new }

      describe '#as_html' do
        subject { instance.as_html }

        context 'when the value is present' do
          # it { subject.must_equal('&nbsp;') }
        end

        context 'when the value is not present' do
          it { subject.must_equal('&nbsp;') }
        end
      end

      describe '#cell?' do
        subject { instance.cell? }

        it { subject.must_equal(false) }
      end

      describe '#text' do
        subject { instance.text }

        it { subject.must_equal('') }
      end

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:char) }
      end

    end # Char

  end # Cells

end # Vedeu
