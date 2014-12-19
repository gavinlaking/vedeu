require 'test_helper'

module Vedeu

  module API

    describe Composition do

      describe '.render' do
        context 'when a block was not given' do
          it { proc { Vedeu.render }.must_raise(InvalidSyntax) }
        end
      end

      describe '#view' do
        it 'returns a Hash' do
          Vedeu.view('thulium') do
            # ...
          end.must_be_instance_of(Hash)
        end
      end

    end # Composition

  end # API

end # Vedeu
