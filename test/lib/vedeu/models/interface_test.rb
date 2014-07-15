require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe Interface do
    let(:attributes) {
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
      def subject
        Interface.new(attributes)
      end

      it 'returns a Interface instance' do
        subject.must_be_instance_of(Interface)
      end
    end

    describe '#name' do
      def subject
        Interface.new(attributes).name
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a name attribute' do
        subject.must_equal('dummy')
      end
    end

    describe '#lines' do
      def subject
        Interface.new(attributes).lines
      end

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'has a lines attribute' do
        subject.must_equal([])
      end
    end

    describe '#colour' do
      def subject
        Interface.new(attributes).colour
      end

      it 'needs a spec, please write one.' do
        skip
      end
    end

    describe '#y' do
      def subject
        Interface.new(attributes).y
      end

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
      def subject
        Interface.new(attributes).x
      end

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
      def subject
        Interface.new(attributes).z
      end

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
      def subject
        Interface.new(attributes).width
      end

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
      def subject
        Interface.new(attributes).height
      end

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
      def subject
        Interface.new(attributes).current
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end
    end

    describe '#cursor' do
      def subject
        Interface.new(attributes).cursor
      end

      it 'returns a TrueClass' do
        subject.must_be_instance_of(TrueClass)
      end

      context 'when the cursor is off' do
        before do
          @interface = Interface.new(attributes)
          @interface.cursor=(false)
        end

        it 'returns a FalseClass' do
          @interface.cursor.must_be_instance_of(FalseClass)
        end
      end
    end

    describe '#refresh' do
      def subject
        Interface.new(attributes).refresh
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'when there is no content to display (initial state)' do
        it 'returns a blank interface' do
          subject.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1H       \e[1;1H\e[2;1H       \e[2;1H\e[3;1H       \e[3;1H")
        end
      end

      context 'when content is queued up to be displayed' do
        before do
          @interface = Interface.new(attributes).enqueue("\e[38;5;196m\e[48;5;16m\e[1;1HContent\e[1;1H\e[2;1HContent\e[2;1H\e[3;1HContent\e[3;1H")
        end

        it 'returns the fresh content' do
          @interface.refresh.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1HContent\e[1;1H\e[2;1HContent\e[2;1H\e[3;1HContent\e[3;1H")
        end
      end

      context 'when there is stale content from last run' do
        before do
          @interface = Interface.new(attributes)
          @interface.current = "\e[38;5;196m\e[48;5;16m\e[1;1HOld\e[1;1H\e[2;1HContent\e[2;1H\e[3;1Here\e[3;1H"
        end

        it 'returns the previously shown content' do
          @interface.refresh.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1HOld\e[1;1H\e[2;1HContent\e[2;1H\e[3;1Here\e[3;1H")
        end
      end
    end

    describe '#to_s' do
      def subject
        Interface.new(attributes).to_s
      end

      it 'returns an String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an String' do
        subject.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1H       \e[1;1H\e[2;1H       \e[2;1H\e[3;1H       \e[3;1H")
      end
    end

    describe '#to_json' do
      def subject
        Interface.new(attributes).to_json
      end

      it 'returns an String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an String' do
        subject.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\",\"name\":\"dummy\",\"lines\":[],\"y\":1,\"x\":1,\"z\":1,\"width\":7,\"height\":3,\"cursor\":true}")
      end
    end
  end
end
