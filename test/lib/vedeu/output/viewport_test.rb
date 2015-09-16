require 'test_helper'

module Vedeu

  describe Viewport do

    let(:described)  { Vedeu::Viewport }
    let(:instance)   { described.new(view) }
    let(:view)       {
      Vedeu::Views::View.build(name: 'lithium', style: nil) do
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
    let(:visible)   { true }
    let(:interface) {
      Vedeu::Models::Interface.new(style: nil, visible: visible)
    }
    let(:geometry)  { Vedeu::Geometry::Geometry.new(height: 3, width: 3) }

    before do
      Vedeu.interfaces.stubs(:by_name).returns(interface)
      Vedeu.geometries.stubs(:by_name).returns(geometry)
    end
    after { Vedeu.interfaces.reset }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@view').must_equal(view) }
    end

    describe '.render' do
      subject { described.render(view) }

      context 'when the interface is visible' do
        # @todo Add more tests.
        # it { skip }
      end

      context 'when the interface is not visible' do
        let(:visible) { false }

        it { subject.must_be_instance_of(Array) }

        it { subject.must_equal([]) }
      end
    end

    describe '#render' do
      let(:cursor) {
        Vedeu::Cursors::Cursor.new(name:    'lithium',
                                   ox:      ox,
                                   oy:      oy,
                                   visible: true,
                                   x:       x,
                                   y:       y) }
      let(:lines)  { [] }
      let(:ox)     { 0 }
      let(:oy)     { 0 }
      let(:x)      { 1 }
      let(:y)      { 1 }

      subject { instance.render }

      it { subject.must_be_instance_of(Array) }

      context 'when there is no content' do
        before { view.stubs(:lines).returns([]) }

        it { subject.must_equal([]) }
      end
    end

    describe '#to_s' do
      let(:cursor) {
        Vedeu::Cursors::Cursor.new(name:    'lithium',
                                   ox:      ox,
                                   oy:      oy,
                                   visible: true,
                                   x:       x,
                                   y:       y) }
      let(:lines)  { [] }
      let(:ox)     { 0 }
      let(:oy)     { 0 }
      let(:x)      { 1 }
      let(:y)      { 1 }

      subject { instance.to_s }

      it { subject.must_be_instance_of(String) }

      context 'when there is no content' do
        before { view.stubs(:lines).returns([]) }

        it { subject.must_equal('') }
      end

      context 'when there is content' do
        context 'when the cursor y position is outside the viewable area' do
          let(:ox) { -4 }
          let(:oy) { -4 }

          it 'scrolls the content the correct position' do
            subject.must_equal(
              "\e[1;1H\e[39m\e[49mb\n" \
              "\e[1;2H\e[39m\e[49ma\n" \
              "\e[1;3H\e[39m\e[49mr\n" \
              "\e[2;1H\e[39m\e[49mc\n" \
              "\e[2;2H\e[39m\e[49ma\n" \
              "\e[2;3H\e[39m\e[49mr\n" \
              "\e[3;1H\e[39m\e[49mh\n" \
              "\e[3;2H\e[39m\e[49me\n" \
              "\e[3;3H\e[39m\e[49ml"
            )
          end
        end

        context 'when the cursor y position is inside the viewable area' do
          context 'when there is not enough content to fill the height' do
            let(:ox) { 3 }
            let(:oy) { 7 }

            it 'renders the visible content' do
              subject.must_equal(
                "\e[1;1H\e[39m\e[49mb\n" \
                "\e[1;2H\e[39m\e[49ma\n" \
                "\e[1;3H\e[39m\e[49mr\n" \
                "\e[2;1H\e[39m\e[49mc\n" \
                "\e[2;2H\e[39m\e[49ma\n" \
                "\e[2;3H\e[39m\e[49mr\n" \
                "\e[3;1H\e[39m\e[49mh\n" \
                "\e[3;2H\e[39m\e[49me\n" \
                "\e[3;3H\e[39m\e[49ml"
              )
            end
          end

          context 'when there is more content than the height' do
            let(:ox) { 3 }
            let(:oy) { 3 }

            it 'is cropped to show only that which fits' do
              subject.must_equal(
                "\e[1;1H\e[39m\e[49mb\n" \
                "\e[1;2H\e[39m\e[49ma\n" \
                "\e[1;3H\e[39m\e[49mr\n" \
                "\e[2;1H\e[39m\e[49mc\n" \
                "\e[2;2H\e[39m\e[49ma\n" \
                "\e[2;3H\e[39m\e[49mr\n" \
                "\e[3;1H\e[39m\e[49mh\n" \
                "\e[3;2H\e[39m\e[49me\n" \
                "\e[3;3H\e[39m\e[49ml"
              )
            end
          end
        end

        context 'when the cursor x position is outside the viewable area' do
          context 'but inside the content' do
            let(:ox) { 6 }
            let(:oy) { 6 }

            it 'scrolls the content the correct position' do
              subject.must_equal(
                "\e[1;1H\e[39m\e[49mb\n" \
                "\e[1;2H\e[39m\e[49ma\n" \
                "\e[1;3H\e[39m\e[49mr\n" \
                "\e[2;1H\e[39m\e[49mc\n" \
                "\e[2;2H\e[39m\e[49ma\n" \
                "\e[2;3H\e[39m\e[49mr\n" \
                "\e[3;1H\e[39m\e[49mh\n" \
                "\e[3;2H\e[39m\e[49me\n" \
                "\e[3;3H\e[39m\e[49ml"
              )
            end
          end

          context 'and outside the content' do
            let(:ox) { 7 }
            let(:oy) { 7 }

            it 'scrolls the content the correct position' do
              subject.must_equal(
                "\e[1;1H\e[39m\e[49mb\n" \
                "\e[1;2H\e[39m\e[49ma\n" \
                "\e[1;3H\e[39m\e[49mr\n" \
                "\e[2;1H\e[39m\e[49mc\n" \
                "\e[2;2H\e[39m\e[49ma\n" \
                "\e[2;3H\e[39m\e[49mr\n" \
                "\e[3;1H\e[39m\e[49mh\n" \
                "\e[3;2H\e[39m\e[49me\n" \
                "\e[3;3H\e[39m\e[49ml"
              )
            end
          end
        end

        context 'when the cursor x position is inside the viewable area' do
          context 'when there is not enough content to fill the width' do
            let(:ox) { 7 }
            let(:oy) { 3 }

            it 'renders the visible content' do
              subject.must_equal(
                "\e[1;1H\e[39m\e[49mb\n" \
                "\e[1;2H\e[39m\e[49ma\n" \
                "\e[1;3H\e[39m\e[49mr\n" \
                "\e[2;1H\e[39m\e[49mc\n" \
                "\e[2;2H\e[39m\e[49ma\n" \
                "\e[2;3H\e[39m\e[49mr\n" \
                "\e[3;1H\e[39m\e[49mh\n" \
                "\e[3;2H\e[39m\e[49me\n" \
                "\e[3;3H\e[39m\e[49ml"
              )
            end
          end

          context 'when there is more content than the width' do
            let(:ox) { 3 }
            let(:oy) { 3 }

            it 'is cropped to show only that which fits' do
              subject.must_equal(
                "\e[1;1H\e[39m\e[49mb\n" \
                "\e[1;2H\e[39m\e[49ma\n" \
                "\e[1;3H\e[39m\e[49mr\n" \
                "\e[2;1H\e[39m\e[49mc\n" \
                "\e[2;2H\e[39m\e[49ma\n" \
                "\e[2;3H\e[39m\e[49mr\n" \
                "\e[3;1H\e[39m\e[49mh\n" \
                "\e[3;2H\e[39m\e[49me\n" \
                "\e[3;3H\e[39m\e[49ml"
              )
            end
          end
        end
      end
    end

  end # Viewport

end # Vedeu
