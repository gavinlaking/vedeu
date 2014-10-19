require 'test_helper'

module Vedeu
  module API
    describe Composition do

      describe '.render' do
        it 'directly writes a view buffer to the terminal' do
          skip
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

    end
  end
end
