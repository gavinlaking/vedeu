require_relative '../../test_helper'

module Vedeu
  describe Buffer do
    let(:klass)   { Buffer }
    let(:options) { { width: 4, height: 3 } }
    let(:instance){ klass.new(options) }

    it 'returns an instance of self' do
      instance.must_be_instance_of(Vedeu::Buffer)
    end

    describe '#contents' do
      subject { capture_io { instance.contents }.join }

      it 'returns the contents of the buffer' do
        subject.must_equal("
' '' '' '' '
' '' '' '' '
' '' '' '' '
")
      end
    end

    describe '#cell' do
      let(:y) { 1 }
      let(:x) { 2 }

      subject { instance.cell(y, x) }

      context 'when the reference is in range' do
        it 'returns the value at that location' do
          subject.must_equal(' ')
        end
      end

      context 'when the reference is out of range' do
        let(:y) { 4 }

        it 'raises an exception' do
          proc { subject }.must_raise(OutOfRangeError)
        end
      end
    end

    describe '#set_cell' do
      let(:y) { 1 }
      let(:x) { 2 }
      let(:v) { '*' }

      subject { instance.set_cell(y, x, v) }

      context 'when the reference is in range' do
        it 'returns the value at that location' do
          subject.must_equal('*')
        end

        it 'updates just that cell' do
          subject
          capture_io { instance.contents }.join.must_equal("
' '' '' '' '
' '' ''*'' '
' '' '' '' '
")
        end
      end

      context 'when the reference is out of range' do
      end
    end

    describe '#set_row' do
      let(:y)        { 1 }
      let(:v)        { '****' }
      let(:instance) { klass.new(options) }

      subject { instance.set_row(y, v) }

      it 'sets the row' do
        subject.must_equal(['*', '*', '*', '*'])
      end

      it 'updates just that row' do
        subject
        capture_io { instance.contents }.join.must_equal("
' '' '' '' '
'*''*''*''*'
' '' '' '' '
")
      end
    end

    describe '#set_column' do
      let(:x)        { 2 }
      let(:v)        { '***' }
      let(:instance) { klass.new(options) }

      subject { instance.set_column(x, v) }

      it 'sets the row' do
        subject.must_equal(['*', '*', '*'])
      end

      it 'updates just that column' do
        subject
        capture_io { instance.contents }.join.must_equal("
' '' ''*'' '
' '' ''*'' '
' '' ''*'' '
")
      end
    end
  end
end
