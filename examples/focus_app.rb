#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

# This example application shows how interface focus works.
#
# First, we set up the interfaces, noting that 'copper' should have focus when
# the application starts. Also note that 'status' should not show a cursor.
#
# The focus order is: copper, aluminium, boron, dubnium, status.
#
# Use 'space' to change focus.
class VedeuFocusApp
  include Vedeu

  event(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'aluminium' do
    colour  foreground: '#ffffff', background: '#330000'
    cursor  true
    height  2
    width   2
    x       3
    y       3
  end

  interface 'boron' do
    colour  foreground: '#ffffff', background: '#003300'
    cursor  true
    height  2
    width   2
    x       6
    y       3
  end

  interface 'copper' do
    colour  foreground: '#ffffff', background: '#000033'
    cursor  true
    focus!
    height  2
    width   2
    x       3
    y       6
  end

  interface 'dubnium' do
    colour  foreground: '#ffffff', background: '#333300'
    cursor  true
    height  2
    width   2
    x       6
    y       6
  end

  interface 'status' do
    colour  foreground: '#ffffff', background: '#000000'
    cursor  false
    height  2
    width   10
    x       9
    y       3
  end

  render do
    view('aluminium') { line 'Al' }
    view('boron')     { line 'B' }
    view('copper')    { line 'Cu' }
    view('dubnium')   { line 'Db' }
    view('status')    { line Vedeu::Focus.current }

    # Tell Vedeu that each interface can use 'space'.
    keys('aluminium', 'boron', 'copper', 'dubnium', 'status') do
      key(' ') do
        Vedeu::Focus.next_item

        render { view('status') { line Vedeu::Focus.current } }
      end
    end
  end

  def self.start
    Vedeu::Launcher.new(['--debug']).execute!
  end
end

VedeuFocusApp.start
