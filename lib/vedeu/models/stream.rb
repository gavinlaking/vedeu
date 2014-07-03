require 'virtus'

require_relative 'presentation'
require_relative '../support/terminal'
require_relative '../support/wordwrap'

module Vedeu
  class Stream
    include Virtus.model
    include Presentation

    attribute :text,   String, default: ''

    # def to_compositor
    #   {
    #     style:  style.to_compositor,
    #     colour: colour.to_compositor,
    #     text:   text
    #   }.delete_if {|_, v| v.nil? || v.empty? }
    # end

    def to_json
      Oj.dump(attributes, mode: :compat)
    end

    def to_s(options = {})
      [colour.to_s, style.to_s, Wordwrap.this(text, options)].join
    end

    private

    def options
      {
        width: Terminal.width,
        prune: true
      }
    end
  end
end
