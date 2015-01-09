require 'test_helper'

describe 'Menus' do

  describe '#item' do
    subject {
      Vedeu.menu 'menus' do
        item ''
      end
    }

    it 'allows the use of item within Vedeu.menu' do
      skip
    end
  end

  describe '#items' do
    subject {
      Vedeu.menu 'menus' do
        items []
      end
    }

    it 'allows the use of items within Vedeu.menu' do
      skip
    end
  end

  describe '#name' do
    subject {
      Vedeu.menu 'menus' do
        name ''
      end
    }

    it 'allows the use of name within Vedeu.menu' do
      skip
    end
  end

end
