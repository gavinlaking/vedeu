require 'test_helper'

module Vedeu

  describe Output do

    let(:described) { Output.new(interface) }
    let(:interface) {
      Interface.new({
        name:   'flourine',
        geometry: {
          width:  32,
          height: 3,
        },
        lines:    lines,
        colour:   colour
      })
    }
    let(:lines) {
      [
        {
          streams: [{ text: 'this is the first' }]
        },
        {
          streams: [{ text: 'this is the second and it is long' }]
        },
        {
          streams: [{ text: 'this is the third, it is even longer and still truncated' }]
        },
        {
          streams: [{ text: 'this should not render' }]
        }
      ]
    }
    let(:colour) { {} }

    # before do
    #   Buffers.reset
    #   Cursors.reset
    #   Interfaces.reset

    #   Terminal.console.stubs(:winsize).returns([5, 40])
    #   Terminal.console.stubs(:print)
    # end

    describe '#initialize' do
      it { return_type_for(described, Output) }
      it { assigns(described, '@interface', interface) }
    end

    # describe '.render' do
    #   it 'returns the content for the interface' do
    #     Output.render(interface).must_equal(
    #       "\e[1;1H                                \e[1;1H" \
    #       "\e[2;1H                                \e[2;1H" \
    #       "\e[3;1H                                \e[3;1H" \
    #       "\e[1;1Hthis is the first" \
    #       "\e[2;1Hthis is the second and it is lon" \
    #       "\e[3;1Hthis is the third, it is even lo"
    #     )
    #   end

    #   context 'when there are no streams of text' do
    #     let(:lines) { [] }

    #     it 'returns a blank interface' do
    #       Output.render(interface).must_equal(
    #         "\e[1;1H                                \e[1;1H" \
    #         "\e[2;1H                                \e[2;1H" \
    #         "\e[3;1H                                \e[3;1H"
    #       )
    #     end
    #   end

    #   context 'when lines have streams which are empty' do
    #     let(:lines) {
    #       [
    #         {
    #           streams: [{ text: 'this is the first' }]
    #         }, {
    #           streams: { text: '' }
    #         }, {
    #           streams: [
    #             { text: 'this is the third, ' },
    #             { text: 'it is even longer '  },
    #             { text: 'and still truncated' }
    #           ]
    #         }, {
    #           streams: [{ text: 'this should not render' }]
    #         }
    #       ]
    #     }

    #     it 'skips lines' do
    #       Output.render(interface).must_equal(
    #         "\e[1;1H                                \e[1;1H" \
    #         "\e[2;1H                                \e[2;1H" \
    #         "\e[3;1H                                \e[3;1H" \
    #         "\e[1;1Hthis is the first" \
    #         "\e[2;1H" \
    #         "\e[3;1Hthis is the third, it is even lo"
    #       )
    #     end
    #   end
    # end

  end # Output

end # Vedeu
