require 'test_helper'

module Vedeu

  module API

    describe Composition do

      describe '.render' do
        it 'raises an exception when a block is not given' do
          proc { Vedeu.render }.must_raise(InvalidSyntax)
        end
      end

      describe '#view' do
        it 'returns a Hash' do
          Vedeu.view('thulium') do
            # ...
          end.must_be_instance_of(Hash)
        end

        it 'allows a single view to be defined' do
          skip
        end
      end

    end # Composition

  end # API

end # Vedeu
