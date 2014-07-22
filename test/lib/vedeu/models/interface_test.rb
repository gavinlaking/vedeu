require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe Interface do
    let(:interface) {
      Interface.new({
        name:  '#initialize',
        lines: [],
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        y: 3,
        x: 5,
        z: 2,
        width: 10,
        height: 15,
        current: "\e[1;1H#initialize"
      })
    }

    it 'has a name attribute' do
      interface.name.must_equal('#initialize')
    end

    it 'has a lines attribute' do
      interface.lines.must_equal([])
    end

    it 'has a colour attribute' do
      interface.colour.must_be_instance_of(Colour)
    end

    it 'has a y attribute' do
      interface.y.must_equal(3)
      Interface.new.y.must_equal(1)
    end

    it 'has an x attribute' do
      interface.x.must_equal(5)
      Interface.new.x.must_equal(1)
    end

    it 'has a z attribute' do
      interface.z.must_equal(2)
      Interface.new.z.must_equal(1)
    end

    it 'has a width attribute' do
      interface.width.must_equal(10)
    end

    it 'has a height attribute' do
      interface.height.must_equal(15)
    end

    it 'has a current attribute' do
      interface.current.must_equal("\e[1;1H#initialize")
    end

    it 'has a cursor attribute' do
      interface.cursor.must_equal(true)
      Interface.new({ cursor: false }).cursor.must_equal(false)
    end

    it 'has a centred attribute' do
      interface.centred.must_equal(false)
      Interface.new({ centred: true }).centred.must_equal(true)
    end

    describe '#enqueue' do
      it 'delegates to the Queue class to enqueue itself' do
        skip
      end
    end

    describe '#geometry' do
      it 'delegates to the Coordinate class' do
        interface = Interface.new({
          name:   '#geometry',
          width:  5,
          height: 5
        })
        interface.geometry.must_be_instance_of(Coordinate)
      end
    end

    describe '#origin' do
      it 'delegates to the Coordinate class to get the origin' do
        interface = Interface.new({
          name:   '#origin',
          width:  5,
          height: 5
        })
        interface.origin.must_equal("\e[1;1H")
      end
    end

    describe '#refresh' do
      let(:attributes) {
        {
          name:   '#refresh',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          width:  3,
          height: 3
        }
      }

      it 'returns a blank interface when there is no content to display (initial state)' do
        Interface.new(attributes).refresh.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[1;1H   \e[1;1H" \
          "\e[2;1H   \e[2;1H" \
          "\e[3;1H   \e[3;1H"
        )
      end

      it 'returns the fresh content when content is queued up to be displayed' do
        attributes = {
          name:   '#refresh',
          lines:  [
            { streams: '#refresh' },
            { streams: '#refresh' },
            { streams: '#refresh' }
          ],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          width:  8,
          height: 3
        }
        interface = Interface.new(attributes)
        interface.enqueue

        interface.refresh.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[1;1H        \e[1;1H" \
          "\e[2;1H        \e[2;1H" \
          "\e[3;1H        \e[3;1H" \
          "\e[1;1H#refresh" \
          "\e[2;1H#refresh" \
          "\e[3;1H#refresh"
        )
      end

      it 'returns the previously shown content when there is stale content from last run' do
        attributes = {
          name:   '#refresh',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          width:  8,
          height: 3
        }
        interface = Interface.new(attributes)
        interface.current = "\e[38;5;196m\e[48;5;16m" \
                            "\e[1;1H        \e[1;1H" \
                            "\e[2;1H        \e[2;1H" \
                            "\e[3;1H        \e[3;1H" \
                            "\e[1;1H#refresh" \
                            "\e[2;1H#refresh" \
                            "\e[3;1H#refresh"

        interface.refresh.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[1;1H        \e[1;1H" \
          "\e[2;1H        \e[2;1H" \
          "\e[3;1H        \e[3;1H" \
          "\e[1;1H#refresh" \
          "\e[2;1H#refresh" \
          "\e[3;1H#refresh"
        )
      end
    end

    describe '#to_s' do
      it 'returns an String' do
        Interface.new({
          name:   '#to_s',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          width:  3,
          height: 3
        }).to_s.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[1;1H   \e[1;1H" \
          "\e[2;1H   \e[2;1H" \
          "\e[3;1H   \e[3;1H"
        )
      end
    end

    describe '#to_json' do
      it 'returns an String' do
        Interface.new({
          name:   '#to_json',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          width:  3,
          height: 3
        }).to_json.must_equal("{\"colour\":{\"foreground\":\"#ff0000\",\"background\":\"#000000\"},\"style\":\"\",\"name\":\"#to_json\",\"lines\":[],\"y\":1,\"x\":1,\"z\":1,\"width\":3,\"height\":3,\"cursor\":true}")
      end
    end
  end
end
