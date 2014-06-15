require_relative '../../../test_helper'

module Vedeu
  describe Esc do
    let(:described_class) { Esc }

    describe '.bold' do
      let(:subject) { described_class.bold }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1m")
      end
    end

    describe '.clear' do
      let(:subject) { described_class.clear }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[2J")
      end
    end

    describe '.esc' do
      let(:subject) { described_class.esc }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[")
      end
    end

    describe '.hide_cursor' do
      let(:subject) { described_class.hide_cursor }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[?25l")
      end
    end

    describe '.inverse' do
      let(:subject) { described_class.inverse }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[7m")
      end
    end

    describe '.reset' do
      let(:subject) { described_class.reset }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[0m")
      end
    end

    describe '.show_cursor' do
      let(:subject) { described_class.show_cursor }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[?25h")
      end
    end

    describe '.underline' do
      let(:subject) { described_class.underline }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[4m")
      end
    end
  end
end
