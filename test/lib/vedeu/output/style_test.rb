require_relative '../../../test_helper'

module Vedeu
  describe Style do
    let(:klass) { Style }

    describe '.use' do
      let(:style) {}

      subject { klass.use(style) }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal('') }

      context 'when the style is bold' do
        let(:style) { :bold }

        it { subject.must_equal("\e[1m") }
      end

      context 'when the style is clear' do
        let(:style) { :clear }

        it { subject.must_equal("\e[2J") }
      end

      context 'when the style is hide_cursor' do
        let(:style) { :hide_cursor }

        it { subject.must_equal("\e[?25l") }
      end

      context 'when the style is inverse' do
        let(:style) { :inverse }

        it { subject.must_equal("\e[7m") }
      end

      context 'when the style is reset' do
        let(:style) { :reset }

        it { subject.must_equal("\e[0m") }
      end

      context 'when the style is show_cursor' do
        let(:style) { :show_cursor }

        it { subject.must_equal("\e[?25h") }
      end

      context 'when the style is underline' do
        let(:style) { :underline }

        it { subject.must_equal("\e[4m") }
      end
    end
  end
end
