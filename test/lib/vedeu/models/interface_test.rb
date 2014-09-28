require 'test_helper'

module Vedeu
  describe Interface do
    let(:interface) { Vedeu.use('#initialize') }

    before do
      Interfaces.reset
      Vedeu.interface('#initialize') do
        group 'my_group'
        colour foreground: '#ff0000', background: '#000000'
        y 3
        x 5
        width 10
        height 15
      end
    end

    describe '#initialize' do
      it 'returns an instance of itself' do
        interface.must_be_instance_of(Interface)
      end
    end

    describe '#attributes' do
      it 'returns the value' do
        interface.attributes.must_equal(
          {
            name: '#initialize',
            group: 'my_group',
            lines: [],
            colour: {
              foreground: '#ff0000',
              background: '#000000'
            },
            style: '',
            geometry: {
              y: 3,
              x: 5,
              width: 10,
              height: 15
            },
            delay: 0.0,
            parent: nil
          }
        )
      end
    end

    describe '#name' do
      it 'returns the value' do
        interface.name.must_equal('#initialize')
      end
    end

    describe '#in_focus?' do
      context 'when the interface is currently in focus' do
        before { Focus.stubs(:current?).returns(true) }

        it { interface.in_focus?.must_equal(true) }
      end

      context 'when the interface is not currently in focus' do
        before { Focus.stubs(:current?).returns(false) }

        it { interface.in_focus?.must_equal(false) }
      end
    end

    describe '#group' do
      it 'returns the value' do
        interface.group.must_equal('my_group')
      end
    end

    describe '#lines' do
      it 'returns the value' do
        interface.lines.must_equal([])
      end
    end

    describe '#geometry' do
      it 'returns the value' do
        interface.geometry.must_be_instance_of(Geometry)
      end
    end

    describe '#delay' do
      it 'returns the value' do
        interface.delay.must_equal(0.0)
      end
    end

    describe '#cursor' do
      it 'returns the associated cursor for this interface' do
        interface.cursor.must_be_instance_of(Cursor)
      end
    end

  end
end
