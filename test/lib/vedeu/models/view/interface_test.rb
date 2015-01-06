require 'test_helper'

module Vedeu

  describe Interface do

    let(:described)  { Interface.new(attributes) }
    let(:attributes) { {} }

    # let(:attributes) {
    #   {
    #     colour: {
    #       background: '#000000',
    #       foreground: '#ff0000',
    #     },
    #     group: 'my_group',
    #     name: 'francium',
    #     geometry: {
    #       x: 5,
    #       y: 3,
    #       width: 10,
    #       height: 15,
    #     }
    #   }
    # }

    # # before do
    # #   Interfaces.reset
    # #   Vedeu.interface('#initialize') do
    # #     group 'my_group'
    # #     colour foreground: '#ff0000', background: '#000000'
    # #     geometry do
    # #       y 3
    # #       x 5
    # #       width 10
    # #       height 15
    # #     end
    # #   end
    # # end

    # describe '#initialize' do
    #   it { return_type_for(described, Interface) }
    #   it { assigns(described, '@attributes', {
    #       border:   {},
    #       colour:   {
    #         background: '#000000',
    #         foreground: '#ff0000',
    #       },
    #       delay:    0.0,
    #       geometry: {
    #         x:      5,
    #         y:      3,
    #         width:  10,
    #         height: 15,
    #       },
    #       group:    'my_group',
    #       lines:    [],
    #       name:     'francium',
    #       parent:   nil,
    #       style:    ''
    #     })
    #   }
    #   it { assigns(described, '@delay', 0.0) }
    #   it { assigns(described, '@group', 'my_group') }
    #   it { assigns(described, '@name', 'francium') }
    #   it { assigns(described, '@parent', nil) }

    #   context 'with default attributes' do
    #     let(:attributes) { {} }

    #     it { assigns(described, '@attributes', {
    #         border:   {},
    #         colour:   {},
    #         delay:    0.0,
    #         geometry: {},
    #         group:    '',
    #         lines:    [],
    #         name:     '',
    #         parent:   nil,
    #         style:    ''
    #       })
    #     }
    #   end
    # end

    # describe '#attributes' do
    #   it 'returns the value' do
    #     described.attributes.must_equal(
    #       {
    #         border:     {},
    #         colour:     {
    #           foreground: '#ff0000',
    #           background: '#000000'
    #         },
    #         delay:      0.0,
    #         geometry:   {
    #           y:          3,
    #           x:          5,
    #           width:      10,
    #           height:     15,
    #         },
    #         group:      'my_group',
    #         lines:      [],
    #         name:       'francium',
    #         parent:     nil,
    #         style:      '',
    #       }
    #     )
    #   end
    # end

    describe '#border' do
      it { return_type_for(described.border, Border) }
    end

    describe '#delay' do
      it { return_type_for(described.delay, Float) }

      context 'when the delay is set' do
        let(:attributes) { { delay: 0.5 } }

        it { return_value_for(described.delay, 0.5) }
      end

      context 'when the delay is not set' do
        it { return_value_for(described.delay, 0.0) }
      end
    end

    describe '#deputy' do
      it { return_type_for(described.deputy, DSL::Interface) }
    end

    describe '#geometry' do
      it { return_type_for(described.geometry, Geometry) }
    end

    describe '#group' do
      it { return_type_for(described.group, String) }

      context 'when the group is set' do
        let(:attributes) { { group: 'elements' } }

        it { return_value_for(described.group, 'elements') }
      end

      context 'when the group is not set' do
        it { return_value_for(described.group, '') }
      end
    end

    describe '#lines' do
      it { return_type_for(described.lines, Vedeu::Model::Lines) }
    end

    describe '#name' do
      it { return_type_for(described.name, String) }

      context 'when the name is set' do
        let(:attributes) { { name: 'francium' } }

        it { return_value_for(described.name, 'francium') }
      end

      context 'when the name is not set' do
        it { return_value_for(described.name, '') }
      end
    end

    describe '#parent' do
      it { skip }
    end

  end # Interface

end # Vedeu
