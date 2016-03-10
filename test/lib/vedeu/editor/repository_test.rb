# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
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

  module Editor

    describe Repository do

      let(:described) { Vedeu::Editor::Repository }

    end # Repository

  end # Editor

end # Vedeu
