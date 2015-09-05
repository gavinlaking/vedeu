require 'test_helper'

module Vedeu

  module Bindings

    describe Document do

      context 'the system events needed by Vedeu to run are defined' do
        it { Vedeu.bound?(:_editor_execute_).must_equal(true) }
        it { Vedeu.bound?(:_editor_delete_character_).must_equal(true) }
        it { Vedeu.bound?(:_editor_delete_line_).must_equal(true) }
        it { Vedeu.bound?(:_editor_down_).must_equal(true) }
        it { Vedeu.bound?(:_editor_insert_character_).must_equal(true) }
        it { Vedeu.bound?(:_editor_insert_line_).must_equal(true) }
        it { Vedeu.bound?(:_editor_left_).must_equal(true) }
        it { Vedeu.bound?(:_editor_right_).must_equal(true) }
        it { Vedeu.bound?(:_editor_up_).must_equal(true) }
      end

    end # Document

  end # Bindings

end # Vedeu
