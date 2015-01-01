require 'test_helper'

module Vedeu

  describe Menus do

    describe '#use' do
      let(:menu_name)  { 'elements' }
      let(:collection) { [:calcium, :fermium, :nitrogen, :palladium] }

      before { Vedeu::Menu.new('elements', collection).store }

      subject { Menus.use(menu_name) }

      context 'when the named menu exists' do
        # it { return_value_for(subject, Vedeu::Menu) }

        it { skip }
      end

      context 'when the named menu does not exist' do
        let(:menu_name) { '' }

        # it { return_value_for(subject, NilClass) }

        it { skip }
      end
    end

  end # Menus

end # Vedeu
