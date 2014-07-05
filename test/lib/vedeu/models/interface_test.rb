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

    describe '#current' do
      let(:subject) { described_instance.current }

      it 'returns a String' do
        subject.must_be_instance_of(String)
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

    describe '#refresh' do
      let(:subject) { described_instance.refresh }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'when content is queued up to be displayed' do
        before { described_instance.enqueue("\e[38;5;196m\e[48;5;16m\e[1;1HContent\e[1;1H\e[2;1HContent\e[2;1H\e[3;1HContent\e[3;1H") }

        it 'returns the fresh content' do
          subject.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1HContent\e[1;1H\e[2;1HContent\e[2;1H\e[3;1HContent\e[3;1H")
        end
      end

      context 'when there is no content to display' do
        it 'returns a blank interface' do
          subject.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1H       \e[1;1H\e[2;1H       \e[2;1H\e[3;1H       \e[3;1H")
        end
      end
    end

    describe '#to_s' do
      let(:subject) { described_instance.to_s }

      it 'returns an String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an String' do
        subject.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1H       \e[1;1H\e[2;1H       \e[2;1H\e[3;1H       \e[3;1H")
      end
    end

    describe '#to_json' do
      let(:subject) { described_instance.to_json }

      it 'returns an String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an String' do
        subject.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\",\"name\":\"dummy\",\"lines\":[],\"y\":1,\"x\":1,\"z\":1,\"width\":7,\"height\":3,\"current\":\"\",\"cursor\":true}")
      end
    end
  end
end
