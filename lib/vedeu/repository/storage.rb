module Vedeu
  class Storage
    def initialize
      @map = {}
    end

    def create(record)
      map_for(record)[record.name] = record
    end

    def delete(record)
      map_for(record).delete(record.name)
    end

    def reset(entity)
      all(entity).map { |record| delete(record) }
    end

    def find(entity, name)
      map_for_class(entity).fetch(name, nil)
    end

    def all(entity)
      map_for_class(entity).values
    end

    def query(entity, attribute, value)
      return false if value.nil? || value.empty?

      map_for_class(entity).select do |_, result|
        return result if result.send(attribute) == value
      end

      nil
    end

    private

    attr_reader :map

    def map_for_class(entity)
      map[entity.to_s.to_sym] ||= {}
    end

    def map_for(record)
      map_for_class(record.class)
    end
  end
end
