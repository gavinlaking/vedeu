require 'test_helper'
require 'vedeu/models/composition'
require 'vedeu/support/persistence'

module Vedeu
  describe Composition do
    describe '.enqueue' do
      it 'enqueues the interfaces for rendering' do
        attributes = {
          interfaces: [
            {
              name: 'Composition.enqueue_1',
              width: 35,
              height: 5,
              lines: {
                streams: {
                  text: 'bd459118e6175689e4394e242debc2ae'
                }
              }
            }, {
              name: 'Composition.enqueue_2',
              width: 35,
              height: 5,
              lines: {
                streams: {
                  text: '837acb2cb2ea3ef359257851142a7830'
                }
              }
            }
          ]
        }

        Composition.enqueue(attributes)
        Persistence
          .query('Composition.enqueue_1').dequeue
          .must_match(/bd459118e6175689e4394e242debc2ae/)
        Persistence
          .query('Composition.enqueue_2').dequeue
          .must_match(/837acb2cb2ea3ef359257851142a7830/)
      end
    end

    describe '#interfaces' do
      it 'returns a collection of interfaces' do
        Composition.new({
          interfaces: {
            name:   'dummy',
            width:  5,
            height: 5
          }
        }).interfaces.first.must_be_instance_of(Interface)
      end

      it 'returns an empty collection when no interfaces are associated' do
        Composition.new.interfaces.must_be_empty
      end
    end

    describe '#to_json' do
      it 'returns the model as JSON' do
        attributes = {
          interfaces: [
            {
              name: 'Composition#to_json',
              width: 5,
              height: 5,
              colour: {
                foreground: '#ffff33',
                background: '#ffff77'
              }
            }
          ]
        }

        Composition.new(attributes).to_json.must_equal("{\"interfaces\":[{\"colour\":{\"foreground\":\"\#ffff33\",\"background\":\"\#ffff77\"},\"style\":\"\",\"name\":\"Composition#to_json\",\"lines\":[],\"y\":1,\"x\":1,\"width\":5,\"height\":5,\"cursor\":true}]}")
      end
    end

    describe '#to_s' do
      it 'returns the stringified content for a single interface, single line, single stream' do
        Persistence.create({ name: 'int1_lin1_str1', y: 3, x: 3, width: 15, height: 3 })
        json = File.read('test/support/json/int1_lin1_str1.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text..."
        )
      end

      it 'returns the stringified content for a single interface, single line, multiple streams' do
        Persistence.create({ name: 'int1_lin1_str3', y: 3, x: 3, width: 30, height: 3 })
        json = File.read('test/support/json/int1_lin1_str3.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3HSome text... more text..."
        )
      end

      it 'returns the stringified content for a single interface, multiple lines, single stream' do
        Persistence.create({ name: 'int1_lin2_str1', y: 3, x: 3, width: 15, height: 3 })
        json = File.read('test/support/json/int1_lin2_str1.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text..." \
          "\e[4;3HSome text..."
        )
      end

      it 'returns the stringified content for a single interface, multiple lines, multiple streams' do
        Persistence.create({ name: 'int1_lin2_str3', y: 3, x: 3, width: 30, height: 3 })
        json = File.read('test/support/json/int1_lin2_str3.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3HSome text... more text..." \
          "\e[4;3HSome text... more text..."
        )
      end

      it 'returns the stringified content for a single interface, multiple lines, multiple streams, streams contain styles' do
        json = File.read('test/support/json/int1_lin2_str3_styles.json')
        attributes = JSON.load(json, nil, symbolize_names: true)
        Persistence.create({ name: 'int1_lin2_str3_styles', y: 3, x: 3, width: 30, height: 3 })

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3H\e[38;5;16m\e[48;5;21mSome text...\e[38;5;226m\e[48;5;46m \e[38;5;231m\e[48;5;201mmore text..."
        )
      end

      it 'returns the stringified content for multiple interfaces, single line, single stream' do
        Persistence.create({ name: 'int2_lin1_str1_1', y: 3, x: 3, width: 15, height: 3 })
        Persistence.create({ name: 'int2_lin1_str1_2', y: 6, x: 6, width: 15, height: 3 })
        json = File.read('test/support/json/int2_lin1_str1.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text..." \
          "\e[6;6H               \e[6;6H" \
          "\e[7;6H               \e[7;6H" \
          "\e[8;6H               \e[8;6H" \
          "\e[6;6HSome text..."
        )
      end

      it 'returns the stringified content for multiple interfaces, single line, multiple streams' do
        Persistence.create({ name: 'int2_lin1_str3_1', y: 3, x: 3, width: 30, height: 3 })
        Persistence.create({ name: 'int2_lin1_str3_2', y: 6, x: 6, width: 30, height: 3 })
        json = File.read('test/support/json/int2_lin1_str3.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3HSome text... more text..."             \
          "\e[6;6H                              \e[6;6H" \
          "\e[7;6H                              \e[7;6H" \
          "\e[8;6H                              \e[8;6H" \
          "\e[6;6HSome text... more text..."
        )
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, single stream' do
        Persistence.create({ name: 'int2_lin2_str1_1', y: 3, x: 3, width: 15, height: 3 })
        Persistence.create({ name: 'int2_lin2_str1_2', y: 6, x: 6, width: 15, height: 3 })
        json = File.read('test/support/json/int2_lin2_str1.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text..." \
          "\e[4;3HSome text..." \
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text..." \
          "\e[4;3HSome text..."
        )
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, multiple streams' do
        Persistence.create({ name: 'int2_lin2_str3_1', y: 3, x: 3, width: 30, height: 3 })
        Persistence.create({ name: 'int2_lin2_str3_2', y: 6, x: 6, width: 30, height: 3 })
        json = File.read('test/support/json/int2_lin2_str3.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3HSome text... more text..."             \
          "\e[4;3HSome text... more text..."             \
          "\e[6;6H                              \e[6;6H" \
          "\e[7;6H                              \e[7;6H" \
          "\e[8;6H                              \e[8;6H" \
          "\e[6;6HSome text... more text..."             \
          "\e[7;6HSome text... more text..."
        )
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, multiple streams, streams contain styles' do
        Persistence.create({ name: 'int2_lin2_str3_styles_1', y: 3, x: 3, width: 30, height: 3 })
        Persistence.create({ name: 'int2_lin2_str3_styles_2', y: 6, x: 6, width: 30, height: 3 })
        json = File.read('test/support/json/int2_lin2_str3_styles.json')
        attributes = JSON.load(json, nil, symbolize_names: true)

        Composition.new(attributes).to_s.must_equal(
          "\e[3;3H                              \e[3;3H\e[4;3H                              \e[4;3H\e[5;3H                              \e[5;3H\e[3;3H\e[38;5;16m\e[48;5;21mSome text...\e[38;5;226m\e[48;5;46m \e[38;5;231m\e[48;5;201mmore text...\e[4;3H\e[38;5;16m\e[48;5;21mSome text...\e[38;5;226m\e[48;5;46m \e[38;5;231m\e[48;5;201mmore text...\e[6;6H                              \e[6;6H\e[7;6H                              \e[7;6H\e[8;6H                              \e[8;6H\e[6;6H\e[38;5;16m\e[48;5;21mSome text...\e[38;5;226m\e[48;5;46m \e[38;5;231m\e[48;5;201mmore text...\e[7;6H\e[38;5;16m\e[48;5;21mSome text...\e[38;5;226m\e[48;5;46m \e[38;5;231m\e[48;5;201mmore text..."
        )
      end
    end
  end
end
