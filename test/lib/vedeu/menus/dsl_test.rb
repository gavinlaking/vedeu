require 'test_helper'

module Vedeu

  module Menus

    describe DSL do

      let(:described)  { Vedeu::Menus::DSL }
      let(:instance)   { described.new(model) }
      let(:model)      { Vedeu::Menus::Menu.new(attributes) }
      let(:attributes) {
        {
          collection: collection,
          name:       menu_name,
        }
      }
      let(:collection) { [:sodium, :magnesium, :aluminium, :silicon] }
      let(:menu_name)  { 'elements' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@model').must_equal(model) }
      end

      describe '#item' do
        let(:_value) { :platinum }

        subject { instance.item(_value) }

        it { instance.must_respond_to(:item=) }

        context 'when items are provided' do
          it { subject.must_equal([:sodium,
                                    :magnesium,
                                    :aluminium,
                                    :silicon,
                                    :platinum]) }
        end
      end

      describe '#items' do
        let(:_value) { [] }

        subject { instance.items(_value) }

        it { instance.must_respond_to(:items=) }

        context 'when no items are provided' do
          it { subject.must_equal([]) }
        end

        context 'when items are provided' do
          let(:_value) { [:gold, :silver, :tin] }

          it { subject.must_equal(_value)}
        end
      end

      describe '#name' do
        let(:_value) { 'metals' }

        subject { instance.name(_value) }

        it { instance.must_respond_to(:name=) }

        it 'returns the name of the menu' do
          subject
          model.name.must_equal('metals')
        end
      end

    end # DSL

  end # Menus

end # Vedeu
