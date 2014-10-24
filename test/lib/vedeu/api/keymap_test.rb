require 'test_helper'

module Vedeu

  module API

    describe Keymap do

      describe '#key' do
        before { Vedeu::Keymaps.reset }

        it 'raises an exception when a block is not given' do
          proc {
            Vedeu.keys do
              key 'q'
            end
          }.must_raise(InvalidSyntax)
        end

        it 'raises an exception when a key is not given' do
          proc {
            Vedeu.keys do
              key('') { :some_action }
            end
          }.must_raise(InvalidSyntax)
        end

        it 'returns the instance of API::Keymap' do
          Vedeu.keys do
            key('f') { :some_action }
          end.must_be_instance_of(API::Keymap)
        end

        it 'returns a collection of the keypresses' do
          Keymap.new.key('v', 'd', 'u') do
            :some_action
          end.must_equal(['v', 'd', 'u'])
        end
      end

      describe '#interface' do
        it 'returns the instance of API::Keymap' do
          Vedeu.keys do
            key('d') { :some_action }
            interface 'neodymium'
          end.must_be_instance_of(API::Keymap)
        end

        it 'returns the instance of API::Keymap' do
          Vedeu.keys do
            key('e') { :some_action }
            interface ['neodymium', 'californium']
          end.must_be_instance_of(API::Keymap)
        end

        it 'returns a collection of the interfaces' do
          Keymap.new.interface('americium').must_equal(['americium'])
        end
      end

    end # Keymap

  end # API

end # Vedeu
