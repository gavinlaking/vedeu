require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe Interface do
    let(:described_class)    { Interface }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         {
      {
        name:   'dummy',
        lines:  [],
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        width:  7,
        height: 3
      }
    }

    before do
      Terminal.stubs(:width).returns(40)
      Terminal.stubs(:height).returns(25)
    end

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns a Interface instance' do
        subject.must_be_instance_of(Interface)
      end
    end

    describe '#name' do
      let(:subject) { described_instance.name }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a name attribute' do
        subject.must_equal('dummy')
      end
    end

    describe '#lines' do
      let(:subject) { described_instance.lines }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'has a lines attribute' do
        subject.must_equal([])
      end
    end

    describe '#colour' do
      let(:subject) { described_instance.colour }
    end

    describe '#y' do
      let(:subject) { described_instance.y }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'using a value' do
        let(:attributes) { { y: 17 } }

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
        let(:attributes) { { x: 33 } }

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

    describe '#z' do
      let(:subject) { described_instance.z }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'using a value' do
        let(:attributes) { { z: 2 } }

        it 'returns the value' do
          subject.must_equal(2)
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
        let(:attributes) { { width: 50 } }

        it 'returns the value' do
          subject.must_equal(50)
        end
      end
    end

    describe '#height' do
      let(:subject) { described_instance.height }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'using a value' do
        let(:attributes) { { height: 20 } }

        it 'returns the value' do
          subject.must_equal(20)
        end
      end
    end

    describe '#clear' do
      let(:subject) { described_instance.clear }

      it 'returns a String' do
        subject.must_equal("\e[1;1H       \e[1;1H")
      end
    end

    describe '#current' do
      let(:subject) { described_instance.current }

      it 'returns...' do
        skip
      end
    end

    describe '#current=' do
      let(:subject) { described_instance.current=(value) }
      let(:value)   {}

      it 'returns...' do
        skip
      end
    end

    describe '#cursor' do
      let(:subject) { described_instance.cursor }

      it 'returns a TrueClass' do
        subject.must_be_instance_of(TrueClass)
      end

      context 'when the cursor is off' do
        before { described_instance.cursor=(false) }

        it 'returns a FalseClass' do
          subject.must_be_instance_of(FalseClass)
        end
      end
    end

    describe '#cursor=' do
      let(:subject) { described_instance.cursor=(value) }
      let(:value)   {}

      it 'returns the cursor value' do
        skip
      end
    end

    describe '#dy' do
      let(:subject) { described_instance.dy }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'when the value is greater than the available terminal size' do
        it 'clips the value to the terminal size' do
          subject.must_equal(4)
        end
      end

      context 'when the value is less than the available size' do
        let(:attributes) { { y: 20, height: 4 } }

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
          subject.must_equal(8)
        end
      end

      context 'when the value is less than the available size' do
        let(:attributes) { { x: 17, width: 21 } }

        it 'returns the value' do
          subject.must_equal(38)
        end
      end
    end

    describe '#origin' do
      let(:subject) { described_instance.origin(index) }
      let(:index)   {}
    end

    describe '#refresh' do
      let(:subject) { described_instance.refresh }

      it 'returns a Array' do
        skip
        subject.must_be_instance_of(Array)
      end
    end

    # describe '#to_compositor' do
    #   let(:subject) { described_instance.to_compositor }

    #   it 'returns an Array' do
    #     subject.must_be_instance_of(Array)
    #   end

    #   it 'returns an Array' do
    #     subject.must_equal([])
    #   end
    # end

    describe '#to_s' do
      let(:subject) { described_instance.to_s }

      it 'returns an String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an String' do
        skip
        subject.must_equal("")
      end
    end

    describe '#virtual_x' do
      let(:subject) { described_instance.virtual_x }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the value' do
        subject.must_equal(1)
      end
    end

    describe '#virtual_y' do
      let(:subject) { described_instance.virtual_y }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the value' do
        subject.must_equal(1)
      end
    end
  end
end
