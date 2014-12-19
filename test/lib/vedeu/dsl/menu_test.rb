require 'test_helper'

module Vedeu

  module DSL

    describe Menu do

      let(:described) { Vedeu::DSL::Menu.new(model) }
      let(:model)     { Vedeu::Menu.new(collection, menu_name) }
      let(:collection){}
      let(:menu_name) {}

      describe '.define' do
        before { Menus.reset }

        context 'when a block was not given' do
          it { proc { Vedeu.menu }.must_raise(InvalidSyntax) }
        end

        context 'when no name was specified' do
          it { proc { Vedeu.menu { } }.must_raise(MissingRequired) }
        end

        it 'adds the menu to the menus repository' do
          Vedeu.menu do
            name  'elements'
            items [:sodium, :magnesium, :aluminium, :silicon]
          end

          Vedeu::Menus.registered.must_equal(['elements'])
        end
      end

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Menu) }
        it { assigns(described, '@model', model) }
      end

    end # Menu

  end # DSL

end # Vedeu
