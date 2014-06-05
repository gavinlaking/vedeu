require 'date'
require 'logger'
require 'io/console'

require_relative 'vedeu/support/terminal'

require_relative 'vedeu/output/base'
require_relative 'vedeu/output/background'
require_relative 'vedeu/output/compositor'
require_relative 'vedeu/output/directive'
require_relative 'vedeu/output/foreground'
require_relative 'vedeu/output/geometry'
require_relative 'vedeu/output/esc'
require_relative 'vedeu/output/colour'
require_relative 'vedeu/output/position'
require_relative 'vedeu/output/renderer'
require_relative 'vedeu/output/style'
require_relative 'vedeu/output/translator'
require_relative 'vedeu/output/wordwrap'


require_relative 'vedeu/process/commands'
require_relative 'vedeu/process/command'
require_relative 'vedeu/process/event_loop'
require_relative 'vedeu/process/exit'

require_relative 'vedeu/repository/repository'
require_relative 'vedeu/repository/command_repository'
require_relative 'vedeu/repository/interface_repository'
require_relative 'vedeu/repository/interface'
require_relative 'vedeu/repository/storage'

require_relative 'vedeu/application'
require_relative 'vedeu/version'

module Vedeu
  def self.logger
    @logger ||= Logger
      .new(root_path + '/logs/vedeu.log').tap do |log|
      log.formatter = proc do |mode, time, prog, msg|
        "\n#{time.iso8601}: #{msg}\n"
      end
    end
  end

  def self.root_path
    File.expand_path('../..', __FILE__)
  end
end
