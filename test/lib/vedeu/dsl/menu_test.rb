require 'test_helper'

module Vedeu

  module DSL

    describe Menu do

      let(:described)  { Vedeu::DSL::Menu.new(model) }
      let(:model)      { Vedeu::Menu.new(attributes) }
      let(:attributes) { { collection: menu_items, name: menu_name }}
      let(:menu_items) { [:sodium, :magnesium, :aluminium, :silicon] }
      let(:menu_name)  { 'elements' }

      # describe '.define' do
      #   before { Menus.reset }

      #   context 'when a block was not given' do
      #     it { proc { Vedeu.menu }.must_raise(InvalidSyntax) }
      #   end

      #   context 'when no name was specified' do
      #     it { proc { Vedeu.menu { } }.must_raise(MissingRequired) }
      #   end

      #   it 'adds the menu to the menus repository' do
      #     Vedeu.menu do
      #       name  menu_name
      #       items menu_items
      #     end

      #     Vedeu::Menus.registered.must_equal(['elements'])
      #   end
      # end

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Menu) }
        it { assigns(described, '@model', model) }
      end

      # describe '.define' do
      #   before { Menus.reset }

      #   context 'when a block was not given' do
      #     it { proc { Menu.define }.must_raise(InvalidSyntax) }
      #   end

      #   context 'when no name was specified for the menu' do
      #     it { proc { Menu.define { } }.must_raise(MissingRequired) }
      #   end

      #   it 'adds the menu to the menus repository' do
      #     Menu.define do
      #       name  'elements'
      #       items [:sodium, :magnesium, :aluminium, :silicon]
      #     end

      #     Vedeu::Menus.registered.must_equal(['elements'])
      #   end

      #   it 'returns the API::Menu instance' do
      #     Menu.define do
      #       name 'elements'
      #     end.must_be_instance_of(Vedeu::Menu)
      #   end
      # end

      # describe '#initialize' do
      #   it 'returns an instance of itself' do
      #     Menu.new.must_be_instance_of(Menu)
      #   end

      #   it 'assigns the attributes' do
      #     attributes = { name: '', items: [] }
      #     subject    = Menu.new(attributes)
      #     assigns(subject, '@attributes', attributes)
      #   end
      # end

      # describe '#items' do
      #   it 'returns an empty collection when no items are provided' do
      #     Menu.new.items.must_equal([])
      #   end

      #   it 'assigns the instance of Vedeu::Menu to the attributes' do
      #     items = [:sodium, :magnesium, :aluminium, :silicon]

      #     menu = Menu.new
      #     menu.items(items)
      #     menu.attributes[:items].must_equal(items)
      #   end
      # end

      # describe '#name' do
      #   it 'returns the name of the menu' do
      #     menu = Menu.new
      #     menu.name('elements').must_equal('elements')
      #   end

      #   it 'assigns the name to the attributes' do
      #     menu = Menu.new
      #     menu.name('elements')
      #     menu.attributes[:name].must_equal('elements')
      #   end
      # end

    end # Menu

  end # DSL

end # Vedeu
