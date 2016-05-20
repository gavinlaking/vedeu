#!/usr/bin/env ruby

# frozen_string_literal: true

# Install 'ttyrec':
#   sudo apt install ttyrec
#
# Run 'ttyrec' against an example:
#   ttyrec -a -e ./examples/material_colours_app.rb /tmp/ttyrecord
#
# Parse the recording:
#   ./ttyrec.rb
#
# View the decoded recording:
#   less /tmp/ttyrecord_decoded
#
# or
#   cat /tmp/ttyrecord_decoded
#

require 'tmpdir'

tmpdir    = Dir.tmpdir
ttyrecord = File.binread(tmpdir + '/ttyrecord')
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

File.open(tmpdir + '/ttyrecord_decoded', 'w') do |file|
  chunks.each do |chunk|
    file.write("---\n" + chunk[:data] + "\n")
  end
end
