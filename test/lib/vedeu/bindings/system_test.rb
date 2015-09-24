require 'test_helper'

module Vedeu

  module Bindings

    describe System do

      context 'the system events needed by Vedeu to run are defined' do
        it { Vedeu.bound?(:_cleanup_).must_equal(true) }
        it { Vedeu.bound?(:_command_).must_equal(true) }
        it { Vedeu.bound?(:_editor_).must_equal(true) }
        it { Vedeu.bound?(:_exit_).must_equal(true) }
        it { Vedeu.bound?(:_initialize_).must_equal(true) }
        it { Vedeu.bound?(:_keypress_).must_equal(true) }
        it { Vedeu.bound?(:_log_).must_equal(true) }
        it { Vedeu.bound?(:_mode_switch_).must_equal(true) }
      end

    end # System

  end # Bindings

end # Vedeu
