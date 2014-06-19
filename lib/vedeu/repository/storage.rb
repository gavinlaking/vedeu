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

    def reset(klass)
      all(klass).map { |record| delete(record) }
    end

    def find(klass, name)
      map_for_class(klass).fetch(name, nil)
    end

    def all(klass)
      map_for_class(klass).values
    end

    def query(klass, attribute, value)
      map_for_class(klass).select do |_, result|
        return result if result.send(attribute) == value
      end

      nil
    end

    private

    def map_for_class(klass)
      @map[klass.to_s.to_sym] ||= {}
    end

    def map_for(record)
      map_for_class(record.class)
    end
  end
end
