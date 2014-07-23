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

  class MenuCommand
    def self.dispatch
      @command ||= new
      @command.dispatch
    end

    def initialize; end

    def dispatch
      Vedeu::Parser.parse({ 'example' => render })
    end

    def render
      menu.render.map { |item| "#{item}\n" }
    end

    def menu
      @_menu ||= Vedeu::Menu.new(['hydrogen', 'carbon', 'nitrogen', 'oxygen'])
    end
  end

  class App
    include Vedeu

    # assign the interface to a variable so that you can use it as a
    # reference in another interface.
    example = interface 'example' do
      colour  foreground: '#ff0000', background: '#000000'
      cursor  false
      width   40
      height  5
      centred true
    end

    # y and x come from the interface above, ensuring that 'command'
    # is positioned under 'example' (see 'y')
    interface 'command' do
      colour  foreground: '#aadd00', background: '#4040cc'
      cursor  true
      width   40
      height  1
      y       example.geometry.bottom
      x       example.geometry.left
      centred false
    end

    command 'time' do
      entity   ExampleCommand
      keyword  'time'
      keypress 't'
    end

    # command 'menu' do
    #   entity   MenuCommand
    #   keyword  'menu'
    #   keypress 'm'
    # end

    command 'exit' do
      entity   Vedeu::Exit
      keyword  'exit'
      keypress 'q'
    end

    event :show_menu do
      MenuCommand.dispatch

      # Vedeu::Output.render
    end

    event :key do |key|
      case key
      when "v"        then puts "v was pressed."
      when :f1        then puts "F1 was pressed."
      when :f2        then run(:some_event, [:args, :go, :here])
      when "x"        then run(:_exit_)

      when :up then
        run(:menu_prev)
        run(:menu_render)
        run(:show_menu)
        run(:refresh)

      when :down then
        run(:menu_next)
        run(:menu_render)
        run(:show_menu)
        run(:refresh)

      when :page_up then
        run(:menu_top)
        run(:menu_render)
        run(:show_menu)
        run(:refresh)

      when :page_down then
        run(:menu_bottom)
        run(:menu_render)
        run(:show_menu)
        run(:refresh)

      when :enter then
        run(:menu_select)
        run(:app_select_item, m)
        run(:menu_render)
        run(:show_menu)
        run(:refresh)

      when :backspace then
        run(:menu_deselect)
        run(:menu_render)
        run(:show_menu)
        run(:refresh)

      when "r" then
        run(:menu_render)
        run(:show_menu)
        run(:refresh)

      when "m" then
        run(:show_menu)
        run(:refresh)

      else
      end
    end

    def self.start(args = [])
      Vedeu::Launcher.new(args).execute!
    end
  end
end
