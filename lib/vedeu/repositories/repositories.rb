# frozen_string_literal: true

module Vedeu

  # Provides all registered repositories.
  #
  module Repositories

    extend self

    # Access all the repositories stored.
    #
    # @return [Array]
    def all
      storage.map(&:repository)
    end

    # Register a repository with the collection of Vedeu repositories.
    #
    # @param klass [Class]
    # @return [Set]
    def register(klass)
      storage.add(klass) if klass
    end

    # List all models stored in each registered repository.
    #
    # @return [Array]
    def registered
      all.map do |repository|
        registered = repository.send(:registered)

        Vedeu.log(type:    :store,
                  message: "Repository '#{repository.class.name}':" \
                           " #{registered.inspect}")

        registered
      end
    end

    # Access all the repositories stored.
    #
    # @return [Array]
    def repositories
      self
    end

    # Remove all stored models from the repository.
    #
    # @return [Boolean]
    def reset!
      storage.map do |repository|
        Vedeu.log(type:    :red,
                  message: "Resetting: #{repository.name}")
        repository.reset!
      end

      true
    end
    alias reset reset!

    private

    # Access to the storage for this repository.
    #
    # @return [Array]
    def storage
      @_storage ||= Set.new
    end

  end # Repositories

  # @!method repositories
  #   @see Vedeu::Repositories
  def_delegators Vedeu::Repositories,
                 :repositories

end # Vedeu
