#!/usr/bin/env ruby

# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

# Find out which projects are currently using Vedeu:
# (from: http://www.schneems.com/blogs/2015-09-30-reverse-rubygems/)

gem_name = 'vedeu'

def rubygems_get(gem_name: '', endpoint: '')
  path = File.join('/api/v1/gems/', gem_name, endpoint).chomp('/') + '.json'
  uri  = URI('https://rubygems.org' + path)
  opts = { use_ssl: true }

  response = Net::HTTP.start(uri.host, uri.port, opts) do |http|
    http.request(Net::HTTP::Get.new(uri))
  end

  JSON.parse(response.body)
end

results = rubygems_get(gem_name: gem_name, endpoint: 'reverse_dependencies')

weighted_results = {}
results.each do |name|
  begin
    weighted_results[name] = rubygems_get(gem_name: name)["downloads"]
  rescue => e
    puts "#{name} #{e.message}"
  end
end

weighted_results.sort { |(k1, v1), (k2, v2)| v2 <=> v1 }.first(50).
  each_with_index { |(k, v), i| puts "#{i}) #{k}: #{v}" }
