require 'test_helper'

module Vedeu

  describe Keymaps do

    let(:described) { Vedeu::Keymaps }
    let(:instance)  { described.new(Vedeu::Keymap) }

    describe '#valid?' do
      let(:input) { 'a' }

      subject { instance.valid?(input) }

      context 'when the _global_ or _system_ keymaps are not defined' do
        it { return_type_for(subject, TrueClass) }
      end

      context 'when the _global_ or _system_ keymap is defined' do
        let(:keymap) { Vedeu::Keymap.new('_global_', Vedeu::Model::Collection.new([key])) }
        let(:key)    { Vedeu::Key.new('a') { :some_action } }

        before { instance.store(keymap) }

        context 'and the key is already defined in one of them' do
          let(:input) { 'a' }

          it { proc { subject }.must_raise(KeyInUse) }
        end

        context 'but the key is not defined in either of them' do
          let(:input) { 'b' }

          it { return_type_for(subject, TrueClass) }
        end
      end
    end

  end # Keymaps

end # Vedeu
