require 'test_helper'

describe 'Keymaps' do

  describe '#key' do
    subject {
      Vedeu.keymap 'keymaps' do
        key '' do
        end
      end
    }

    #it { return_type_for(subject, Vedeu::Keymap) }

    it 'allows the use of ... within Vedeu.keymap' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#name' do
    subject {
      Vedeu.keymap 'keymaps' do
        name ''
      end
    }

    #it { return_type_for(subject, Vedeu::Keymap) }

    it 'allows the use of ... within Vedeu.keymap' do
      skip
    end

    context 'when no value is provided' do

    end
  end

end
