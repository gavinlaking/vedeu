require_relative 'vedeu/instrumentation'

require_relative 'vedeu/support/builder'
require_relative 'vedeu/support/events'
require_relative 'vedeu/support/geometry'
require_relative 'vedeu/support/menu'
require_relative 'vedeu/launcher'

module Vedeu
  # :nocov:

  Vedeu::Instrumentation::Trace.call

  # :nocov:
  module ClassMethods
    def interface(name, &block)
      Builder.build(name, &block)
    end

    def event(name, &block)
      Vedeu.events.on(name, &block)
    end
    alias_method :on, :event

    def run(name, *args)
      Vedeu.events.trigger(name, *args)
    end
    alias_method :trigger, :run
  end

  def self.events
    @events ||= Events.new do
      on(:_exit_)        { fail StopIteration }
      on(:_log_)         { |message| Vedeu.log(message) }
      on(:_mode_switch_) { fail ModeSwitch    }

      on(:_keypress_) do |key|
        trigger(:key, key)
        trigger(:_log_, (' ' * 42) + "key: #{key}")
        trigger(:_mode_switch_) if key == :escape
      end
    end
  end

  def self.log(message)
    Vedeu::Instrumentation::Log.logger.debug(message)
  end

  def self.included(receiver)
    receiver.send(:include, ClassMethods)
    receiver.extend(ClassMethods)
  end

  extend ClassMethods

  private

  def self.root_path
    File.expand_path('../..', __FILE__)
  end
  # :nocov:
end

# require 'vedeu/input/input'

# require 'vedeu/models/attributes/collection'
# require 'vedeu/models/attributes/interface_collection'
# require 'vedeu/models/attributes/line_collection'
# require 'vedeu/models/attributes/stream_collection'

# require 'vedeu/models/builders/builder'
# require 'vedeu/models/builders/interface_builder'

# require 'vedeu/models/colour'
# require 'vedeu/models/composition'
# require 'vedeu/models/interface'
# require 'vedeu/models/line'
# require 'vedeu/models/presentation'
# require 'vedeu/models/stream'
# require 'vedeu/models/style'

# require 'vedeu/output/clear_interface'
# require 'vedeu/output/render_interface'
# require 'vedeu/output/template'

# require 'vedeu/parsing/hash_parser'
# require 'vedeu/parsing/json_parser'
# require 'vedeu/parsing/parser'
# require 'vedeu/parsing/text_adaptor'

# require 'vedeu/parsing/compositor'
# require 'vedeu/support/esc'
# require 'vedeu/support/events'
# require 'vedeu/support/exit'
# require 'vedeu/support/geometry'
# require 'vedeu/support/menu'
# require 'vedeu/support/persistence'
# require 'vedeu/support/queue'
# require 'vedeu/support/terminal'
# require 'vedeu/support/translator'
# require 'vedeu/support/wordwrap'

# require 'vedeu/application'
# require 'vedeu/configuration'
# require 'vedeu/launcher'
