require 'test_helper'

module Vedeu
  module API

    describe Interface do
      before { Vedeu::Buffers.reset }

      describe '#define' do
        interface = Interface.new({ name: 'widget' })

        it 'creates and stores a new interface' do
          interface.define.must_be_instance_of(API::Interface)
        end

        it 'allows the setting of colours' do
          Interface.build do
            colour foreground: '#aadd00', background: '#222222'
          end.must_equal(
            {
              name: '',
              group: '',
              lines: [],
              colour: {
                foreground: '#aadd00',
                background: '#222222'
              },
              style: '',
              geometry: {},
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'allows the setting of styles' do
          Interface.build do
            style 'underline'
          end.must_equal(
            {
              name: '',
              group: '',
              lines: [],
              colour: {},
              style: "underline",
              geometry: {},
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'allows the use of other interfaces for attributes like geometry' do
          IO.console.stub(:winsize, [25, 40]) do
            interface = Vedeu.interface 'my_interface' do
              x      5
              y      5
              width  5
              height 5
            end
            Interface.build do
              name   'my_other_interface'
              y      use('my_interface').south
            end.must_equal({
              name: "my_other_interface",
              group: '',
              lines: [],
              colour: {},
              style: '',
              geometry: {
                y: 11
              },
              delay: 0.0,
              parent: nil,
            })
          end
        end

        it 'allows the setting of a delay for events triggered for this ' \
           'interface' do
          Interface.build do
            delay 1.0
          end.must_equal(
            {
              name: '',
              group: '',
              lines: [],
              colour: {},
              style: '',
              geometry: {},
              delay: 1.0,
              parent: nil,
            })
        end

        it 'allows the interface to be part of a group- useful for creating ' \
           'separate views' do
          Interface.build do
            group 'my_group'
          end.must_equal(
            {
              name: '',
              group: "my_group",
              lines: [],
              colour: {},
              style: '',
              geometry: {},
              delay: 0.0,
              parent: nil,
            }
          )
        end
      end

      describe '#centred' do
        it 'returns false if the value is false or nil' do
          API::Interface.new.centred(false).must_equal(false)
        end

        it 'returns true' do
          API::Interface.new.centred.must_equal(true)
        end
      end

      describe '#delay' do
        it 'sets the delay attribute' do
          Vedeu.interface 'cobalt' do
            delay 0.25
          end

          Vedeu.use('cobalt').attributes[:delay].must_equal(0.25)
        end
      end

      describe '#group' do
        it 'sets the group attribute' do
          Vedeu.interface 'iron' do
            group 'elements'
          end

          Vedeu.use('iron').attributes[:group].must_equal('elements')
        end
      end

      describe '#height' do
        it 'sets the attribute to the value' do
          Vedeu.interface 'iron' do
            height 6
          end

          Vedeu.use('iron').attributes[:geometry][:height].must_equal(6)
        end
      end

      describe '#line' do
        it 'adds a blank line with no arguments' do
          interface = Vedeu.interface 'carbon' do
            line
          end
          interface.must_be_instance_of(API::Interface)
          interface.attributes.must_equal(
            {
              name: 'carbon',
              group: '',
              lines: [
                {
                  colour: {},
                  streams: {
                    text: ''
                  },
                  style: [],
                  parent: interface.view_attributes,
                }
              ],
              colour: {},
              style: '',
              geometry: {},
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'adds a line directly with a value and no block' do
          interface = Vedeu.interface 'carbon' do
            line 'This is some text...'
          end
          interface.must_be_instance_of(API::Interface)
          interface.attributes.must_equal(
            {
              name: 'carbon',
              group: '',
              lines: [
                {
                  colour: {},
                  streams: {
                    text: "This is some text..."
                  },
                  style: [],
                  parent: interface.view_attributes,
                }
              ],
              colour: {},
              style: '',
              geometry: {},
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'allows the addition of more attributes with a block' do
          interface = Vedeu.interface 'silicon' do
            line do
              text 'This is different text...'
            end
          end
          interface.must_be_instance_of(API::Interface)
          interface.attributes.must_equal(
            {
              name: "silicon",
              group: '',
              lines: [
                {
                  colour: {},
                  streams: [
                    {
                      text: "This is different text..."
                    }
                  ],
                  style: [],
                  parent: interface.view_attributes,
                }
              ],
              colour: {},
              style: '',
              geometry: {},
              delay: 0.0,
              parent: nil
            }
          )
        end
      end

      describe '#name' do
        it 'sets the name attribute' do
          Vedeu.interface do
            name 'nickel'
          end

          Vedeu.use('nickel').attributes[:name].must_equal('nickel')
        end
      end

      describe '#use' do
        it 'returns the interface by name' do
          interface = Vedeu.interface('tungsten') {}

          Interface.new.use('tungsten').must_be_instance_of(Vedeu::Interface)
        end
      end

      describe '#width' do
        it 'sets the attribute to the value' do
          Vedeu.interface 'iron' do
            width 25
          end

          Vedeu.use('iron').attributes[:geometry][:width].must_equal(25)
        end
      end

      describe '#x' do
        it 'sets the attribute to the block if a block is given' do
          skip
        end

        it 'sets the attribute to the value if a block is not given' do
          Vedeu.interface 'iron' do
            x 7
          end

          Vedeu.use('iron').attributes[:geometry][:x].must_equal(7)
        end
      end

      describe '#y' do
        it 'sets the attribute to the block if a block is given' do
          skip
        end

        it 'sets the attribute to the value if a block is not given' do
          Vedeu.interface 'iron' do
            y 4
          end

          Vedeu.use('iron').attributes[:geometry][:y].must_equal(4)
        end
      end

    end
  end
end
