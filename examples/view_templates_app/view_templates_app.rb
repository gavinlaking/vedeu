#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate templates.
class VedeuViewTemplateApp

  include Vedeu

  configure do
    debug!
    log '/tmp/vedeu_view_templates_app.log'
  end

  bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'default' do
    colour foreground: '#ff0000', background: '#000000'
    cursor!
  end

  interface 'prune' do
    colour foreground: '#00ff00', background: '#000000'
    cursor!
  end

  interface 'wrap' do
    colour foreground: '#0000ff', background: '#000000'
    cursor!
  end

  keymap('_global_') do
    key(:up,    'k') { Vedeu.trigger(:_cursor_up_)    }
    key(:right, 'l') { Vedeu.trigger(:_cursor_right_) }
    key(:down,  'j') { Vedeu.trigger(:_cursor_down_)  }
    key(:left,  'h') { Vedeu.trigger(:_cursor_left_)  }
  end

  border('default') do
    colour foreground: '#aadd00', background: '#000000'
  end
  border('prune') do
    colour foreground: '#00aadd', background: '#000000'
  end
  border('wrap') do
    colour foreground: '#dd00aa', background: '#000000'
  end

  geometry('prune') do
    centred!
    height 6
    width  25
  end

  geometry 'default' do
    height 6
    width  25
    x      use('prune').left
    y      use('prune').north(7)
  end

  geometry 'wrap' do
    height 6
    width  25
    x      use('prune').left
    y      use('prune').south(1)
  end

  def self.default_template
    File.dirname(__FILE__) + '/default.erb'
  end
  def self.prune_template
    File.dirname(__FILE__) + '/prune.erb'
  end
  def self.wrap_template
    File.dirname(__FILE__) + '/wrap.erb'
  end

  renders do
    template_for('default', default_template, nil)
    template_for('prune', prune_template, nil, { mode: :prune, width: 22 })
    template_for('wrap', wrap_template, nil, { mode: :wrap, width: 25 })
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end

VedeuViewTemplateApp.start(ARGV)
