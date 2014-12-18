require 'test_helper'

module Vedeu

  module DSL

    describe Keymap do

      let(:described) { Vedeu::DSL::Keymap.new(model) }
      let(:model)     { Vedeu::Keymap.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Keymap) }
        it { assigns(described, '@model', model) }
      end

      describe '#interface' do
        it 'returns the instance of the Keymap model' do
          skip

          Vedeu.keys do
            key('d') { :some_action }
            interface 'neodymium'
          end.must_be_instance_of(Vedeu::Keymap)
        end

        it 'returns the instance of the Keymap model' do
          skip('failing...')

          keymap = Vedeu.keys do
            key('e') { :some_action }
            interface ['neodymium', 'californium']
          end
          keymap.must_be_instance_of(Vedeu::Keymap)
          keymap.interfaces.must_equal()
        end

        it 'returns a collection of the interfaces' do
          skip

          Keymap.new.interface('americium').must_equal(['americium'])
        end
      end

      describe '#key' do
        before { Vedeu::Keymaps.reset }

        it 'raises an exception when a block is not given' do
          skip('failing...')

          proc {
            Vedeu.keys do
              key 'q'
            end
          }.must_raise(InvalidSyntax)
        end

        it 'raises an exception when a key is not given' do
          skip('failing...')

          proc {
            Vedeu.keys do
              key('') { :some_action }
            end
          }.must_raise(InvalidSyntax)
        end

        it 'returns the instance of the Keymap model' do
          skip

          Vedeu.keys do
            key('f') { :some_action }
          end.must_be_instance_of(Vedeu::Keymap)
        end

        it 'returns a collection of the keypresses' do
          skip

          Keymap.new.key('v', 'd', 'u') do
            :some_action
          end.must_equal(['v', 'd', 'u'])
        end
      end

    end # Keymap

  end # DSL

end # Vedeu
