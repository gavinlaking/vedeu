require 'simplecov'
require 'aruba'
require 'aruba/cucumber'
require 'aruba/in_process'
require 'mocha/api'

require_relative '../../lib/vedeu.rb'

class CucumberError < StandardError; end

Aruba::InProcess.main_class = Vedeu::Launcher
Aruba.process = Aruba::InProcess
