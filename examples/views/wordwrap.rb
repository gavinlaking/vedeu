#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu.log'
    run_once!
    standalone!
  end

  Vedeu.interface :test1_interface do
    geometry do
      x  1
      y  1
      xn 80
      yn 40
    end
    zindex 1
  end

  Vedeu.interface :test2_interface do
    border do
      title 'Test 2'
    end
    geometry do
      x  2
      y  2
      xn 79
      yn 39
    end
    zindex 2
  end

  Vedeu.render do
    view(:test1_interface) do
      lines do
        line do
          stream '0--------1---------2---------3---------4---------5'
          stream '---------6---------7---------8---------9'
        end
        line '|'; line '|'; line '|'; line '|';
        line '|'; line '|'; line '|'; line '|'; line '1';
        line '|'; line '|'; line '|'; line '|'; line '|'
        line '|'; line '|'; line '|'; line '|'; line '2'
        line '|'; line '|'; line '|'; line '|'; line '|'
        line '|'; line '|'; line '|'; line '|'; line '3'
        line '|'; line '|'; line '|'; line '|'; line '|'
        line '|'; line '|'; line '|'; line '|'; line '4'
        line '|'; line '|'; line '|'; line '|'; line '|'
        line '|'; line '|'; line '|'; line '|'; line '5'
      end
    end
    view(:test2_interface) do
      line(File.read(File.dirname(__FILE__) + '/wordwrap.txt'), wordwrap: true)
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start
