require 'test_helper'

module Vedeu

  describe Viewport do
    let(:interface) { Interface.new({ name: 'lucie' }) }
    let(:viewport)  { Viewport.new(interface) }

    describe '#initialize' do
      it 'returns an instance of itself' do
        viewport.must_be_instance_of(Viewport)
      end
    end

    describe '#visible_lines' do
    end


    # let(:interface) {
    #   Interface.new({
    #     name:     'titanium',
    #     geometry: {
    #       width:  40,
    #       height: 4,
    #     },
    #     lines: lines
    #   })
    # }
    # let(:lines) {
    #   [
    #     {
    #       streams: [{ text: 'Titanium is a chemical element.' }]
    #     }, {
    #       streams: { text: '' }
    #     }, {
    #       streams: [
    #         { text: 'It is a lustrous ' },
    #         { text: 'transition metal '  },
    #         { text: 'with a silver colour.' }
    #       ]
    #     }, {
    #       streams: { text: '' }
    #     }, {
    #       streams: [{ text: 'It has low density and high strength.' }]
    #     }
    #   ]
    # }

    # describe '#initialize' do
    #   it 'returns an instance of ContentArea' do
    #     ContentArea.new(interface).must_be_instance_of(ContentArea)
    #   end
    # end

    # describe '#geometry' do
    #   subject { ContentArea.new(interface).geometry }

    #   it 'returns an instance of Area' do
    #     subject.must_be_instance_of(Area)
    #   end

    #   context 'when there is content' do
    #     it 'uses the number of lines as the height' do
    #       subject.y_max.must_equal(5)
    #     end

    #     it 'uses the width of the longest line as the width' do
    #       subject.x_max.must_equal(55)
    #     end

    #     context 'when there are less lines than the height of the interface' do
    #       let(:lines) { [{}, {}] }

    #       it 'uses the height of the interface' do
    #         subject.y_max.must_equal(4)
    #       end
    #     end

    #     context 'when the lines have no streams or the line length is less ' \
    #             'than the interface width' do
    #       let(:lines) {
    #         [
    #           { streams: [] }
    #         ]
    #       }

    #       it 'uses the width of the interface' do
    #         subject.x_max.must_equal(40)
    #       end
    #     end
    #   end

    #   context 'when there is no content' do
    #     let(:lines) { [] }

    #     it 'uses the height of the interface' do
    #       subject.y_max.must_equal(4)
    #     end

    #     it 'uses the width of the interface' do
    #       subject.x_max.must_equal(40)
    #     end
    #   end
    # end


    # describe '#y_max' do
    #   context '< 0' do
    #     it { viewport.y_max(-2).must_equal(0) }

    #     it { viewport.y_max(0).must_equal(0) }
    #   end

    #   context '> content y_max_index' do
    #     it { viewport.y_max(12).must_equal(9) }
    #   end

    #   context '(offset_y + view y_max_index) > content y_max_index' do
    #     it { viewport.y_max(8).must_equal(5) }
    #   end

    #   context '(offset_y + view y_max_index) < content y_max_index' do
    #     it { viewport.y_max(4).must_equal(4) }

    #     it { viewport.y_max(5).must_equal(5) }

    #     it { viewport.y_max(6).must_equal(5) }
    #   end
    # end

  end

  # describe Viewport do
  #   let(:instance) { Viewport.new(lines, y, x) }
  #   let(:lines) {
  #     [
  #       'Hafnium',
  #       'symbol ',
  #       'A lustr',
  #       'transit',
  #       'resembl',
  #     ]
  #   }
  #   let(:y) { 0 }
  #   let(:x) { 0 }

  #   describe '#initialize' do
  #     it 'returns an instance of itself' do
  #       instance.must_be_instance_of(Viewport)
  #     end
  #   end

  #   describe '#visible_lines' do
  #     let(:lines) {
  #       [
  #         'Hafnium',
  #         'symbol ',
  #         'A lustr',
  #         'transit',
  #         'resembl',
  #       ]
  #     }
  #     let(:view) { Viewport.new(lines, y, x) }
  #     let(:x) { 0 }
  #     let(:y) { 0 }

  #     context 'initially' do
  #       it '' do
  #         view.visible_lines.must_equal(["Hafnium", "symbol "])
  #       end
  #     end

  #     context 'down' do
  #       it '' do
  #         view.down
  #         view.visible_lines.must_equal(["symbol ", "A lustr"])
  #         view.y.must_equal(1)
  #       end

  #       it '' do
  #         view.down
  #         view.down
  #         view.down
  #         view.down
  #         view.visible_lines.must_equal(["resembl"])
  #         view.y.must_equal(4)
  #       end
  #     end

  #     context 'up' do
  #       it '' do
  #         view.up
  #         view.visible_lines.must_equal(["Hafnium", "symbol "])
  #         view.y.must_equal(0)
  #       end

  #       it '' do
  #         view.down
  #         view.down
  #         view.up
  #         view.visible_lines.must_equal(["symbol ", "A lustr"])
  #         view.y.must_equal(1)
  #       end
  #     end
  #   end

  #   describe '#visible_columns' do
  #     let(:lines) {
  #       [
  #         'Hafnium',
  #         'symbol ',
  #         'A lustr',
  #         'transit',
  #         'resembl',
  #       ]
  #     }
  #     let(:view) { Viewport.new(lines, y, x) }
  #     let(:x) { 0 }
  #     let(:y) { 0 }

  #     context 'initially' do
  #       it '' do
  #         view.visible_columns.must_equal(["Hafni", "symbo"])
  #       end
  #     end

  #     context 'right' do
  #       it '' do
  #         view.right
  #         view.visible_columns.must_equal(["afniu", "ymbol"])
  #         view.x.must_equal(1)
  #       end

  #       it '' do
  #         view.right
  #         view.right
  #         view.right
  #         view.visible_columns.must_equal(["nium", "bol "])
  #         view.x.must_equal(3)
  #       end
  #     end

  #     context 'left' do
  #       it '' do
  #         view.left
  #         view.visible_columns.must_equal(["Hafni", "symbo"])
  #         view.x.must_equal(0)
  #       end

  #       it '' do
  #         view.right
  #         view.right
  #         view.left
  #         view.visible_columns.must_equal(["afniu", "ymbol"])
  #         view.x.must_equal(1)
  #       end
  #     end
  #   end

  # end

end
