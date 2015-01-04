module Vedeu

  # Stores interface views to be later combined with interface geometry to be
  # displayed.
  #
  # @api private
  class Buffers < Repository

    def initialize(model = Vedeu::Buffer, storage = {})
      super
    end

    # Add an interface view into the back buffer. If the buffer is already
    # registered, then we preserve its front buffer. Returns the name of the
    # buffer added to storage.
    #
    # @param attributes [Hash]
    # @return [Boolean] The name of the buffer that has been added.
    def add_content(attributes)
      name = attributes[:name]

      if registered?(name)
        Vedeu.log("Adding new content to existing buffer: '#{name}'")

        find(name).add(attributes)

      else
        Vedeu.log("Adding new buffer: '#{name}'")

        model.new({ name: name }).add(attributes)

      end
    end

    private

  end # Buffers

end # Vedeu
