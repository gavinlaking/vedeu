module Vedeu

  # Renders a {Vedeu::VirtualBuffer} or {Vedeu::Output} as JSON.
  #
  class JSONRenderer

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(output)
      new(output).render
    end

    # @param output [Array<Array<Vedeu::Char>>]
    # @param path [String]
    # @return [String]
    # def self.to_file(output, path = nil)
    #   new(output).to_file(path)
    # end

    # Returns a new instance of Vedeu::JSONRenderer.
    #
    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::JSONRenderer]
    def initialize(output)
      @output = output
    end

    # @return [String]
    def render
      return '' if output.nil? || output.empty?

      out = ''
      Array(output).each do |line|
        out << ""
        line.each do |char|
          out << char.to_json
          out << "\n"
        end
        out << "\n"
      end
      out
    end

    private

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

  end # JSONRenderer

end # Vedeu
