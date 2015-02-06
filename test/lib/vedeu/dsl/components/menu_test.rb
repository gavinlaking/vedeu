require 'test_helper'

module Vedeu

  module DSL

    describe Menu do

      let(:described)  { Vedeu::DSL::Menu }
      let(:instance)   { described.new(model) }
      let(:model)      { Vedeu::Menu.new(collection, menu_name) }
      let(:collection) { [:sodium, :magnesium, :aluminium, :silicon] }
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
        subject { instance }

        it { subject.must_be_instance_of(Vedeu::DSL::Menu) }
        it { subject.instance_variable_get('@model').must_equal(model) }
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

      describe '#item' do
        let(:value) { :platinum }

        subject { instance.item(value) }

        context 'when items are provided' do
          it { subject.must_equal([:sodium,
                                    :magnesium,
                                    :aluminium,
                                    :silicon,
                                    :platinum]) }
        end
      end

      describe '#items' do
        let(:value) { [] }

        subject { instance.items(value) }

        context 'when no items are provided' do
          it { subject.must_equal([]) }
        end

        context 'when items are provided' do
          let(:value) { [:gold, :silver, :tin] }

          it { subject.must_equal(value)}
        end
      end

      describe '#name' do
        let(:value) { 'metals' }

        subject { instance.name(value) }

        it 'returns the name of the menu' do
          subject
          model.name.must_equal('metals')
        end
      end

    end # Menu

  end # DSL

end # Vedeu
