require 'test_helper'

module Vedeu

  module DSL

    describe Menu do

      let(:described)  { Vedeu::DSL::Menu }
      let(:instance)   { described.new(model) }
      let(:model)      { Vedeu::Menu.new(attributes) }
      let(:attributes) {
        {
          collection: collection,
          name:       menu_name,
        }
      }
      let(:collection) { [:sodium, :magnesium, :aluminium, :silicon] }
      let(:menu_name)  { 'elements' }

      describe '#initialize' do
        it { instance.must_be_instance_of(Vedeu::DSL::Menu) }
        it { instance.instance_variable_get('@model').must_equal(model) }
      end

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
