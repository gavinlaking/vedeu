#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class EditorApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/editor.log'
    renderers(Vedeu::Renderers::Terminal.new,
              Vedeu::Renderers::Text.new(filename: Dir.tmpdir + '/editor.out'))
    fake!
  end

  Vedeu.interface :editor_view do
    border do
      title 'Editor'
    end
    editable!
    geometry do
      align vertical: :top, horizontal: :left, width: 40, height: 8
    end
  end

  Vedeu.interface :help_view do
    geometry do
      height 4
      width  use(:editor_view).width
      x      use(:editor_view).left
      y      use(:editor_view).south
    end
  end

  # When pressing Escape in the editor view, the :_command_
  # event will be triggered with any typed content you have provided.
  #
  # The :_command_ event in turn triggers the :command event. Bind to
  # :command to retrieve the content entered, and then process
  # yourself in whatever way appropriate.
  #
  #     Vedeu.bind(:command) do |data|
  #        # ... do something with 'data'
  #     end
  #
  Vedeu.keymap :editor_view do
    key(:escape) { Vedeu.trigger(:_editor_execute_, :editor_view) }
    key(:enter)  { Vedeu.trigger(:_editor_insert_line_, :editor_view) }
    key(:insert) do
      Vedeu.log(type:    :debug,
                message: "Commands: #{Vedeu.all_commands.inspect}")
      Vedeu.log(type:    :debug,
                message: "Keypresses: #{Vedeu.all_keypresses.inspect}")
    end
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }
  end

  Vedeu.render do
    view(:editor_view) do
    end
  end

  Vedeu.render do
    view(:help_view) do
      lines do
        line 'Type into the editor dialog above,'
        line 'and press Escape. This will trigger the'
        line ':command event with the contents of '
        line 'the view.'

        # @todo Not implemented yet:
        #
        # text 'Type into the editor dialog above, and press Return. This will ' \
        #      'trigger the :_command_ event with the contents of the view.',
        #      name: :help_view, mode: :wrap
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # EditorApp

EditorApp.start
