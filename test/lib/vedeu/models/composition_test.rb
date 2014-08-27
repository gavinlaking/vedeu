require 'test_helper'

require 'json'

module Vedeu
  describe Composition do
    let(:json)       { File.read('test/support/model_test_data.json') }
    let(:attributes) { JSON.load(json, nil, symbolize_names: true) }

    before { Buffers.reset }

    describe '#interfaces' do
      it 'returns a collection of interfaces' do
        Vedeu.interface('dummy') do
          width  5
          height 5
        end
        Composition.new({
          interfaces: {
            name:  'dummy',
            lines: []
          }
        }).interfaces.first.must_be_instance_of(Interface)
      end

      it 'returns an empty collection when no interfaces are associated' do
        Composition.new.interfaces.must_be_empty
      end
    end

    describe '#to_s' do
      it 'returns the stringified content for a single interface, single line, single stream' do
        Vedeu.interface('int1_lin1_str1') do
          y      3
          x      3
          width  15
          height 3
        end

        Composition.new(attributes[:test_0001]).to_s.must_equal(
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text...\e[?25h"
        )
      end

      it 'returns the stringified content for a single interface, single line, multiple streams' do
        Vedeu.interface('int1_lin1_str3') do
          y      3
          x      3
          width  30
          height 3
        end

        Composition.new(attributes[:test_0002]).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3HSome text... more text...\e[?25h"
        )
      end

      it 'returns the stringified content for a single interface, multiple lines, single stream' do
        Vedeu.interface('int1_lin2_str1') do
          y      3
          x      3
          width  15
          height 3
        end

        Composition.new(attributes[:test_0003]).to_s.must_equal(
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text..." \
          "\e[4;3HSome text...\e[?25h"
        )
      end

      it 'returns the stringified content for a single interface, multiple lines, multiple streams' do
        Vedeu.interface('int1_lin2_str3') do
          y      3
          x      3
          width  30
          height 3
        end

        Composition.new(attributes[:test_0004]).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3HSome text... more text..." \
          "\e[4;3HSome text... more text...\e[?25h"
        )
      end

      it 'returns the stringified content for a single interface, multiple lines, multiple streams, streams contain styles' do
        Vedeu.interface('int1_lin2_str3_styles') do
          y      3
          x      3
          width  30
          height 3
        end

        Composition.new(attributes[:test_0005]).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3H\e[38;2;0;0;0m\e[48;2;0;0;255m\e[24m\e[22m\e[27m\e[4mSome text...\e[38;2;255;255;0m\e[48;2;0;255;0m\e[24m\e[22m\e[27m \e[38;2;255;255;255m\e[48;2;255;0;255m\e[1mmore text...\e[?25h"
        )
      end

      it 'returns the stringified content for multiple interfaces, single line, single stream' do
        Vedeu.interface('int2_lin1_str1_1') do
          y      3
          x      3
          width  15
          height 3
        end
        Vedeu.interface('int2_lin1_str1_2') do
          y      6
          x      6
          width  15
          height 3
        end

        Composition.new(attributes[:test_0006]).to_s.must_equal(
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text...\e[?25h"    \
          "\e[6;6H               \e[6;6H" \
          "\e[7;6H               \e[7;6H" \
          "\e[8;6H               \e[8;6H" \
          "\e[6;6HSome text...\e[?25h"
        )
      end

      it 'returns the stringified content for multiple interfaces, single line, multiple streams' do
        Vedeu.interface('int2_lin1_str3_1') do
          y      3
          x      3
          width  30
          height 3
        end
        Vedeu.interface('int2_lin1_str3_2') do
          y      6
          x      6
          width  30
          height 3
        end

        Composition.new(attributes[:test_0007]).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3HSome text... more text...\e[?25h"      \
          "\e[6;6H                              \e[6;6H" \
          "\e[7;6H                              \e[7;6H" \
          "\e[8;6H                              \e[8;6H" \
          "\e[6;6HSome text... more text...\e[?25h"
        )
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, single stream' do
        Vedeu.interface('int2_lin2_str1_1') do
          y      3
          x      3
          width  15
          height 3
        end
        Vedeu.interface('int2_lin2_str1_2') do
          y      6
          x      6
          width  15
          height 3
        end

        Composition.new(attributes[:test_0008]).to_s.must_equal(
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text..." \
          "\e[4;3HSome text...\e[?25h"    \
          "\e[3;3H               \e[3;3H" \
          "\e[4;3H               \e[4;3H" \
          "\e[5;3H               \e[5;3H" \
          "\e[3;3HSome text..." \
          "\e[4;3HSome text...\e[?25h"
        )
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, multiple streams' do
        Vedeu.interface('int2_lin2_str3_1') do
          y      3
          x      3
          width  30
          height 3
        end
        Vedeu.interface('int2_lin2_str3_2') do
          y      6
          x      6
          width  30
          height 3
        end

        Composition.new(attributes[:test_0009]).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3HSome text... more text..."             \
          "\e[4;3HSome text... more text...\e[?25h"      \
          "\e[6;6H                              \e[6;6H" \
          "\e[7;6H                              \e[7;6H" \
          "\e[8;6H                              \e[8;6H" \
          "\e[6;6HSome text... more text..."             \
          "\e[7;6HSome text... more text...\e[?25h"
        )
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, multiple streams, streams contain styles' do
        Vedeu.interface('int2_lin2_str3_styles_1') do
          y      3
          x      3
          width  30
          height 3
        end
        Vedeu.interface('int2_lin2_str3_styles_2') do
          y      6
          x      6
          width  30
          height 3
        end

        Composition.new(attributes[:test_0010]).to_s.must_equal(
          "\e[3;3H                              \e[3;3H" \
          "\e[4;3H                              \e[4;3H" \
          "\e[5;3H                              \e[5;3H" \
          "\e[3;3H\e[38;2;0;0;0m\e[48;2;0;0;255m\e[24m\e[22m\e[27m\e[4mSome text...\e[38;2;255;255;0m\e[48;2;0;255;0m\e[24m\e[22m\e[27m \e[38;2;255;255;255m\e[48;2;255;0;255m\e[1mmore text..." \
          "\e[4;3H\e[38;2;0;0;0m\e[48;2;0;0;255m\e[24m\e[22m\e[27m\e[4mSome text...\e[38;2;255;255;0m\e[48;2;0;255;0m\e[24m\e[22m\e[27m \e[38;2;255;255;255m\e[48;2;255;0;255m\e[1mmore text...\e[?25h" \
          "\e[6;6H                              \e[6;6H" \
          "\e[7;6H                              \e[7;6H" \
          "\e[8;6H                              \e[8;6H" \
          "\e[6;6H\e[38;2;0;0;0m\e[48;2;0;0;255m\e[24m\e[22m\e[27m\e[4mSome text...\e[38;2;255;255;0m\e[48;2;0;255;0m\e[24m\e[22m\e[27m \e[38;2;255;255;255m\e[48;2;255;0;255m\e[1mmore text..." \
          "\e[7;6H\e[38;2;0;0;0m\e[48;2;0;0;255m\e[24m\e[22m\e[27m\e[4mSome text...\e[38;2;255;255;0m\e[48;2;0;255;0m\e[24m\e[22m\e[27m \e[38;2;255;255;255m\e[48;2;255;0;255m\e[1mmore text...\e[?25h"
        )
      end
    end
  end
end
