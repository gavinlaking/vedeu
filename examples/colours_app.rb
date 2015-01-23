#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuColoursApp
  include Vedeu

  configure do
    debug!
    log '/tmp/vedeu_colours_app.log'
  end

  bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'colours' do
    border do
    end
    geometry do
      centre
      height 8
      width  8
    end
    colour foreground: '#000000', background: '#000000'
  end

  renders do
    view('colours') do
      lines do

      end
    end
  end

end
