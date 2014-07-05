require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/esc'

module Vedeu
  describe Esc do
    let(:described_class) { Esc }

    describe '.background_colour' do
      let(:subject) { described_class.background_colour }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[48;5;16m")
      end
    end

    describe '.blink' do
      let(:subject) { described_class.blink }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[5m")
      end
    end

    describe '.blink_off' do
      let(:subject) { described_class.blink_off }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[25m")
      end
    end

    describe '.bold' do
      let(:subject) { described_class.bold }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1m")
      end
    end

    describe '.bold_off' do
      let(:subject) { described_class.bold_off }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[21m")
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

    describe '.clear_line' do
      let(:subject) { described_class.clear_line }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[2K")
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

    describe '.foreground_colour' do
      let(:subject) { described_class.foreground_colour }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[38;5;231m")
      end
    end

    describe '.negative' do
      let(:subject) { described_class.negative }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[7m")
      end
    end

    describe '.positive' do
      let(:subject) { described_class.positive }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[27m")
      end
    end

    describe '.normal' do
      let(:subject) { described_class.normal }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[24m\e[21m\e[27m")
      end
    end

    describe '.dim' do
      let(:subject) { described_class.dim }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[2m")
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

    describe '.underline' do
      let(:subject) { described_class.underline }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[4m")
      end
    end

    describe '.underline_off' do
      let(:subject) { described_class.underline_off }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[24m")
      end
    end
  end
end
