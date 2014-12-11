module Vedeu

  # Stores interface views to be later combined with interface geometry to be
  # displayed.
  #
  # @api private
  module Buffers

    include Repository
    extend self

    # Add an interface view into the back buffer. If the buffer is already
    # registered, then we preserve its front buffer. Returns the name of the
    # buffer added to storage.
    #
    # @param attributes [Hash]
    # @return [String] The name of the buffer that has been added.
    def add(attributes)
      validate_attributes!(attributes)

      name = attributes[:name]

      if registered?(name)
        Vedeu.log("Adding new content to existing buffer: '#{name}'")

        find(name).add(attributes)

      else
        Vedeu.log("Adding new buffer: '#{name}'")

        model.new({ name: name }).add(attributes)

      end

      name
    end

    private

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Buffer
    end

    # @return [Hash]
    def in_memory
      {}
    end

  end # Buffers

end # Vedeu
