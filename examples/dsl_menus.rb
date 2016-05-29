#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

# If you have cloned this repository from GitHub, you can run this example:
#
#     bundle exec ./examples/dsl_menus.rb
#
class DSLMenus
  include Vedeu

  Vedeu.bind(:_initialize_) {
    Vedeu.trigger(:_show_group_, :file_browser)
    Vedeu.trigger(:_refresh_group_, :file_browser)
  }

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu.log'
  end

  Vedeu.interface :files do
    border do
      title 'Files'
    end
    foreground '#ffffff'
    geometry do
      width  columns(3) - 1
      height Vedeu.height - 1
      x  1
      y  1
    end
    group :file_browser
    keymap do
      key('k', :up) do
        Vedeu.trigger(:_menu_prev_, :files)
        Vedeu.trigger(:update)
      end
      key('j', :down) do
        Vedeu.trigger(:_menu_next_, :files)
        Vedeu.trigger(:update)
      end
      key(:enter) do
        Vedeu.trigger(:_menu_select_, :files)
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
      width  Vedeu.width - (columns(3) - 1)
      height Vedeu.height - 1
      x  use(:files).east
      y  1
    end
    group :file_browser
    keymap do
      key('k', :up) do
        Vedeu.trigger(:_cursor_up_, :contents)
      end
      key('j', :down) do
        Vedeu.trigger(:_cursor_down_, :contents)
      end
    end
  end

  Vedeu.keymap '_global_' do
    key('q')        { Vedeu.exit }
    key(:shift_tab) { Vedeu.trigger(:_focus_prev_) }
    key(:tab)       { Vedeu.trigger(:_focus_next_) }
  end

  # Orchestrates the user interactions with the application.
  #
  class Controller
    def initialize(args = [])
      @args = args

      menu = Vedeu.menu(:files) { items(files) }

      Vedeu.bind :update do
        FilesView.new.show
        ContentsView.new.show
        Vedeu.trigger(:_refresh_group_, :file_browser)
      end

      FilesView.new.show
    end

    private

    attr_reader :args

    def files
      @files ||= Files.new(args).all_files
    end
  end

  # Get all the files in the current or specified directory.
  #
  class Files
    def initialize(args = [])
      @args = args
    end

    def all_files
      @_all_files ||= files.map { |file| SomeFile.new(file) }.sort_by(&:name)
    end

    private

    attr_reader :args

    def files
      @_files ||= Dir.glob(recursive).select { |file| File.file?(file) }
    end

    def recursive
      directory + '/*'
    end

    def directory
      args.first || '.'
    end
  end

  # A class to wrap a file, providing its name and contents (in the
  # form of 'data').
  #
  class SomeFile
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def name
      file.to_s
    end

    def data
      @data ||= Contents.new(file).contents
    end
  end

  # The contents of a file.
  #
  class Contents
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def contents
      File.readlines(path)
    end
  end

  # Displays a list of files from the current or specified directory.
  #
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
      @files_menu ||= Vedeu.trigger(:_menu_view_, :files)
    end
  end

  # Displays the contents of a selected file.
  #
  class ContentsView
    def show
      Vedeu.renders do
        view :contents do
          open_file.data.each do |data_line|
            line do
              text "#{data_line.chomp}"
            end
          end if open_file
        end
      end
    end

    def open_file
      @file_contents ||= Vedeu.trigger(:_menu_selected_, :files)
    end
  end

  def self.start(argv = ARGV)
    Controller.new(argv)

    Vedeu::Launcher.execute!(argv)
  end

end # DSLMenus

DSLMenus.start
