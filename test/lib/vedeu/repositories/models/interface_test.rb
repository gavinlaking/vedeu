require 'test_helper'

module Vedeu

  describe Interface do
    let(:described)  { Interface.new(attributes) }
    let(:attributes) { {} }

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
      it { return_type_for(described, Interface) }
      it { assigns(described, '@attributes', {
          border:   {},
          colour:   {},
          cursor:   :hide,
          delay:    0.0,
          geometry: {},
          group:    '',
          lines:    [],
          name:     '',
          parent:   nil,
          style:    ''
        })
      }
      it { assigns(described, '@cursor', :hide) }
      it { assigns(described, '@delay', 0.0) }
      it { assigns(described, '@group', '') }
      it { assigns(described, '@name', '') }
      it { assigns(described, '@parent', nil) }
    end

    describe '#attributes' do
      it 'returns the value' do
        interface.attributes.must_equal(
          {
            border: {},
            colour: {
              foreground: '#ff0000',
              background: '#000000'
            },
            cursor: :hide,
            delay: 0.0,
            geometry: {
              y: 3,
              x: 5,
              width: 10,
              height: 15,
            },
            group: 'my_group',
            lines: [],
            name: '#initialize',
            parent: nil,
            style: '',
          }
        )
      end
    end

    describe '#border' do
      it { return_type_for(described.border, Border) }
    end

    describe '#cursor' do
      it { return_type_for(described.cursor, Cursor) }
    end

    describe '#deputy' do
      it { return_type_for(described.deputy, DSL::Interface) }
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
      it { return_type_for(described.geometry, Geometry) }
    end

    describe '#delay' do
      it 'returns the value' do
        interface.delay.must_equal(0.0)
      end
    end

  end # Interface

end # Vedeu
