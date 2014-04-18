require_relative '../../test_helper'

module Vedeu
  describe Buffer do
    let(:klass)    { Buffer }
    let(:options)  { { width: 4, height: 3 } }
    let(:instance) { klass.new(options) }

    it { instance.must_be_instance_of(Vedeu::Buffer) }

    describe '#each' do
      subject { instance.each }

      it { subject.must_be_instance_of(Enumerator) }
    end

    describe '#contents' do
      subject { capture_io { instance.contents }.join }

      it { subject.must_be_instance_of(String) }

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

      it { subject.must_be_instance_of(String) }

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

      it { subject.must_be_instance_of(String) }

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
        it 'must have a spec, please write one' do
          skip
        end
      end
    end

    describe '#set_row' do
      let(:y)        { 1 }
      let(:v)        { '****' }
      let(:instance) { klass.new(options) }

      subject { instance.set_row(y, v) }

      it { subject.must_be_instance_of(Array) }

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

    describe '#row' do
      subject { instance.row }

      it { subject.must_be_instance_of(Array) }

      it 'must have a spec, please write one' do
        skip
      end
    end

    describe '#set_column' do
      let(:x)        { 2 }
      let(:v)        { '***' }
      let(:instance) { klass.new(options) }

      subject { instance.set_column(x, v) }

      it { subject.must_be_instance_of(Array) }

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

    describe '#column' do
      subject { instance.column }

      it { subject.must_be_instance_of(Array) }

      it 'must have a spec, please write one' do
        skip
      end
    end
  end
end
