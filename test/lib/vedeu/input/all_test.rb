require 'test_helper'

module Vedeu

  describe '.keymaps' do
    subject { Vedeu.keymaps }

    it { subject.must_be_instance_of(Vedeu::Keymaps) }
  end

  describe 'the system keymap events are defined' do
    it { Vedeu.events.registered?(:_exit_).must_equal(true) }
    it { Vedeu.events.registered?(:_focus_next_).must_equal(true) }
    it { Vedeu.events.registered?(:_focus_prev_).must_equal(true) }
    it { Vedeu.events.registered?(:_mode_switch_).must_equal(true) }
  end

end # Vedeu
