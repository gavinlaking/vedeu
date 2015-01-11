require 'test_helper'

module Vedeu

  describe Viewport do

    let(:described) { Vedeu::Viewport }
    let(:instance)  { described.new(interface) }
    let(:interface) {
      Interface.new({
        name:     'lithium',
        geometry: {
          width:  3,
          height: 3,
        },
        lines: lines
      })
      # Vedeu::Interface.build do
      #   geometry do
      #     width 3
      #     height 3
      #   end
      #   name 'lithium'
      #   lines do
      #     line 'Beryllium'
      #     line 'Magnesium'
      #     line 'Plutonium'
      #     line 'Potassium'
      #     line 'Lanthanum'
      #     line 'Stront­ium'
      #   end
      # end
    }
    let(:lines) { [] }
    let(:x)     { 1 }
    let(:y)     { 1 }

    before do
      interface.geometry = Vedeu::Geometry.build do
        height 3
        width  3
      end
      Cursor.new('lithium', true, x, y).store
    end

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Viewport) }
      it { assigns(subject, '@interface', interface) }
      it { assigns(subject, '@top', 0) }
      it { assigns(subject, '@left', 0) }
    end

    describe '.show' do
      subject { described.show(interface) }

      it { return_type_for(subject, Array) }

      context 'when there is no content' do
        it { return_value_for(subject, []) }
      end

      context 'when there is content' do
        let(:lines) {
          [
            Line.new([Stream.new("barium")]),
            Line.new([Stream.new("carbon")]),
            Line.new([Stream.new("helium")]),
            Line.new([Stream.new("iodine")]),
            Line.new([Stream.new("nickel")]),
            Line.new([Stream.new("osmium")])
          ]
        }

        context "when the cursor's y position is outside the viewable area - negative" do
          let(:x) { -4 }
          let(:y) { -4 }

          it "scrolls the content the correct position" do
            subject.must_equal(
              [
                ["b", "a", "r"],
                ["c", "a", "r"],
                ["h", "e", "l"]
              ]
            )
          end
        end

        context "when the cursor's y position is inside the viewable area" do
          context "when there is not enough content to fill the height" do
            let(:x) { 3 }
            let(:y) { 7 }

            it "is padded with spaces" do
              subject.must_equal(
                [
                  ["s", "m", "i"],
                  [" ", " ", " "],
                  [" ", " ", " "]
                ]
              )
            end
          end

          context "when there is more content than the height" do
            let(:x) { 3 }
            let(:y) { 3 }

            it "is cropped to show only that which fits" do
              subject.must_equal(
                [
                  ["a", "r", "b"],
                  ["e", "l", "i"],
                  ["o", "d", "i"]
                ]
              )
            end
          end
        end

        context "when the cursor's x position is outside the viewable area" do
          context "but inside the content" do
            let(:x) { 6 }
            let(:y) { 6 }

            it "scrolls the content the correct position" do
              subject.must_equal(
                [
                  ["e", "l", " "],
                  ["u", "m", " "],
                  [" ", " ", " "]
                ]
              )
            end
          end

          context "and outside the content" do
            let(:x) { 7 }
            let(:y) { 7 }

            it "scrolls the content the correct position" do
              subject.must_equal(
                [
                  ["m", " ", " "],
                  [" ", " ", " "],
                  [" ", " ", " "]
                ]
              )
            end
          end
        end

        context "when the cursor's x position is inside the viewable area" do
          context "when there is not enough content to fill the width" do
            let(:x) { 7 }
            let(:y) { 3 }

            it "is padded with spaces" do
              subject.must_equal(
                [
                  ["n", " ", " "],
                  ["m", " ", " "],
                  ["e", " ", " "]
                ]
              )
            end
          end

          context "when there is more content than the width" do
            let(:x) { 3 }
            let(:y) { 3 }

            it "is cropped to show only that which fits" do
              subject.must_equal(
                [
                  ["a", "r", "b"],
                  ["e", "l", "i"],
                  ["o", "d", "i"]
                ]
              )
            end
          end
        end
      end
    end

  end # Viewport

end # Vedeu
