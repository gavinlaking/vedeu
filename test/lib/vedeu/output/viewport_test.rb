require 'test_helper'

module Vedeu

  describe Viewport do

    let(:described) { Vedeu::Viewport }
    let(:instance)  { described.new(interface) }
    let(:interface) {
      Vedeu.interface 'lithium' do
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
      end
    }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Viewport) }
      it { subject.instance_variable_get('@interface').must_equal(interface) }
    end

    describe '.show' do
      subject { described.show(interface) }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#show' do
      let(:cursor) { Cursor.new(cursor_attributes) }
      let(:cursor_attributes) {
        { name: 'lithium', ox: ox, oy: oy, state: true, x: x, y: y }
      }
      let(:lines)  { [] }
      let(:ox)     { 0 }
      let(:oy)     { 0 }
      let(:x)      { 1 }
      let(:y)      { 1 }

      before do
        interface.stubs(:cursor).returns(cursor)
      end

      subject { instance.show }

      it { subject.must_be_instance_of(Array) }

      # context 'when there is no content' do
      #   before { interface.stubs(:lines).returns([]) }

      #   it { subject.must_equal([]) }
      # end

      context 'when there is content' do
        context "when the cursor's y position is outside the viewable area - negative" do
          let(:ox) { -4 }
          let(:oy) { -4 }

          it "scrolls the content the correct position" do
            subject.must_equal(
              [
                ["b", "a", "r"],
                ["c", "a", "r"],
                ["h", "e", "l"]
              ]
            )
          end

          it { instance.to_s.must_equal("bar\ncar\nhel") }
        end

        context "when the cursor's y position is inside the viewable area" do
          context "when there is not enough content to fill the height" do
            let(:ox) { 3 }
            let(:oy) { 7 }

            it "is padded with spaces" do
              subject.must_equal(
                [
                  ["n", "i", "c"],
                  ["o", "s", "m"],
                  [" ", " ", " "]
                ]
              )
            end

            it { instance.to_s.must_equal("nic\nosm\n   ") }
          end

          context "when there is more content than the height" do
            let(:ox) { 3 }
            let(:oy) { 3 }

            it "is cropped to show only that which fits" do
              subject.must_equal(
                [
                  ["b", "a", "r"],
                  ["c", "a", "r"],
                  ["h", "e", "l"]
                ]
              )
            end

            it { instance.to_s.must_equal("bar\ncar\nhel") }
          end
        end

        context "when the cursor's x position is outside the viewable area" do
          context "but inside the content" do
            let(:ox) { 6 }
            let(:oy) { 6 }

            it "scrolls the content the correct position" do
              subject.must_equal(
                [
                  ["i", "n", "e"],
                  ["k", "e", "l"],
                  ["i", "u", "m"]
                ]
              )
            end

            it { instance.to_s.must_equal("ine\nkel\nium") }
          end

          context "and outside the content" do
            let(:ox) { 7 }
            let(:oy) { 7 }

            it "scrolls the content the correct position" do
              subject.must_equal(
                [
                  ["e", "l", " "],
                  ["u", "m", " "],
                  [" ", " ", " "]
                ]
              )
            end

            it { instance.to_s.must_equal("el \num \n   ") }
          end
        end

        context "when the cursor's x position is inside the viewable area" do
          context "when there is not enough content to fill the width" do
            let(:ox) { 7 }
            let(:oy) { 3 }

            it "is padded with spaces" do
              subject.must_equal(
                [
                  ["u", "m", " "],
                  ["o", "n", " "],
                  ["u", "m", " "]
                ]
              )
            end

            it { instance.to_s.must_equal("um \non \num ") }
          end

          context "when there is more content than the width" do
            let(:ox) { 3 }
            let(:oy) { 3 }

            it "is cropped to show only that which fits" do
              subject.must_equal(
                [
                  ["b", "a", "r"],
                  ["c", "a", "r"],
                  ["h", "e", "l"]
                ]
              )
            end

            it { instance.to_s.must_equal("bar\ncar\nhel") }
          end
        end
      end
    end

  end # Viewport

end # Vedeu
