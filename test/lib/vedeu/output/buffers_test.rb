require 'test_helper'

module Vedeu
  describe Buffers do
    describe '.create' do
      it 'creates an entry for the interface, and saves :clear' do
      end
    end

    describe '.enqueue' do
      it 'saves the new sequence for the interface into :next' do
      end
    end

    describe '.refresh' do
      it 'raises an exception if the interface cannot be found by name' do
      end

    # describe '#refresh' do
    #   let(:attributes) {
    #     {
    #       name:   '#refresh',
    #       lines:  [],
    #       colour: {
    #         foreground: '#ff0000',
    #         background: '#000000'
    #       },
    #       geometry: {
    #         width:  3,
    #         height: 3
    #       }
    #     }
    #   }

    #   it 'returns a blank interface when there is no content to display (initial state)' do
    #     Terminal.stub(:output, nil) do
    #       Interface.new(attributes).refresh.must_equal(
    #         "\e[38;5;196m\e[48;5;16m" \
    #         "\e[1;1H   \e[1;1H" \
    #         "\e[2;1H   \e[2;1H" \
    #         "\e[3;1H   \e[3;1H"
    #       )
    #     end
    #   end

    #   it 'returns the fresh content when content is queued up to be displayed' do
    #     attributes = {
    #       name:   '#refresh',
    #       lines:  [
    #         { streams: [{ text: '#refresh' }] },
    #         { streams: [{ text: '#refresh' }] },
    #         { streams: [{ text: '#refresh' }] }
    #       ],
    #       colour: {
    #         foreground: '#ff0000',
    #         background: '#000000'
    #       },
    #       geometry: {
    #         width:  11,
    #         height: 3
    #       }
    #     }
    #     interface = Interface.new(attributes)
    #     diode = interface.enqueue

    #     Terminal.stub(:output, nil) do
    #       interface.refresh.must_equal(
    #         "\e[38;5;196m\e[48;5;16m" \
    #         "\e[1;1H           \e[1;1H" \
    #         "\e[2;1H           \e[2;1H" \
    #         "\e[3;1H           \e[3;1H" \
    #         "\e[1;1H#refresh" \
    #         "\e[2;1H#refresh" \
    #         "\e[3;1H#refresh"
    #       )
    #     end
    #   end

    #   it 'returns the previously shown content when there is stale content from last run' do
    #     attributes = {
    #       name:   '#refresh',
    #       lines:  [],
    #       colour: {
    #         foreground: '#ff0000',
    #         background: '#000000'
    #       },
    #       geometry: {
    #         width:  11,
    #         height: 3
    #       }
    #     }
    #     interface = Interface.new(attributes)
    #     interface.current = "\e[38;5;196m\e[48;5;16m" \
    #                         "\e[1;1H           \e[1;1H" \
    #                         "\e[2;1H           \e[2;1H" \
    #                         "\e[3;1H           \e[3;1H" \
    #                         "\e[1;1H#refresh" \
    #                         "\e[2;1H#refresh" \
    #                         "\e[3;1H#refresh"

    #     Terminal.stub(:output, nil) do
    #       interface.refresh.must_equal(
    #         "\e[38;5;196m\e[48;5;16m" \
    #         "\e[1;1H           \e[1;1H" \
    #         "\e[2;1H           \e[2;1H" \
    #         "\e[3;1H           \e[3;1H" \
    #         "\e[1;1H#refresh" \
    #         "\e[2;1H#refresh" \
    #         "\e[3;1H#refresh"
    #       )
    #     end
    #   end
    # end
    end

    describe '.refresh_all' do
      it 'requests each stored interface to be refreshed' do
      end
    end

    describe '.reset' do
      it 'destroys all saved buffers' do
      end
    end
  end
end
