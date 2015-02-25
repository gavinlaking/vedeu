require 'test_helper'

describe 'Keymaps' do

  describe '#key' do
    subject {
      Vedeu.keymap 'keymaps' do
        key '' do
        end
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#name' do
    subject {
      Vedeu.keymap 'keymaps' do
        name ''
      end
    }

    context 'when no value is provided' do

    end
  end

end
