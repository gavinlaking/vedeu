#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

# If you have cloned this repository from GitHub, you can run this example:
#
#     bundle exec ./examples/demo_groups.rb
#
class FileBrowser
  include Vedeu

  Vedeu.bind(:_initialize_) {
    Vedeu.trigger(:_show_group_, :file_browser)
    Vedeu.trigger(:_refresh_group_, :file_browser)
  }

  Vedeu.configure do
    log '/tmp/file_browser.log'
  end

  Vedeu.interface :files do
    border do
      title 'Files'
    end
    foreground '#ffffff'
    geometry do
      width  (Vedeu.width / 2) - 1
      height Vedeu.height - 1
      x  1
      y  1
    end
    group :file_browser
    keymap do
      key('k', :up) do
        Vedeu.trigger(:_menu_prev_, :files)
        Vedeu.trigger(:_refresh_view_, :files)
        Vedeu.trigger(:update)
      end
      key('j', :down) do
        Vedeu.trigger(:_menu_next_, :files)
        Vedeu.trigger(:_refresh_view_, :files)
        Vedeu.trigger(:update)
      end
    end
  end

  Vedeu.interface :contents do
    border do
      title 'Contents'
    end
    foreground '#ffffff'
    geometry do
      width  (Vedeu.width / 2) - 1
      height Vedeu.height - 1
      x  use(:files).east
      y  1
    end
    group :file_browser
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }
  end

  class Controller
    require 'pry'

    def initialize(args = [])
      @args = args

      menu = Vedeu.menu(:files) { items(files) }

      Vedeu.bind :update do
        FilesView.new.show

        # Vedeu.trigger(:_refresh_view_, :file)
      end

      #Vedeu.log(type: :debug, message: "#{__callee__} \e[32m#{menu.items.inspect}\e[39m")

      #Vedeu.log(type: :debug, message: "#{__callee__} #{files.pretty_inspect}")



      FilesView.new.show
    end

    private

    attr_reader :args

    def files
      @files ||= Files.new(args).all_files
    end
  end

  class Files
    def initialize(args = [])
      @args = args
    end

    def all_files
      files.map { |file| SomeFile.new(file) }
    end

    def files
      @_files ||= Dir.glob(recursive).select { |file| File.file?(file) }
    end

    private

    attr_reader :args

    def recursive
      directory + '/*'#**/*'
    end

    def directory
      args.first || '.'
    end
  end

  class SomeFile
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def name
      file.to_s
    end
  end

  class Contents
    def initialize(path)
      @path = path
    end

    def contents
      File.readlines(path)
    end
  end

  class FilesView
    def show
      Vedeu.renders do
        view :files do
          files_menu.each do |sel, cur, item|
            if sel && cur
              line do
                stream do
                  text "\u{25B6}> #{item.name}"
                end
              end

            elsif cur
              line do
                stream do
                  text " > #{item.name}"
                end
              end

            elsif sel
              line do
                stream do
                  text "\u{25B6}  #{item.name}"
                end
              end

            else
               line do
                 stream do
                   text "   #{item.name}"
                 end
               end
            end
          end
        end
      end
    end

    def files_menu
      @files_menu = Vedeu.trigger(:_menu_view_, :files)
    end
  end

  class ContentsView
    def show
      Vedeu.renders do
        view :contents do
          lines do
            line
          end
        end
      end
    end

    def open_file
    end
  end

  def self.start(argv = ARGV)
    Controller.new(argv)

    Vedeu::Launcher.execute!(argv)
  end

end # FileBrowser

FileBrowser.start
