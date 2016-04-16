# frozen_string_literal: true

module Vedeu

  # The Buffer object represents the states of display for an
  # interface. The states are 'front', 'back' and 'previous'.
  #
  # [Back] -> [Front] -> [Previous]
  #
  # The content on the screen, or last output will always be the
  # 'Front' buffer. Content due to be displayed on next refresh will
  # come from the 'Back' buffer when available, otherwise from the
  # current 'Front' buffer. When new content is copied to the 'Front'
  # buffer, the current 'Front' buffer is also copied to the
  # 'Previous' buffer.
  #
  module Buffers

  end # Buffers

  # :nocov:

  # @see Vedeu::Buffers::Terminal#clear
  Vedeu.bind(:_clear_) { Vedeu.clear }

  # @see Vedeu::Buffers::Terminal#output
  Vedeu.bind(:_drb_retrieve_output_) { Vedeu::Buffers::Terminal.output }

  # @see Vedeu::Buffers::Terminal#write
  Vedeu.bind(:_drb_store_output_) do |data|
    Vedeu::Buffers::Terminal.write(data)
  end

  # See {file:docs/events/by_name/refresh_view.md}
  Vedeu.bind(:_refresh_view_) do |name|
    Vedeu::Buffers::Refresh.by_name(name) if Vedeu.ready?
  end

  # See {file:docs/events/by_name/refresh_view_content.md}
  Vedeu.bind(:_refresh_view_content_) do |name|
    Vedeu::Buffers::RefreshContent.by_name(name) if Vedeu.ready?
  end

  # :nocov:

end # Vedeu

require 'vedeu/buffers/empty'
require 'vedeu/buffers/view'
require 'vedeu/buffers/buffer'
require 'vedeu/buffers/null'
require 'vedeu/buffers/repository'
require 'vedeu/buffers/refresh'
require 'vedeu/buffers/refresh_content'
require 'vedeu/buffers/terminal'
