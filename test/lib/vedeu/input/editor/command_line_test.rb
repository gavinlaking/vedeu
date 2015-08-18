require 'test_helper'

module Vedeu

  module Editor

  	describe CommandLine do

      let(:described)  { Vedeu::Editor::CommandLine }
      let(:instance)   { described.new(attributes) }
      let(:_name)      { 'Vedeu::Editor::CommandLine' }
      let(:text)       { '' }
      let(:x)          { 0 }
      let(:y)          { 0 }
      let(:attributes) {
        {
          name: _name,
          text: text,
          x:    x,
          y:    y,
        }
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@text').must_equal(text) }
        it { instance.instance_variable_get('@x').must_equal(x) }
        it { instance.instance_variable_get('@y').must_equal(y) }
      end

  	end # CommandLine

  end # Editor

end # Vedeu
