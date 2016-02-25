# frozen_string_literal: true

module Vedeu

  # Provides the classes which control the basic Vedeu runtime.
  #
  module Runtime

  end # Runtime

  # :nocov:

  # See {file:docs/events/system.md#\_cleanup_}
  Vedeu.bind(:_cleanup_) do
    Vedeu.trigger(:_drb_stop_)
    Vedeu.trigger(:cleanup)
  end

  # See {file:docs/events/system.md#\_exit_}
  Vedeu.bind(:_exit_) { Vedeu.exit }

  # See {file:docs/events/application.md#\_goto_}
  Vedeu.bind(:_goto_) do |controller, action, **args|
    Vedeu::Runtime::Router.goto(controller, action, **args)
  end

  # Vedeu.bind_alias(:_action_, :_goto_)

  # See {file:docs/events/system.md#\_initialize_}
  Vedeu.bind(:_initialize_) { Vedeu.ready! }

  # See {file:docs/events/system.md#\_mode_switch_}
  Vedeu.bind(:_mode_switch_) do |mode|
    Vedeu::Runtime::MainLoop.mode_switch!(mode)
  end

  # :nocov:

end # Vedeu

require 'vedeu/runtime/traps'
require 'vedeu/runtime/launcher'
require 'vedeu/runtime/bootstrap'
require 'vedeu/runtime/router'
require 'vedeu/runtime/main_loop'
require 'vedeu/runtime/flags'
require 'vedeu/runtime/application'
