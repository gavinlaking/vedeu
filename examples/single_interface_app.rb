#!/usr/bin/env ruby

require 'vedeu'

class SingleInterfaceApp
  include Vedeu

  interface :main, {
              y:          1,
              x:          1,
              width:      :auto,
              height:     :auto,
              foreground: :white,
              background: :black,
              cursor:     true,
              layer:      0 }

  command   :refresh, {
              entity:    SingleInterfaceApp,
              keyword:   'refresh',
              keypress:  'r',
              arguments: [] }
  command   :exit,    {
              entity:    Vedeu::Exit,
              keyword:   'exit',
              keypress:  'q',
              arguments: [] }

  def self.start
    Vedeu::Launcher.new(ARGV.dup).execute!
  end

  def self.dispatch
    {
      'main' => [
                  [
                    {
                      :text => "The time is: #{Time.now}.",
                    }
                  ]
                ]
    }
  end
end

SingleInterfaceApp.start
