require 'test_helper'

module Vedeu

  module DSL

    describe Interface do

      describe '#cursor' do
        context 'via DSL' do
          it 'returns :hide if the value is false or nil' do
            interface = Vedeu::Interface.build { cursor false }

            interface.cursor.state.must_equal(:hide)
          end

          it 'returns :hide if the value is :hide' do
            interface = Vedeu::Interface.build { cursor :hide }

            interface.cursor.state.must_equal(:hide)
          end

          it 'returns :show if any other value' do
            interface = Vedeu::Interface.build { cursor! }

            interface.cursor.state.must_equal(:show)
          end

          it 'returns :show if any other value' do
            interface = Vedeu::Interface.build { cursor true }

            interface.cursor.state.must_equal(:show)
          end
        end

        context 'via API' do
          it 'returns :hide if the value is false or nil' do
            interface = Vedeu.interface('carbon') { cursor false }

            interface.cursor.state.must_equal(:hide)
          end

          it 'returns :hide if the value is :hide' do
            interface = Vedeu.interface('carbon') { cursor :hide }

            interface.cursor.state.must_equal(:hide)
          end

          it 'returns :show if any other value' do
            interface = Vedeu.interface('carbon') { cursor! }

            interface.cursor.state.must_equal(:show)
          end

          it 'returns :show if any other value' do
            interface = Vedeu.interface('carbon') { cursor :show }

            interface.cursor.state.must_equal(:show)
          end
        end

        context 'via method' do
          it 'returns :hide if the value is false or nil' do
            interface = Vedeu::DSL::Interface.new

            interface.cursor(false).must_equal(:hide)
          end

          it 'returns :hide if the value is :hide' do
            interface = Vedeu::DSL::Interface.new

            interface.cursor(:hide).must_equal(:hide)
          end

          it 'returns :show if any other value' do
            interface = Vedeu::DSL::Interface.new

            interface.cursor!.must_equal(:show)
          end

          it 'returns :show if any other value' do
            interface = Vedeu::DSL::Interface.new

            interface.cursor(true).must_equal(:show)
          end
        end
      end

      describe '#delay' do
        context 'via DSL' do
          it 'sets the delay attribute' do
            interface = Vedeu.interface('cobalt') { delay 0.25 }

            interface.delay.must_equal(0.25)
          end
        end

        context 'via API' do
          it 'sets the delay attribute' do
            interface = Vedeu::Interface.build { delay 0.25 }

            interface.delay.must_equal(0.25)
          end
        end

        context 'via method' do
          it 'sets the delay attribute' do
            interface = Vedeu::DSL::Interface.new

            interface.delay(0.25).must_equal(0.25)
          end
        end
      end

      # describe '#focus!' do
      #   it 'returns true' do
      #     Vedeu::Interface.build do
      #       focus!
      #     end.focus.must_equal(true)
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
        context 'via DSL' do
          it 'sets the group attribute' do
            interface = Vedeu.interface('iron') { group 'elements' }

            interface.group.must_equal('elements')
          end
        end

        context 'via API' do
          it 'sets the group attribute' do
            interface = Vedeu::Interface.build { group 'elements' }

            interface.group.must_equal('elements')
          end
        end

        context 'via method' do
          it 'sets the group attribute' do
            interface = Vedeu::DSL::Interface.new

            interface.group('elements').must_equal('elements')
          end
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
      #     it 'raises an exception' do
      #       proc { Vedeu.interface('iron') { keys } }.must_raise(InvalidSyntax)
      #     end
      #   end
      # end

      # describe '#line' do
      #   it 'adds a blank line with no arguments' do
      #     interface = Vedeu.interface 'carbon' do
      #       line
      #     end
      #     interface.must_be_instance_of(Interface)
      #     interface.attributes.must_equal(
      #       {
      #         name: 'carbon',
      #         cursor: :hide,
      #         group: '',
      #         lines: [
      #           {
      #             colour: {},
      #             streams: {
      #               text: ''
      #             },
      #             style: [],
      #             parent: interface.view_attributes,
      #           }
      #         ],
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         delay: 0.0,
      #         parent: nil,
      #       }
      #     )
      #   end

      #   it 'adds a line directly with a value and no block' do
      #     interface = Vedeu.interface 'carbon' do
      #       line 'This is some text...'
      #     end
      #     interface.must_be_instance_of(Interface)
      #     interface.attributes.must_equal(
      #       {
      #         name: 'carbon',
      #         cursor: :hide,
      #         group: '',
      #         lines: [
      #           {
      #             colour: {},
      #             streams: {
      #               text: "This is some text..."
      #             },
      #             style: [],
      #             parent: interface.view_attributes,
      #           }
      #         ],
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         delay: 0.0,
      #         parent: nil,
      #       }
      #     )
      #   end

      #   it 'allows the addition of more attributes with a block' do
      #     interface = Vedeu.interface 'silicon' do
      #       line do
      #         text 'This is different text...'
      #       end
      #     end
      #     interface.must_be_instance_of(Interface)
      #     interface.attributes.must_equal(
      #       {
      #         name: "silicon",
      #         cursor: :hide,
      #         group: '',
      #         lines: [
      #           {
      #             colour: {},
      #             streams: [
      #               {
      #                 text: "This is different text..."
      #               }
      #             ],
      #             style: [],
      #             parent: interface.view_attributes,
      #           }
      #         ],
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         delay: 0.0,
      #         parent: nil
      #       }
      #     )
      #   end
      # end

      describe '#name' do
        context 'via DSL' do
          it 'sets the name of the interface' do
            interface = Vedeu.interface { name 'nickel' }

            interface.name.must_equal('nickel')
          end
        end

        context 'via API' do
          it 'sets the name of the interface' do
            interface = Vedeu::Interface.build { name 'nickel' }

            interface.name.must_equal('nickel')
          end
        end

        context 'via method' do
          it 'sets the name of the interface' do
            interface = Vedeu::DSL::Interface.new

            interface.name('nickel').must_equal('nickel')
          end
        end
      end

      # describe '#use' do
      #   it 'returns the interface by name' do
      #     interface = Vedeu.interface 'tungsten' do
      #       group 'metals'
      #     end

      #     interface.use('tungsten').must_be_instance_of(Vedeu::Interface)
      #     interface.use('tungsten').group.must_equal('metals')
      #   end
      # end

    end # Interface

  end # DSL

end # Vedeu
