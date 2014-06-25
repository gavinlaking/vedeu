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
      let(:subject) { described_class.up(count) }
      let(:count)   {}

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1A")
      end

      context 'with a count' do
        let(:count) { 3 }

        it 'returns an escape sequence' do
          subject.must_equal("\e[3A")
        end
      end
    end

    describe '.down' do
      let(:subject) { described_class.down(count) }
      let(:count)   {}

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1B")
      end

      context 'with a count' do
        let(:count) { 3 }

        it 'returns an escape sequence' do
          subject.must_equal("\e[3B")
        end
      end
    end

    describe '.right' do
      let(:subject) { described_class.right(count) }
      let(:count)   {}

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1C")
      end

      context 'with a count' do
        let(:count) { 3 }

        it 'returns an escape sequence' do
          subject.must_equal("\e[3C")
        end
      end
    end

    describe '.left' do
      let(:subject) { described_class.left(count) }
      let(:count)   {}

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1D")
      end

      context 'with a count' do
        let(:count) { 3 }

        it 'returns an escape sequence' do
          subject.must_equal("\e[3D")
        end
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

    describe '.restore' do
      let(:subject) { described_class.restore }

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

    describe '.restore_all' do
      let(:subject) { described_class.restore_all }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[8")
      end
    end
  end
end
