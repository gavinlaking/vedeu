# frozen_string_literal: true

module Vedeu

  # This module allows the sharing of presentation concerns between
  # the models: Interface, View, Line and Stream.
  #
  # @api private
  #
  module Presentation

  end # Presentation

end # Vedeu

require 'vedeu/presentation/parent'
require 'vedeu/presentation/colour'
require 'vedeu/presentation/position'
require 'vedeu/presentation/styles'
require 'vedeu/presentation/style'
require 'vedeu/presentation/presentation'
