require 'test_helper'

describe 'Keymaps' do

  describe '#key' do
    subject {
      Vedeu.keymap 'keymaps' do
        key '' do
        end
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Keymap) }

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

    #it { subject.must_be_instance_of(Vedeu::Keymap) }

    it 'allows the use of ... within Vedeu.keymap' do
      skip
    end

    context 'when no value is provided' do

    end
  end

end
