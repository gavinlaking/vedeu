require 'rubygems'
require 'bundler/setup'
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
                        "text": "Some text..."
                      },
                      {
                        "text": " "
                      },
                      {
                        "colour": {
                          "foreground": "#00ff00",
                          "background": "#0000ff"
                        },
                        "text": "The time is: #{Time.now}."
                      }
                  ]
              }
          }
      }|
    end
  end

  class App
    include Vedeu

    interface 'example',  {
                            y: 1,  x: 1,  width: 80, height: 5,
                            colour: { background: '#ff0000', foreground: '#000000' },
                            cursor: false
                          }
    interface 'command',  {
                            y: 6, x: 1, width: 80, height: 1,
                            colour: { background: '#4040cc', foreground: '#aadd00' },
                            cursor: true
                          }
    command 'time', {
                      entity:   ExampleCommand,
                      keyword: 'time',
                      keypress: 't'
                    }
    command 'exit', {
                      entity:   Vedeu::Exit,
                      keyword: 'exit',
                      keypress: 'q'
                    }

    def self.start
      Vedeu::Launcher.new([]).execute!
    end
  end
end
