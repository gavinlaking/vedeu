# frozen_string_literal: true

module Vedeu

  # Provides a mechanism to control a running client application via
  # DRb.
  #
  module Distributed

  end # Distributed

  # :nocov:

  # See {file:docs/events/drb.md#\_drb_restart_}
  Vedeu.bind(:_drb_restart_) { Vedeu::Distributed::Server.restart }

  # See {file:docs/events/drb.md#\_drb_start_}
  Vedeu.bind(:_drb_start_) { Vedeu::Distributed::Server.start }

  # See {file:docs/events/drb.md#\_drb_status_}
  Vedeu.bind(:_drb_status_) { Vedeu::Distributed::Server.status }

  # See {file:docs/events/drb.md#\_drb_stop_}
  Vedeu.bind(:_drb_stop_) { Vedeu::Distributed::Server.stop }

  # :nocov:

end # Vedeu

require 'vedeu/distributed/uri'
require 'vedeu/distributed/server'
require 'vedeu/distributed/client'
require 'vedeu/distributed/subprocess'
