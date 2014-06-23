require 'pry'

json = File.read('./composition.json')
hash = Yajl::Parser.parse(json)
comp = Vedeu::Composition.new(hash)
