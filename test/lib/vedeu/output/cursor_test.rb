require_relative '../../../test_helper'

module Vedeu
  describe Cursor do
    let(:described_class) { Cursor }

    describe '.hide' do
      let(:subject) { described_class.hide }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[?25l")
      end
    end

    describe '.show' do
      let(:subject) { described_class.show }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[?25h")
      end
    end

    describe '.home' do
      let(:subject) { described_class.home }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[H")
      end
    end

    describe '.up' do
      let(:subject) { described_class.up }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1A")
      end
    end

    describe '.down' do
      let(:subject) { described_class.down }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1B")
      end
    end

    describe '.right' do
      let(:subject) { described_class.right }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1C")
      end
    end

    describe '.left' do
      let(:subject) { described_class.left }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1D")
      end
    end

    describe '.save' do
      let(:subject) { described_class.save }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[s")
      end
    end

    describe '.unsave' do
      let(:subject) { described_class.unsave }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[u")
      end
    end

    describe '.save_all' do
      let(:subject) { described_class.save_all }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[7")
      end
    end

    describe '.unsave_all' do
      let(:subject) { described_class.unsave_all }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[8")
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
  end
end
