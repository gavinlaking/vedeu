# frozen_string_literal: true

# Ruby standard libraries
require 'base64'
require 'date'
require 'drb'
require 'erb'
require 'fileutils'
require 'forwardable'
require 'io/console'
require 'json'
require 'logger'
require 'set'
require 'singleton'
require 'thread'
require 'time'
require 'tmpdir'
require 'zlib'

# Gem dependencies
require 'thor'

# Vedeu is a GUI framework for terminal/console applications written
# in Ruby.
#
module Vedeu

  extend Forwardable
  extend self

  # @param gem_name [String]
  # @raise [Vedeu::Error::Fatal] When the required gem is not
  #   available.
  # @return [Boolean]
  def requires_gem!(gem_name)
    require gem_name if Gem::Specification.find_by_name(gem_name)

    true

  rescue Gem::LoadError
    raise Vedeu::Error::Fatal,
          "Vedeu requires '#{gem_name}' for this functionality. " \
          "Please add this to your project 'Gemfile' or '*.gemspec'."
  end

end # Vedeu

# Define some Yard macros used throughout the project.
#
# @!macro [new] defaults_method
#   The default options/attributes for a new instance of this class.
#
#   @return [Hash<Symbol => void>]
#
# @!macro [new] module_included
#   Provide additional behaviour to a class or module.
#
#   @param klass [Class]
#   @return [Class] Returns the klass parameter.
#
# @!macro [new] module_instance_methods
#   Provide additional behaviour as instance methods to the including
#   class or module.
#
# @!macro [new] module_singleton_methods
#   Provide additional behaviour as singleton methods to the including
#   class or module.
#
# @!macro [new] param_block
#   @param block [Proc]
#
# @!macro [new] param_name
#   @param name [NilClass|Symbol|String] The name of the model or
#     target model to act upon. May default to `Vedeu.focus`.
#
# @!macro [new] return_name
#   @return [NilClass|Symbol|String] The name of the model, the target
#     model or the name of the associated model.
#
# @!macro [new] border_by_name
#   Returns the named border from the borders repository.
#   @return [Vedeu::Borders::Border]
#
# @!macro [new] buffer_by_name
#   Returns the named buffer from the buffer repository.
#   @return [Vedeu::Buffers::Buffer]
#
# @!macro [new] cursor_by_name
#   Returns the named cursor from the cursors repository.
#   @return [Vedeu::Cursors::Cursor]
#
# @!macro [new] document_by_name
#   Returns the named document from the documents repository.
#   @return [Vedeu::Editor::Document]
#
# @!macro [new] geometry_by_name
#   Returns the named geometry from the geometries repository.
#   @return [Vedeu::Geometries::Geometry]

# @!macro [new] group_by_name
#   Returns the named group from the groups repository.
#   @return [Vedeu::Groups::Group]
#
# @!macro [new] interface_by_name
#   Returns the named interface/view from the interfaces repository.
#   @return [Vedeu::Interfaces::Interface]
#

require 'vedeu/all'
