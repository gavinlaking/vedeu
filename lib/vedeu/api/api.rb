require 'vedeu/support/common'
require 'vedeu/support/terminal'

require 'vedeu/events/all'

require 'vedeu/models/all'
require 'vedeu/input/keymap'
require 'vedeu/input/keymaps'
require 'vedeu/dsl/composition'
require 'vedeu/dsl/shared'
require 'vedeu/dsl/view'

module Vedeu

  # Provides the API to Vedeu. Methods therein, and classes belonging to this
  # module expose Vedeu's core functionality.
  #
  # @api public
  module API

    include Vedeu::Common
    extend  Forwardable
    extend  self

    def_delegators Vedeu::Configuration, :configure
    def_delegators Vedeu::DSL::View,     :interface, :renders, :views
    def_delegators Vedeu::DSL::Shared,   :use
    def_delegators Vedeu::Focus,         :focus
    def_delegators Vedeu::Keymap,        :keymap
    def_delegators Vedeu::Menu,          :menu
    def_delegators Vedeu::Terminal,      :height, :width, :resize
    def_delegators Vedeu::Keymaps,       :keypress

    def_delegators Vedeu::Event,   :event
    def_delegators Vedeu::Trigger, :trigger
    def_delegators Vedeu::Events,  :unevent

  end # API

  extend API

  trap('SIGWINCH') { Vedeu.trigger(:_resize_) }

end # Vedeu
