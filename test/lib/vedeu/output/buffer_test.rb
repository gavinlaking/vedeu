require_relative '../../../test_helper'

module Vedeu
  describe Buffer do
    let(:described_class)    { Buffer }
    let(:described_instance) { described_class.new(options) }
    let(:options)            { { width: 4, height: 3 } }
    let(:subject)            { described_instance }

    it 'returns a Buffer instance' do
      subject.must_be_instance_of(Buffer)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get("@options").must_equal(options)
    end

    describe '#to_s' do
      let(:subject) { capture_io { described_instance.to_s }.join }

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
      let(:subject) { described_instance.each }

      it 'returns an Enumerator' do
        subject.must_be_instance_of(Enumerator)
      end
    end

    describe '#cell' do
      let(:subject) { described_instance.cell(y, x) }
      let(:y)       { 1 }
      let(:x)       { 2 }

      it 'returns a Symbol' do
        subject.must_be_instance_of(Symbol)
      end

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
      let(:subject) { described_instance.set_cell(y, x, v) }
      let(:y)       { 1 }
      let(:x)       { 2 }
      let(:v)       { '*' }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

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
      let(:subject) { described_instance.set_row(y, v) }
      let(:y)       { 1 }
      let(:v)       { '****' }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

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
      let(:subject) { described_instance.row }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the content of the row at position y' do
        subject.must_equal([:cell, :cell, :cell, :cell])
      end
    end

    describe '#set_column' do
      let(:subject) { described_instance.set_column(x, v) }
      let(:x)       { 2 }
      let(:v)       { '***' }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

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
      let(:subject) { described_instance.column }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the content of the column at position x' do
        subject.must_equal([:cell, :cell, :cell])
      end
    end
  end
end
