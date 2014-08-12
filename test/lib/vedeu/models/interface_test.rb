require 'test_helper'

module Vedeu
  describe Interface do
    let(:interface) {
      Interface.new({
        name:  '#initialize',
        group: 'my_group',
        lines: [],
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        geometry: {
          y: 3,
          x: 5,
          width: 10,
          height: 15,
        },
        current: "\e[1;1H#initialize"
      })
    }

    it 'has a name attribute' do
      interface.name.must_equal('#initialize')
    end

    it 'has a name attribute' do
      interface.group.must_equal('my_group')
    end

    it 'has a lines attribute' do
      interface.lines.must_equal([])
    end

    it 'has a colour attribute' do
      interface.colour.must_be_instance_of(Colour)
    end

    it 'has a style attribute' do
      interface.style.must_equal('')
    end

    it 'has a geometry attribute' do
      interface.geometry.must_be_instance_of(Geometry)
    end

    it 'has a cursor attribute' do
      interface.cursor.must_equal(true)
      Interface.new({ cursor: false }).cursor.must_equal(false)
    end

    it 'has a delay attribute' do
      interface.delay.must_equal(0.0)
    end

    describe '#to_s' do
      it 'returns an string' do
        Interface.new({
          name:   '#to_s',
          lines:  [],
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          geometry: {
            width:  9,
            height: 3
          }
        }).to_s.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[1;1H         \e[1;1H" \
          "\e[2;1H         \e[2;1H" \
          "\e[3;1H         \e[3;1H"
        )
      end
    end
  end
end
