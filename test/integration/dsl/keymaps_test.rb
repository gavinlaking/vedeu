require 'test_helper'

describe 'Keymaps' do

  describe '#key' do
    subject {
      Vedeu.keymap 'keymaps' do
        key '' do
        end
      end
    }

    it 'allows the use of ... within Vedeu.keymap' do
      skip
    end
  end

  describe '#name' do
    subject {
      Vedeu.keymap 'keymaps' do
        name ''
      end
    }

    it 'allows the use of ... within Vedeu.keymap' do
      skip
    end
  end

end
