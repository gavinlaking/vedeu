require_relative 'storage'

module Vedeu
  module Repository
    def adaptor
      @adaptor ||= Storage.new
    end

    def find(name)
      adaptor.find(entity, name)
    end

    def all
      adaptor.all(entity)
    end

    def query(entity, attribute, value)
      adaptor.query(entity, attribute, value)
    end

    def create(model)
      adaptor.create(model)
    end

    def delete(model)
      adaptor.delete(model)
    end

    def reset
      adaptor.reset(entity)
    end
  end
end
