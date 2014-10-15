# require 'test_helper'

# module Vedeu
#   describe Window do
#     let(:window) { Window.new(10, 10) }

    # describe '#crop' do
    #   let(:window) {
    #     Window.new(2, 4, {
    #       line_scroll_threshold:   0,
    #       line_scroll_offset:      1,
    #       column_scroll_threshold: 0,
    #       column_scroll_offset:    1
    #     })
    #   }

    #   it "does not modify given lines" do
    #     original = ['1234','1234']
    #     window.crop(original)
    #     original.must_equal ['1234','1234']
    #   end

    #   it "removes un-displayable chars" do
    #     result = window.crop(['12345','12345','12345'])
    #     result.must_equal ['1234','1234']
    #   end

    #   it "does not add whitespace" do
    #     result = window.crop(['1','',''])
    #     result.must_equal ['1','']
    #   end

    #   it "creates lines if necessary" do
    #     result = window.crop(['1234'])
    #     result.must_equal ['1234','']
    #   end

    #   it "stays inside frame as long as position is in frame" do
    #     window.set_position(WindowPosition.new(1,3))
    #     result = window.crop(['12345678','12345678'])
    #     result.must_equal ['1234','1234']
    #   end

    #   it "can display empty lines" do
    #     window.crop([]).must_equal ['','']
    #   end

    #   describe 'scrolled' do
    #     it "goes out of frame if line is out of frame" do
    #       window = Window.new(6,1, :line_scroll_offset => 0, :line_scroll_threshold => 0)
    #       window.set_position(WindowPosition.new(6,0))
    #       result = window.crop(['1','2','3','4','5','6','7','8','9'])
    #       result.must_equal ['2','3','4','5','6','7']
    #     end

    #     it "goes out of frame if column is out of frame" do
    #       window = Window.new(1,6, :column_scroll_offset => 0, :column_scroll_threshold => 0)
    #       window.set_position(WindowPosition.new(0,6))
    #       result = window.crop(['1234567890'])
    #       result.must_equal ['234567']
    #     end
    #   end
    # end

    # describe '#top' do
    #   let(:window){ Window.new(10,10, :line_scroll_threshold => 1, :line_scroll_offset => 3) }

    #   it "does not change when staying in frame" do
    #     window.top.must_equal 0
    #     window.set_position(WindowPosition.new(8,0))
    #     window.top.must_equal 0
    #   end

    #   it "changes by offset when going down out of frame" do
    #     window.set_position(WindowPosition.new(9,0))
    #     window.top.must_equal 3
    #   end

    #   it "stays at bottom when going down out of frame" do
    #     window.set_position(WindowPosition.new(20,0))
    #     window.top.must_equal 20 - 10 + 3 + 1
    #   end

    #   it "stays at top when going up out of frame" do
    #     window.set_position(WindowPosition.new(20,0))
    #     window.set_position(WindowPosition.new(7,0))
    #     window.top.must_equal 7 - 3
    #   end

    #   it "changes to 0 when going up to 1" do
    #     window.set_position(WindowPosition.new(20,0))
    #     window.set_position(WindowPosition.new(1,0))
    #     window.top.must_equal 0
    #   end

    #   it "does not change when staying in changed frame" do
    #     window.set_position(WindowPosition.new(9,0))
    #     window.top.must_equal 3
    #     window.set_position(WindowPosition.new(11,0))
    #     window.top.must_equal 3
    #   end
    # end

    # describe '#left' do
    #   let(:window){ Window.new(10,10, :column_scroll_threshold => 1, :column_scroll_offset => 3) }

    #   it "does not change when staying in frame" do
    #     window.left.must_equal 0
    #     window.set_position(WindowPosition.new(0,8))
    #     window.left.must_equal 0
    #   end

    #   it "changes by offset when going vertically out of frame" do
    #     window.set_position(WindowPosition.new(0,8))
    #     window.set_position(WindowPosition.new(0,9))
    #     window.left.must_equal 3
    #   end

    #   it "stays right when going right out of frame" do
    #     window.set_position(WindowPosition.new(0,20))
    #     window.left.must_equal 20 - 10 + 3 + 1
    #   end

    #   it "stays left when going left out of frame" do
    #     window.set_position(WindowPosition.new(0,20))
    #     window.set_position(WindowPosition.new(0,7))
    #     window.left.must_equal 7 - 3
    #   end

    #   it "changes to 0 when going left out of frame to 1" do
    #     window.set_position(WindowPosition.new(0,20))
    #     window.set_position(WindowPosition.new(0,1))
    #     window.left.must_equal 0
    #   end

    #   it "does not change when staying in changed frame" do
    #     window.set_position(WindowPosition.new(0,8))
    #     window.set_position(WindowPosition.new(0,9))
    #     window.left.must_equal 3
    #     window.set_position(WindowPosition.new(0,11))
    #     window.left.must_equal 3
    #   end
    # end

#   end
# end

# require 'test_helper'

# module Vedeu

#   describe Viewport do
#     let(:interface) { Interface.new({ name: 'lucie' }) }
#     let(:viewport)  { Viewport.new(interface) }

#     describe '#initialize' do
#       it 'returns an instance of itself' do
#         viewport.must_be_instance_of(Viewport)
#       end
#     end

#     describe '#visible_lines' do
#     end


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

  # end

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

# end
