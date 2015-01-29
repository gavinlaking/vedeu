require 'test_helper'

module Vedeu

  describe Interface do

    let(:described)  { Vedeu::Interface }
    let(:instance)   { described.new(attributes) }
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
    #   it { described.must_be_instance_of(Interface) }
    #   it { subject.instance_variable_get('@attributes').must_equal({
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
    #   it { described.instance_variable_get('@delay').must_equal(0.0) }
    #   it { described.instance_variable_get('@group').must_equal('my_group') }
    #   it { described.instance_variable_get('@name').must_equal('francium') }
    #   it { described.instance_variable_get('@parent').must_equal(nil) }
    #   it { described.instance_variable_get('@repository').must_equal(Vedeu.interfaces) }

    #   context 'with default attributes' do
    #     let(:attributes) { {} }

    #     it { subject.instance_variable_get('@attributes').must_equal({
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

    describe '#cursor' do
      subject { instance.cursor }

      it { skip }
    end

    describe '#lines' do
      it { instance.lines.must_be_instance_of(Vedeu::Model::Lines) }
    end

    describe '#render' do
      subject { instance.render }

      it { skip }
    end

    describe '#store' do
      subject { instance.store }

      context 'when the interface has no name' do
        it { proc { subject }.must_raise(MissingRequired) }
      end

      context 'when the interface has a name' do
        context 'when a buffer exists' do
          it { skip }
        end

        context 'when a buffer does not exist' do
          it { skip }
        end

        context 'when a refresh event exists' do
          it { skip }
        end

        context 'when a refresh event does not exist' do
          it { skip }
        end

        context 'when the interface has a group' do
          it { skip }
        end
      end
    end

    describe '#viewport' do
      subject { instance.viewport }

      it { skip }
    end

  end # Interface

end # Vedeu
