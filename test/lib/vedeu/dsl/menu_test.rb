require 'test_helper'

module Vedeu

  module DSL

    describe Menu do

      describe '.define' do
        before { Menus.reset }

        it 'raises an exception if no block was given' do
          proc { Vedeu.menu }.must_raise(InvalidSyntax)
        end

        it 'raises an exception if no name was specified for the menu' do
          proc { Vedeu.menu { } }.must_raise(MissingRequired)
        end

        it 'adds the menu to the menus repository' do
          Vedeu.menu do
            name  'elements'
            items [:sodium, :magnesium, :aluminium, :silicon]
          end

          Vedeu::Menus.registered.must_equal(['elements'])
        end

        it 'returns the API::Menu instance' do
          skip

          Vedeu.menu do
            name 'elements'
          end.must_be_instance_of(Vedeu::Menu)
        end
      end

      describe '#initialize' do
        it 'returns an instance of itself' do
          skip

          Menu.new.must_be_instance_of(DSL::Menu)
        end
      end

      describe '#items' do
        it 'returns an empty collection when no items are provided' do
          skip

          Menu.new.items.must_equal([])
        end

        it 'assigns the instance of Vedeu::Menu to the attributes' do
          skip

          items = [:sodium, :magnesium, :aluminium, :silicon]

          menu = Menu.new
          menu.items(items).must_equal(items)
        end
      end

      describe '#name' do
        it 'returns the name of the menu' do
          skip

          menu = Menu.new
          menu.name('elements').must_equal('elements')
        end

        it 'assigns the name to the attributes' do
          skip

          menu = Menu.new
          menu.name('elements').must_equal('elements')
        end
      end

    end # Menu

  end # DSL

end # Vedeu
