require_relative '../../test_helper'

module Vedeu
  describe Buffer do
    let(:klass)    { Buffer }
    let(:options)  { { width: 4, height: 3 } }
    let(:instance) { klass.new(options) }

    it { instance.must_be_instance_of(Buffer) }

    describe '#to_s' do
      subject { capture_io { instance.to_s }.join }

      # real method should return NilClass; want to capture io rather
      # than have it spew into minitest output in terminal; see test
      # below.
      # it { subject.must_be_instance_of(NilClass) }

      it "outputs the content of the buffer" do
        subject.must_equal("[:cell, :cell, :cell, :cell]\n" \
                           "[:cell, :cell, :cell, :cell]\n" \
                           "[:cell, :cell, :cell, :cell]\n")
      end
    end

    describe '#each' do
      subject { instance.each }

      it { subject.must_be_instance_of(Enumerator) }
    end

    describe '#cell' do
      let(:y) { 1 }
      let(:x) { 2 }

      subject { instance.cell(y, x) }

      it { subject.must_be_instance_of(Symbol) }

      context 'when the reference is in range' do
        it 'returns the value at that location' do
          subject.must_equal(:cell)
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
      end

      context 'when the reference is out of range' do
        let(:y) { 3 }
        let(:x) { 4 }

        it 'raises an exception' do
          proc { subject }.must_raise(OutOfRangeError)
        end
      end
    end

    describe '#set_row' do
      let(:y)        { 1 }
      let(:v)        { '****' }
      let(:instance) { klass.new(options) }

      subject { instance.set_row(y, v) }

      it { subject.must_be_instance_of(Array) }

      context 'when the value is a String' do
        let(:v) { '****' }

        it 'sets the row' do
          subject.must_equal(['*', '*', '*', '*'])
        end
      end

      context 'when the value is an Array' do
        let(:v) { ['*','*','*','*'] }

        it 'sets the row' do
          subject.must_equal(['*', '*', '*', '*'])
        end
      end
    end

    describe '#row' do
      subject { instance.row }

      it { subject.must_be_instance_of(Array) }

      it 'returns the content of the row at position y' do
        subject.must_equal([:cell, :cell, :cell, :cell])
      end
    end

    describe '#set_column' do
      let(:x)        { 2 }
      let(:v)        { '***' }
      let(:instance) { klass.new(options) }

      subject { instance.set_column(x, v) }

      it { subject.must_be_instance_of(Array) }

      context 'when the value is a String' do
        let(:v) { '***' }

        it 'sets the row' do
          subject.must_equal(['*', '*', '*'])
        end
      end

      context 'when the value is an Array' do
        let(:v) { ['*', '*', '*'] }

        it 'sets the row' do
          subject.must_equal(['*', '*', '*'])
        end
      end
    end

    describe '#column' do
      subject { instance.column }

      it { subject.must_be_instance_of(Array) }

      it 'returns the content of the column at position x' do
        subject.must_equal([:cell, :cell, :cell])
      end
    end
  end
end
