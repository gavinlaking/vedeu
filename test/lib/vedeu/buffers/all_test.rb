# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_refresh_view_).must_equal(true) }
    it { Vedeu.bound?(:_refresh_view_content_).must_equal(true) }
  end

end # Vedeu
