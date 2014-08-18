require 'test_helper'

module Vedeu
  describe Buffer do
    describe '#initialize' do
      it 'returns a Buffer instance when all the vars are set' do
        vars = { name: 'interface', clear: '', current: '', group: '', next: '' }
        Buffer.new(vars).must_be_instance_of(Buffer)
      end

      it 'raises an exception if a var is not set' do
        vars = {}
        proc { Buffer.new(vars) }.must_raise(KeyError)
      end
    end

    describe '#enqueue' do

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
end
