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

    it 'has a name attribute' do
      Interface.new({ name: 'dummy' }).name.must_equal('dummy')
    end

    it 'has a lines attribute' do
      Interface.new({ lines: [] }).lines.must_equal([])
    end

    it 'has a colour attribute' do
      Interface.new({
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        }
      }).colour.must_be_instance_of(Colour)
    end

    it 'has a y attribute' do
      Interface.new({ y: 17 }).y.must_equal(17)
      Interface.new.y.must_equal(1)
    end

    it 'has an x attribute' do
      Interface.new({ x: 33 }).x.must_equal(33)
      Interface.new.x.must_equal(1)
    end

    it 'has a z attribute' do
      Interface.new({ z: 2 }).z.must_equal(2)
      Interface.new.z.must_equal(1)
    end

    it 'has a width attribute' do
      Interface.new({ width: 50 }).width.must_equal(50)
    end

    it 'has a height attribute' do
      Interface.new({ height: 20 }).height.must_equal(20)
    end

    it 'has a current attribute' do
      Interface.new({ current: '' }).current.must_equal('')
    end

    it 'has a cursor attribute' do
      Interface.new({ cursor: true }).cursor.must_be :==, true
      Interface.new({ cursor: false }).cursor.must_be :==, false
      Interface.new.cursor.must_be :==, true
    end

    describe '#refresh' do
      it 'returns a blank interface when there is no content to display (initial state)' do
        Interface.new(attributes).refresh.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1H       \e[1;1H\e[2;1H       \e[2;1H\e[3;1H       \e[3;1H")
      end

      it 'returns the fresh content when content is queued up to be displayed' do
        @interface = Interface.new(attributes).enqueue("\e[38;5;196m\e[48;5;16m\e[1;1HContent\e[1;1H\e[2;1HContent\e[2;1H\e[3;1HContent\e[3;1H")
        @interface.refresh.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1HContent\e[1;1H\e[2;1HContent\e[2;1H\e[3;1HContent\e[3;1H")
      end

      it 'returns the previously shown content when there is stale content from last run' do
        @interface = Interface.new(attributes)
        @interface.current = "\e[38;5;196m\e[48;5;16m\e[1;1HOld\e[1;1H\e[2;1HContent\e[2;1H\e[3;1Here\e[3;1H"
        @interface.refresh.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1HOld\e[1;1H\e[2;1HContent\e[2;1H\e[3;1Here\e[3;1H")
      end
    end

    describe '#to_s' do
      it 'returns an String' do
        Interface.new({
          name:   'dummy',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          width:  3,
          height: 3
        }).to_s.must_equal("\e[38;5;196m\e[48;5;16m\e[1;1H   \e[1;1H\e[2;1H   \e[2;1H\e[3;1H   \e[3;1H")
      end
    end

    describe '#to_json' do
      it 'returns an String' do
        Interface.new({
          name:   'dummy',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          width:  3,
          height: 3
        }).to_json.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\",\"name\":\"dummy\",\"lines\":[],\"y\":1,\"x\":1,\"z\":1,\"width\":3,\"height\":3,\"cursor\":true}")
      end
    end
  end
end
