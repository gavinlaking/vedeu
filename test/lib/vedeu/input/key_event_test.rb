require 'test_helper'

module Vedeu

  describe KeyEvent do

    let(:described) { Vedeu::KeyEvent }
    let(:instance) { described.new(keymap_name, key) }
    let(:keymap_name) {}
    let(:key) {}

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, described) }
      it { assigns(subject, '@name', keymap_name) }
      it { assigns(subject, '@key', key) }
    end

    describe '.trigger' do
      subject { described.trigger(keymap_name, key) }

      context 'when the key exists in the keymap' do
        # it { subject.must_equal(true) }
      end

      context 'when the key does not exist in the keymap' do
        it { subject.must_equal(false) }
      end
    end

  end # KeyEvent

end # Vedeu
