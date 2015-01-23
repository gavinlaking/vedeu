lib_dir = File.dirname(__FILE__) + '/../../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'simplecov'
require 'aruba'
require 'aruba/cucumber'
# require 'aruba/in_process'
require 'mocha/api'
require 'vedeu'

class CucumberError < StandardError; end

# Aruba::InProcess.main_class = Vedeu::Launcher
# Aruba.process = Aruba::InProcess
