require_relative '../../../test_helper'

module Vedeu
  describe Directive do
    let(:described_class)    { Directive }
    let(:described_instance) { described_class.new(directives) }
    let(:directives)         {
      {
        position: position,
        colour:   colour,
        style:    style
      }
    }
    let(:position)           { [] }
    let(:colour)             { [] }
    let(:style)              { [] }

    it { described_instance.must_be_instance_of(Directive) }

    describe '.enact' do
      let(:subject) { described_class.enact(directives) }

      it { subject.must_be_instance_of(String) }

      context 'when the position is not set' do
        it { subject.must_equal('') }
      end

      context 'when the position is set' do
        let(:position) { [4, 5] }

        it { subject.must_equal("\e[4;5H") }
      end

      context 'when the colour is not set' do
        it { subject.must_equal('') }
      end

      context 'when the colour is set' do
        let(:colour) { [:red, :black] }

        it { subject.must_equal("\e[38;5;31m\e[48;5;40m") }
      end

      context 'when the style is not set' do
        it { subject.must_equal('') }
      end

      context 'when the style is set' do
        let(:style) { [:normal, :underline, :normal] }

        it { subject.must_equal("\e[0m\e[4m\e[0m") }
      end
    end
  end
end
