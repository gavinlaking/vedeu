require 'test_helper'

module Vedeu

  describe Viewport do

    let(:interface) {
      Interface.new({
        name:     'fluorine',
        geometry: {
          width:  30,
          height: 2,
        },
        lines: [
          {
            streams: [{
              text: 'Something interesting ',
            },{
              text: 'on this line ',
            },{
              text: 'would be cool, eh?'
            }]
          }, {
            streams: [{
              text: 'Maybe a lyric, a little ditty ',
            },{
              text: 'to help you unwind.',
            }]
          }
        ]
      })
    }

    describe '#initialize' do
      it 'returns an instance of itself' do
        Viewport.new(interface).must_be_instance_of(Viewport)
      end
    end

    describe '.show' do
      it 'returns an Array' do
        Viewport.show(interface).must_be_instance_of(Array)
      end

      context 'when there is no content' do
        before { interface.stubs(:content).returns([]) }

        it 'returns an empty collection' do
          Viewport.show(interface).must_equal([])
        end
      end

      context 'when there is content, it returns only the visible content '  \
              'determined by the geometry of the interface and the current ' \
              'offset stored' do
        it 'returns a collection of lines, each a collection of characters' do
          Viewport.show(interface).must_equal(
            [
              ['S', 'o', 'm', 'e', 't', 'h', 'i', 'n', 'g', ' ', 'i', 'n', 't', 'e', 'r', 'e', 's', 't', 'i', 'n', 'g', ' ', 'o', 'n', ' ', 't', 'h', 'i', 's', ' '],
              ['M', 'a', 'y', 'b', 'e', ' ', 'a', ' ', 'l', 'y', 'r', 'i', 'c', ',', ' ', 'a', ' ', 'l', 'i', 't', 't', 'l', 'e', ' ', 'd', 'i', 't', 't', 'y', ' ']
            ]
          )
        end
      end
    end

  end # Viewport

end # Vedeu
