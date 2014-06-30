require 'date'
require 'logger'
require 'io/console'
require 'oj'
require 'optparse'
require 'virtus'

require_relative 'vedeu/input/input'

require_relative 'vedeu/support/events'
require_relative 'vedeu/support/exit'
require_relative 'vedeu/support/json_parser'
require_relative 'vedeu/support/queue'
require_relative 'vedeu/support/terminal'

require_relative 'vedeu/models/style'
require_relative 'vedeu/models/formatting'
require_relative 'vedeu/models/stream'
require_relative 'vedeu/models/line'
require_relative 'vedeu/models/interface'
require_relative 'vedeu/models/composition'
require_relative 'vedeu/models/geometry'

require_relative 'vedeu/output/base'
require_relative 'vedeu/output/background'
require_relative 'vedeu/output/compositor'
require_relative 'vedeu/output/cursor'
require_relative 'vedeu/output/directive'
require_relative 'vedeu/output/foreground'

require_relative 'vedeu/output/menu'
require_relative 'vedeu/output/esc'
require_relative 'vedeu/output/colour'
require_relative 'vedeu/output/output'
require_relative 'vedeu/output/position'
require_relative 'vedeu/output/style'
require_relative 'vedeu/output/translator'
require_relative 'vedeu/output/wordwrap'

require_relative 'vedeu/process/process'

require_relative 'vedeu/repository/repository'
require_relative 'vedeu/repository/command_repository'
require_relative 'vedeu/repository/command'
require_relative 'vedeu/repository/interface_repository'
require_relative 'vedeu/repository/interface'
require_relative 'vedeu/repository/storage'
require_relative 'vedeu/repository/dummy_interface'
require_relative 'vedeu/repository/dummy_command'

require_relative 'vedeu/application'
require_relative 'vedeu/configuration'
require_relative 'vedeu/launcher'
require_relative 'vedeu/version'

module Vedeu
  # :nocov:
  def self.logger
    @logger ||= Logger.new(root_path + '/logs/vedeu.log').tap do |log|
      log.formatter = proc do |_, time, _, msg|
        "\n#{time.iso8601}: #{msg}\n"
      end
    end
  end

  def self.debug(filename = 'profile.html', &block)
    RubyProf.start

    yield

    result = RubyProf.stop
    result.eliminate_methods!([/^Array/, /^Hash/])

    File.open(Vedeu.root_path + '/tmp/' + filename, 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end
  end

  def self.included(receiver)
    receiver.extend(ClassMethods)
  end
  # :nocov:

  private

  # :nocov:
  def self.root_path
    File.expand_path('../..', __FILE__)
  end
  # :nocov:
end
