#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate colours.
#
class VedeuColoursApp
  include Vedeu

  configure do
    colour_mode 16_777_216
    debug!
    log '/tmp/vedeu_colours_app.log'
  end

  bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'colours' do
    geometry do
      centred!
      height 8
      width  8
    end
    colour foreground: '#000000', background: '#000000'
  end

  renders do
    view('colours') do
      border!
      lines do

      end
    end
  end

end
