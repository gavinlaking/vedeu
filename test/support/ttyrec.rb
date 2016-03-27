#!/usr/bin/env ruby

# frozen_string_literal: true

#
#     ttyrec -a -e ./material_colours_app.rb /tmp/ttyrecord
#

ttyrecord = File.binread(Dir.tmpdir + '/ttyrecord')
ttyrecord.force_encoding('BINARY') if ttyrecord.respond_to?(:force_encoding)

offset = 0
chunks = []

while offset < ttyrecord.size
  hash = {}

  data_start  = offset + 12
  data_length = ttyrecord[offset..(data_start)].unpack('VVV')[2]
  data_end    = data_start + data_length

  hash[:offset]       = offset
  hash[:data_start]   = data_start
  hash[:data_length]  = data_length
  hash[:data]         = ttyrecord[(data_start)...(data_end)]
  hash[:data_end]     = data_end

  chunks << hash

  offset = data_start + data_length
end

File.open(Dir.tmpdir + '/ttyrecord_decoded', 'w') do |file|
  chunks.each do |chunk|
    file.write("---\n" + chunk[:data] + "\n")
  end
end
