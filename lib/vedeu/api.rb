require 'vedeu/support/common'
require 'vedeu/support/terminal'
require 'vedeu/events/all'
require 'vedeu/models/all'
require 'vedeu/input/all'
require 'vedeu/dsl/components/all'
require 'vedeu/dsl/composition'
require 'vedeu/dsl/shared/all'
require 'vedeu/dsl/group'
require 'vedeu/dsl/view'

module Vedeu

  # Provides the API to Vedeu. Methods therein, and classes belonging to this
  # module expose Vedeu's core functionality.
  #
  # @api public
  #
  module API

    extend Forwardable
    extend self

    def_delegators Vedeu::Borders,       :borders
    def_delegators Vedeu::Buffers,       :buffers
    def_delegators Vedeu::Cursors,       :cursors
    def_delegators Vedeu::Cursors,       :cursor
    def_delegators Vedeu::EventsRepository, :events
    def_delegators Vedeu::Geometries,    :geometries
    def_delegators Vedeu::Groups,        :groups
    def_delegators Vedeu::InterfacesRepository, :interfaces

    def_delegators Vedeu::Keymaps,       :keymaps
    def_delegators Vedeu::Mapper,        :keypress
    def_delegators Vedeu::Menus,         :menus

    def_delegators Vedeu::Event,         :bind, :trigger, :unbind
    def_delegators Vedeu::Configuration, :configure, :configuration
    def_delegators Vedeu::DSL::Border,   :border
    def_delegators Vedeu::DSL::Geometry, :geometry
    def_delegators Vedeu::DSL::Keymap,   :keymap
    def_delegators Vedeu::DSL::Group,    :group
    def_delegators Vedeu::DSL::Use,      :use
    def_delegators Vedeu::DSL::View,     :interface, :renders, :views

    def_delegators Vedeu::Focus,         :focus, :focus_by_name, :focussed?,
                                         :focus_next, :focus_previous

    def_delegators Vedeu::Log,           :log
    def_delegators Vedeu::Menu,          :menu
    def_delegators Vedeu::Terminal,      :height, :width, :resize

  end # API

  extend API

end # Vedeu
