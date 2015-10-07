module Vedeu

  # Binds various events for running and manipulating Vedeu. When
  # called provide a variety of core functions and behaviours.
  # They are soft-namespaced using underscores.
  #
  # @note
  #   The methods these modules use are private, and should not be
  #   called directly, however the produced events are all public and
  #   are highly recommended to be used.
  #
  #   Unbinding any of these events is likely to cause problems, so I
  #   would advise leaving them alone. A safe rule: when the name
  #   starts and ends with an underscore, it's probably used by Vedeu
  #   internally.
  #
  module Bindings

  end # Bindings

end # Vedeu

require 'vedeu/bindings/application'
require 'vedeu/bindings/cursors'
require 'vedeu/bindings/document'
require 'vedeu/bindings/drb'
require 'vedeu/bindings/menus'
require 'vedeu/bindings/movement'
require 'vedeu/bindings/focus'
require 'vedeu/bindings/refresh'
require 'vedeu/bindings/system'
require 'vedeu/bindings/view'
require 'vedeu/bindings/visibility'
require 'vedeu/bindings/bindings'
