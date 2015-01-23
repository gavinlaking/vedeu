require 'vedeu/support/common'
require 'vedeu/support/terminal'
require 'vedeu/events/all'
require 'vedeu/models/all'
require 'vedeu/input/all'
require 'vedeu/dsl/composition'
require 'vedeu/dsl/shared'
require 'vedeu/dsl/view'

module Vedeu

  # Provides the API to Vedeu. Methods therein, and classes belonging to this
  # module expose Vedeu's core functionality.
  #
  # @api public
  module API

    extend Forwardable
    extend self

    def_delegators Vedeu::Event,         :bind, :trigger, :unbind
    def_delegators Vedeu::Configuration, :configure, :configuration
    def_delegators Vedeu::DSL::View,     :interface, :renders, :views
    def_delegators Vedeu::DSL::Shared,   :use
    def_delegators Vedeu::Focus,         :focus, :focus_by_name, :focussed?,
                                         :focus_next, :focus_previous
    def_delegators Vedeu::Keymap,        :keymap
    def_delegators Vedeu::Log,           :log
    def_delegators Vedeu::Mapper,        :keypress
    def_delegators Vedeu::Menu,          :menu
    def_delegators Vedeu::Terminal,      :height, :width, :resize

    # deprecated heathen
    def_delegators Vedeu::Event, :event, :unevent

  end # API

  extend API

end # Vedeu
