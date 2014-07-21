require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'vedeu'

module Example
  extend self

  class ExampleCommand
    def self.dispatch
      %Q|{
          "interfaces": {
              "name": "example",
              "lines": {
                  "streams": [
                      {
                        "colour": {
                          "foreground": "#00ff00",
                          "background": "#0000ff"
                        },
                        "text": "The time is: #{Time.now}. "
                      }
                  ]
              }
          }
      }|
    end
  end

  class App
    include Vedeu

    def self.example_position
      @_position = Vedeu::Coordinate.new({
        width:    40,
        height:   2,
        centered: true
      }).position
    end

    def self.command_position
      {
        y:        example_position[:bottom],
        x:        example_position[:x],
        height:   1,
        width:    40,
        centered: true
      }
    end

    interface 'example',  {
                            colour: {
                              background: '#ff0000',
                              foreground: '#000000'
                            },
                            cursor: false
                          }.merge(example_position)
    interface 'command',  {
                            colour: {
                              background: '#4040cc',
                              foreground: '#aadd00'
                            },
                            cursor: true
                          }.merge(command_position)
    command 'time', {
                      entity:   ExampleCommand,
                      keyword:  'time',
                      keypress: 't'
                    }
    command 'exit', {
                      entity:   Vedeu::Exit,
                      keyword:  'exit',
                      keypress: 'q'
                    }

    event :key do |key|
      case key
      when 'v' then puts "v was pressed."
      when :f1 then puts "F1 was pressed."
      when :f2 then run(:some_event, [:args, :go, :here])
      when 'x' then run(:_exit_)
      else
      end
    end

    def self.start
      Vedeu::Launcher.new([]).execute!
    end
  end
end
