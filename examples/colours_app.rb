#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate colours.
#
class VedeuColoursApp

  include Vedeu

  configure do
    debug!
    log '/tmp/vedeu_colours_app.log'
  end

  interface 'colours_256' do
    geometry do
      centred!
      height 16
      width  80
    end
  end

  renders do
    view('colours_256') do
      lines do
        0.upto(16) do |row|
          line do
            0.upto(15) do |column|
              code = (row * 15) + column
              right "#{code}", width: 5, background: code, foreground: '#ffffff'
            end
          end
        end
      end
    end
  end

end
