require 'test_helper'
require 'vedeu/models/interface'

module Vedeu
  describe Interface do
    let(:interface) {
      Interface.new({
        name:  '#initialize',
        group: 'my_group',
        lines: [],
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        geometry: {
          y: 3,
          x: 5,
          width: 10,
          height: 15,
        },
        current: "\e[1;1H#initialize"
      })
    }

    it 'has a name attribute' do
      interface.name.must_equal('#initialize')
    end

    it 'has a name attribute' do
      interface.group.must_equal('my_group')
    end

    it 'has a lines attribute' do
      interface.lines.must_equal([])
    end

    it 'has a colour attribute' do
      interface.colour.must_be_instance_of(Colour)
    end

    it 'has a style attribute' do
      interface.style.must_equal('')
    end

    it 'has a geometry attribute' do
      interface.geometry.must_be_instance_of(Geometry)
    end

    it 'has a current attribute' do
      interface.current.must_equal("\e[1;1H#initialize")
    end

    it 'has a cursor attribute' do
      interface.cursor.must_equal(true)
      Interface.new({ cursor: false }).cursor.must_equal(false)
    end

    it 'has a delay attribute' do
      interface.delay.must_equal(0.0)
    end

    describe '#enqueue' do
      it 'delegates to the Queue class to enqueue itself' do
        interface = Interface.new({
          name:   'Interface#enqueue',
          geometry: {
            width:  8,
            height: 2,
          },
          lines:  [ { streams: { text: 'a8f39' } } ]
        })
        interface.enqueue
        interface.dequeue.must_equal(
          "\e[1;1H        \e[1;1H" \
          "\e[2;1H        \e[2;1H" \
          "\e[1;1Ha8f39"
        )
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
          geometry: {
            width:  3,
            height: 3
          }
        }
      }

      it 'returns a blank interface when there is no content to display (initial state)' do
        Terminal.stub(:output, nil) do
          Interface.new(attributes).refresh.must_equal(
            "\e[38;5;196m\e[48;5;16m" \
            "\e[1;1H   \e[1;1H" \
            "\e[2;1H   \e[2;1H" \
            "\e[3;1H   \e[3;1H"
          )
        end
      end

      it 'returns the fresh content when content is queued up to be displayed' do
        attributes = {
          name:   '#refresh',
          lines:  [
            { streams: [{ text: '#refresh' }] },
            { streams: [{ text: '#refresh' }] },
            { streams: [{ text: '#refresh' }] }
          ],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          geometry: {
            width:  11,
            height: 3
          }
        }
        interface = Interface.new(attributes)
        diode = interface.enqueue

        Terminal.stub(:output, nil) do
          interface.refresh.must_equal(
            "\e[38;5;196m\e[48;5;16m" \
            "\e[1;1H           \e[1;1H" \
            "\e[2;1H           \e[2;1H" \
            "\e[3;1H           \e[3;1H" \
            "\e[1;1H#refresh" \
            "\e[2;1H#refresh" \
            "\e[3;1H#refresh"
          )
        end
      end

      it 'returns the previously shown content when there is stale content from last run' do
        attributes = {
          name:   '#refresh',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          geometry: {
            width:  11,
            height: 3
          }
        }
        interface = Interface.new(attributes)
        interface.current = "\e[38;5;196m\e[48;5;16m" \
                            "\e[1;1H           \e[1;1H" \
                            "\e[2;1H           \e[2;1H" \
                            "\e[3;1H           \e[3;1H" \
                            "\e[1;1H#refresh" \
                            "\e[2;1H#refresh" \
                            "\e[3;1H#refresh"

        Terminal.stub(:output, nil) do
          interface.refresh.must_equal(
            "\e[38;5;196m\e[48;5;16m" \
            "\e[1;1H           \e[1;1H" \
            "\e[2;1H           \e[2;1H" \
            "\e[3;1H           \e[3;1H" \
            "\e[1;1H#refresh" \
            "\e[2;1H#refresh" \
            "\e[3;1H#refresh"
          )
        end
      end
    end

    describe '#to_s' do
      it 'returns an string' do
        Interface.new({
          name:   '#to_s',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          geometry: {
            width:  9,
            height: 3
          }
        }).to_s.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[1;1H         \e[1;1H" \
          "\e[2;1H         \e[2;1H" \
          "\e[3;1H         \e[3;1H"
        )
      end
    end
  end
end
