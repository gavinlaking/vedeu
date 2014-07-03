#!/usr/bin/env ruby

require 'vedeu'

class SingleInterfaceApp
  include Vedeu

  interface :main, {
              y:          1,
              x:          1,
              z:          1,
              width:      :auto,
              height:     :auto,
              colour: {
                foreground: '#ffffff',
                background: '#000000',
              },
              cursor:     true
            }

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
