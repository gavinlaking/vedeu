require 'test_helper'

describe 'Menus' do

  describe '#item' do
    subject {
      Vedeu.menu 'menus' do
        item 'hydrogen'
      end
    }

    it { return_type_for(subject, Vedeu::Menu) }

    it 'allows the use of item within Vedeu.menu' do
      subject.collection.must_equal(['hydrogen'])
    end
  end

  describe '#items' do
    subject {
      Vedeu.menu 'menus' do
        items ['lithium', 'beryllium']
      end
    }

    it { return_type_for(subject, Vedeu::Menu) }

    it 'allows the use of item within Vedeu.menu' do
      subject.collection.must_equal(['lithium', 'beryllium'])
    end
  end

  describe '#name' do
    subject {
      Vedeu.menu 'menus' do
        name 'elements'
      end
    }

    it { return_type_for(subject, Vedeu::Menu) }

    it 'allows the use of name within Vedeu.menu' do
      subject.name.must_equal('elements')
    end
  end

end
