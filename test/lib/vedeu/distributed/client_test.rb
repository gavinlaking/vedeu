require 'test_helper'

module Vedeu

  module Distributed

    describe Client do
      let(:uri) {}

      describe '#initialize' do
        it 'returns an instance of itself' do
          Client.new(uri).must_be_instance_of(Client)
        end
      end

      describe '#' do
      end

    end # Client

  end # Distributed

end # Vedeu
