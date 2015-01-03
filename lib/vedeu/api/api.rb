require 'vedeu/support/common'
require 'vedeu/support/terminal'
require 'vedeu/repositories/events'
require 'vedeu/repositories/focus'
require 'vedeu/repositories/keymaps'
require 'vedeu/models/composition'
require 'vedeu/models/interface'
require 'vedeu/models/menu'
require 'vedeu/input/keymap'
require 'vedeu/dsl/composition'
require 'vedeu/dsl/shared'

module Vedeu

  # Provides the API to Vedeu. Methods therein, and classes belonging to this
  # module expose Vedeu's core functionality.
  #
  # @api public
  module API

    include Vedeu::Common
    extend  Forwardable
    extend  self

    def_delegators Vedeu::Configuration,    :configure
    def_delegators Vedeu::DSL::Composition, :composition, :view, :views
    def_delegators Vedeu::DSL::Shared,      :use
    def_delegators Vedeu::DSL::Composition, :render
    def_delegators Vedeu::Events,           :event, :trigger, :unevent
    def_delegators Vedeu::Focus,            :focus
    def_delegators Vedeu::Interface,        :interface
    def_delegators Vedeu::Keymap,           :keymap
    def_delegators Vedeu::Keymaps,          :keypress
    def_delegators Vedeu::Menu,             :menu
    def_delegators Vedeu::Terminal,         :height, :width, :resize

  end # API

  extend API

  trap('SIGWINCH') { Vedeu.trigger(:_resize_) }

end # Vedeu
