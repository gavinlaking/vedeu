# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Menus

    describe DSL do

      let(:described)  { Vedeu::Menus::DSL }
      let(:instance)   { described.new(model) }
      let(:model)      { Vedeu::Menus::Menu.new(attributes) }
      let(:_name)      { 'elements' }
      let(:collection) { [:sodium, :magnesium, :aluminium, :silicon] }
      let(:attributes) {
        {
          collection: collection,
          name:       _name,
        }
      }

      describe '.menu' do
        subject {
          described.menu(_name) do
            # ...
          end
        }

        context 'when the name is not given' do
          let(:_name) {}

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the name is given' do
          context 'when the block is not given' do
            subject { described.menu(_name) }

            it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
          end

          context 'when the block is given' do
            it { subject.must_be_instance_of(Vedeu::Menus::Menu) }
          end
        end
      end

      describe '#item' do
        let(:_value) { :platinum }

        subject { instance.item(_value) }

        context 'when items are provided' do
          it { subject.must_equal([:sodium,
                                    :magnesium,
                                    :aluminium,
                                    :silicon,
                                    :platinum]) }
        end
      end

      describe '#item=' do
        it { instance.must_respond_to(:item=) }
      end

      describe '#items' do
        let(:_value) { [] }

        subject { instance.items(_value) }

        context 'when no items are provided' do
          it { subject.must_equal([]) }
        end

        context 'when items are provided' do
          let(:_value) { [:gold, :silver, :tin] }

          it { subject.must_equal(_value)}
        end
      end

      describe '#items=' do
        it { instance.must_respond_to(:items=) }
      end

    end # DSL

  end # Menus

end # Vedeu
