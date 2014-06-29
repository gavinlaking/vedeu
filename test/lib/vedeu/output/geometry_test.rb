require_relative '../../../test_helper'

module Vedeu
  describe Geometry do
    let(:described_class)    { Geometry }
    let(:described_instance) { described_class.new(values) }
    let(:values)             { {} }

    before do
      Terminal.stubs(:width).returns(80)
      Terminal.stubs(:height).returns(25)
    end

    describe '#initialize' do
      it 'returns a Geometry instance' do
        described_instance.must_be_instance_of(Geometry)
      end
    end

    describe '#y' do
      let(:subject) { described_instance.y }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'using a value' do
        let(:values) { { y: 17 } }

        it 'returns the value' do
          subject.must_equal(17)
        end
      end

      context 'using the default' do
        it 'returns the default' do
          subject.must_equal(1)
        end
      end
    end

    describe '#x' do
      let(:subject) { described_instance.x }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'using a value' do
        let(:values) { { x: 33 } }

        it 'returns the value' do
          subject.must_equal(33)
        end
      end

      context 'using the default' do
        it 'return the default' do
          subject.must_equal(1)
        end
      end
    end

    describe '#width' do
      let(:subject) { described_instance.width }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'using a value' do
        let(:values) { { width: 50 } }

        it 'returns the value' do
          subject.must_equal(50)
        end
      end

      context 'using :auto' do
        let(:values) { { width: :auto } }

        it 'returns the value' do
          subject.must_equal(80)
        end
      end

      context 'using the default' do
        it 'returns the default' do
          subject.must_equal(80)
        end
      end
    end

    describe '#height' do
      let(:subject) { described_instance.height }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'using a value' do
        let(:values) { { height: 20 } }

        it 'returns the value' do
          subject.must_equal(20)
        end
      end

      context 'using :auto' do
        let(:values) { { height: :auto } }

        it 'returns the value' do
          subject.must_equal(25)
        end
      end

      context 'using the default' do
        it 'returns the default' do
          subject.must_equal(25)
        end
      end
    end

    describe '#dy' do
      let(:subject) { described_instance.dy }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'when the value is greater than the available terminal size' do
        it 'clips the value to the terminal size' do
          subject.must_equal(25)
        end
      end

      context 'when the value is less than the available size' do
        let(:values) { { y: 20, height: 4 } }

        it 'returns the value' do
          subject.must_equal(24)
        end
      end
    end

    describe '#dx' do
      let(:subject) { described_instance.dx }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'when the value is greater than the available terminal size' do
        it 'clips the value to the terminal size' do
          subject.must_equal(80)
        end
      end

      context 'when the value is less than the available size' do
        let(:values) { { x: 17, width: 21 } }

        it 'returns the value' do
          subject.must_equal(38)
        end
      end
    end

    describe '#vx' do
      let(:subject) { described_instance.vx }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the value' do
        subject.must_equal(1)
      end
    end

    describe '#vy' do
      let(:subject) { described_instance.vy }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the value' do
        subject.must_equal(1)
      end
    end
  end
end
