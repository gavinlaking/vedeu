#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.configure do
    log '/tmp/vedeu_views_dsl.log'
    debug!
    run_once!
    standalone!
    width 100
    height 50
  end

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.interface :test1_interface do
    background '#000066'
    foreground '#ffffff'
    border do
      title "Width: #{Vedeu.width} Height: #{Vedeu.height}"
    end
    # geometry do
    #   width 90
    #   height 40
    #   x  4
    #   y  3
    #   xn 34
    #   yn 8
    # end
  end

  Vedeu.render do
    view(:test1_interface) do
      line do
        stream '--------1---------2---------3---------4---------5'
        stream '---------6---------7---------8---------9---------0'
      end
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '10'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '20'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '30'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '40'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '50'
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start
