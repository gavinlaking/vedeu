require 'test_helper'

module Vedeu

  describe Viewport do

    let(:described) { Vedeu::Viewport }
    let(:instance)  { described.new(interface, cursor) }
    let(:interface) {
      # Interface.new({
      #   name:     'lithium',
      #   geometry: {
      #     width:  3,
      #     height: 3,
      #   },
      #   lines: lines
      # })
      Vedeu::Interface.build do
        geometry do
          height 3
          width 3
        end
        lines do
          line 'barium'
          line 'carbon'
          line 'helium'
          line 'iodine'
          line 'nickel'
          line 'osmium'
        end
        name 'lithium'
      end
    }
    let(:cursor) { Cursor.new('lithium', true, x, y) }
    let(:lines)  { [] }
    let(:x)      { 1 }
    let(:y)      { 1 }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Viewport) }
      it { subject.instance_variable_get('@interface').must_equal(interface) }
      it { subject.instance_variable_get('@cursor').must_equal(cursor) }
      it { subject.instance_variable_get('@top').must_equal(0) }
      it { subject.instance_variable_get('@left').must_equal(0) }
    end

    describe '.show' do
      subject { described.show(interface, cursor) }

      it { subject.must_be_instance_of(Array) }

      # context 'when there is no content' do
      #   before { interface.stubs(:lines).returns([]) }

      #   it { subject.must_equal([]) }
      # end

      context 'when there is content' do
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
