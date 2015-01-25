require 'test_helper'

describe 'Menus' do

  describe '#item' do
    subject {
      Vedeu.menu 'menus' do
        item 'hydrogen'
      end
    }

    it { subject.must_be_instance_of(Vedeu::Menu) }

    it 'allows the use of item within Vedeu.menu' do
      subject.collection.must_equal(['hydrogen'])
    end

    context 'when no value is provided' do

    end
  end

  describe '#items' do
    subject {
      Vedeu.menu 'menus' do
        items ['lithium', 'beryllium']
      end
    }

    it { subject.must_be_instance_of(Vedeu::Menu) }

    it 'allows the use of item within Vedeu.menu' do
      subject.collection.must_equal(['lithium', 'beryllium'])
    end

    context 'when no value is provided' do

    end
  end

  describe '#name' do
    subject {
      Vedeu.menu 'menus' do
        name 'elements'
      end
    }

    it { subject.must_be_instance_of(Vedeu::Menu) }

    it 'allows the use of name within Vedeu.menu' do
      subject.name.must_equal('elements')
    end

    context 'when no value is provided' do

    end
  end

end
