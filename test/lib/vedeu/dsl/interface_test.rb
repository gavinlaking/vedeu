require 'test_helper'

module Vedeu

  module DSL

    describe Interface do

      let(:described) { Vedeu::DSL::Interface.new(model) }
      let(:model)     { mock('Interface') }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Interface) }
        it { assigns(described, '@model', model) }
      end

      describe '#border' do
        it { skip }
      end

      describe '#cursor' do
      end

      describe '#cursor!' do
      end

      before { Vedeu.interfaces_repository.reset }

      # describe '#define' do
      #   interface = Interface.new({ name: 'widget' })

      #   it 'creates and stores a new interface' do
      #     interface.define.must_be_instance_of(API::Interface)
      #   end

      #   it 'allows the setting of colours' do
      #     Interface.build do
      #       colour foreground: '#aadd00', background: '#222222'
      #     end.must_equal(
      #       {
      #         border: {},
      #         colour: {
      #           foreground: '#aadd00',
      #           background: '#222222'
      #         },
      #         cursor: :hide,
      #         delay: 0.0,
      #         geometry: {},
      #         group: '',
      #         lines: [],
      #         name: '',
      #         parent: nil,
      #         style: '',
      #       }
      #     )
      #   end

      #   it 'allows the setting of styles' do
      #     Interface.build do
      #       style 'underline'
      #     end.must_equal(
      #       {
      #         border: {},
      #         colour: {},
      #         cursor: :hide,
      #         delay: 0.0,
      #         geometry: {},
      #         group: '',
      #         lines: [],
      #         name: '',
      #         parent: nil,
      #         style: "underline",
      #       }
      #     )
      #   end

      #   it 'allows the use of other interfaces for attributes like geometry' do
      #     IO.console.stub(:winsize, [25, 40]) do
      #       interface = Vedeu.interface 'my_interface' do
      #         geometry do
      #           x      5
      #           y      5
      #           width  5
      #           height 5
      #         end
      #       end
      #       Interface.build do
      #         name   'my_other_interface'
      #         y      use('my_interface').south
      #       end.must_equal({
      #         border: {},
      #         colour: {},
      #         cursor: :hide,
      #         delay: 0.0,
      #         geometry: {
      #           y: 11
      #         },
      #         group: '',
      #         lines: [],
      #         name: "my_other_interface",
      #         parent: nil,
      #         style: '',
      #       })
      #     end
      #   end

      #   it 'allows the setting of a delay for events triggered for this ' \
      #      'interface' do
      #     Interface.build do
      #       delay 1.0
      #     end.must_equal(
      #       {
      #         border: {},
      #         colour: {},
      #         cursor: :hide,
      #         delay: 1.0,
      #         geometry: {},
      #         group: '',
      #         lines: [],
      #         name: '',
      #         parent: nil,
      #         style: '',
      #       })
      #   end

      #   it 'allows the interface to be part of a group- useful for creating ' \
      #      'separate views' do
      #     Interface.build do
      #       group 'my_group'
      #     end.must_equal(
      #       {
      #         border: {},
      #         colour: {},
      #         cursor: :hide,
      #         delay: 0.0,
      #         geometry: {},
      #         group: "my_group",
      #         lines: [],
      #         name: '',
      #         parent: nil,
      #         style: '',
      #       }
      #     )
      #   end
      # end

      # describe '#centred' do
      #   it 'returns false if the value is false or nil' do
      #     DSL::Interface.new.centred(false).must_equal(false)
      #   end

      #   it 'returns true' do
      #     DSL::Interface.new.centred.must_equal(true)
      #   end
      # end

      describe '#cursor' do
        # it 'returns :hide if the value is false or nil' do
        #   DSL::Interface.new.cursor(false).must_equal(:hide)
        # end

        # it 'returns :hide if the value is false or nil' do
        #   Vedeu.interface 'cobalt' do
        #     cursor false
        #   end

        #   Vedeu.use('cobalt').attributes[:cursor].must_equal(:hide)
        # end

        # it 'returns :show if any other value' do
        #   DSL::Interface.new.cursor.must_equal(:show)
        # end

        # it 'returns :show if any other value' do
        #   Vedeu.interface 'cobalt' do
        #     cursor true
        #   end

        #   Vedeu.use('cobalt').attributes[:cursor].must_equal(:show)
        # end
      end

      describe '#delay' do
        it 'sets the delay attribute' do
          Vedeu.interface 'cobalt' do
            delay 0.25
          end

          Vedeu.use('cobalt').delay.must_equal(0.25)
        end
      end

      # describe '#focus!' do
      #   it 'returns true' do
      #     API::Interface.new({ name: 'curium' }).focus!.must_equal(true)
      #   end

      #   it 'sets the interface as current' do
      #     Vedeu.interface('curium') { focus! }

      #     Focus.current.must_equal('curium')
      #   end

      #   it 'multiple calls will set the last to being current' do
      #     Vedeu.interface('curium')     { focus! }
      #     Vedeu.interface('iodine')     {}
      #     Vedeu.interface('dysprosium') { focus! }

      #     Focus.current.must_equal('dysprosium')
      #   end

      #   it 'no calls will leave the first interface defined as being current' do
      #     Vedeu.interface('curium')     {}
      #     Vedeu.interface('dysprosium') {}

      #     Focus.current.must_equal('curium')
      #   end
      # end

      describe '#group' do
        it 'sets the group attribute' do
          Vedeu.interface 'iron' do
            group 'elements'
          end

          Vedeu.use('iron').group.must_equal('elements')
        end
      end

      # describe '#keys' do
      #   before do
      #     Keymaps.reset

      #     Vedeu.interface 'iron' do
      #       keys do
      #         key('k') { :k_pressed }
      #       end
      #     end
      #   end

      #   it 'defines a keymap for the interface' do
      #     Keymaps.interface_key?('k').must_equal(true)
      #   end

      #   it 'defines a keymap for the interface' do
      #     Keymaps.interface_keys('iron').must_equal(['k'])
      #   end

      #   context 'when the block is not given' do
      #     it { proc { Vedeu.interface('iron') { keys } }.must_raise(InvalidSyntax) }
      #   end
      # end

      # describe '#line' do
      #   it 'adds a blank line with no arguments' do
      #     interface = Vedeu.interface 'carbon' do
      #       line
      #     end
      #     interface.must_be_instance_of(API::Interface)
      #     interface.attributes.must_equal(
      #       {
      #         border: {},
      #         colour: {},
      #         cursor: :hide,
      #         delay: 0.0,
      #         geometry: {},
      #         group: '',
      #         lines: [
      #           {
      #             colour: {},
      #             streams: {
      #               text: ''
      #             },
      #             style: [],
      #           }
      #         ],
      #         name: 'carbon',
      #         parent: nil,
      #         style: '',
      #       }
      #     )
      #   end

      #   it 'adds a line directly with a value and no block' do
      #     interface = Vedeu.interface 'carbon' do
      #       line 'This is some text...'
      #     end
      #     interface.must_be_instance_of(API::Interface)
      #     interface.attributes.must_equal(
      #       {
      #         border: {},
      #         colour: {},
      #         cursor: :hide,
      #         delay: 0.0,
      #         geometry: {},
      #         group: '',
      #         lines: [
      #           {
      #             colour: {},
      #             parent: composition,
      #             streams: {
      #               text: "This is some text..."
      #             },
      #             style: [],
      #           }
      #         ],
      #         name: 'carbon',
      #         parent: nil,
      #         style: '',
      #       }
      #     )
      #   end

      #   it 'allows the addition of more attributes with a block' do
      #     interface = Vedeu.interface 'silicon' do
      #       lines do
      #         text 'This is different text...'
      #       end
      #     end
      #     interface.must_be_instance_of(API::Interface)
      #     interface.attributes.must_equal(
      #       {
      #         border: {},
      #         colour: {},
      #         cursor: :hide,
      #         delay: 0.0,
      #         geometry: {},
      #         group: '',
      #         lines: [
      #           {
      #             colour: {},
      #             parent: composition,
      #             streams: [
      #               {
      #                 text: "This is different text..."
      #               }
      #             ],
      #             style: [],
      #           }
      #         ],
      #         name: "silicon",
      #         parent: nil,
      #         style: '',
      #       }
      #     )
      #   end
      # end

      describe '#name' do
        it 'sets the name attribute' do
          Vedeu.interface do
            name 'nickel'
          end

          Vedeu.use('nickel').name.must_equal('nickel')
        end
      end

    end # Interface

  end # DSL

end # Vedeu
