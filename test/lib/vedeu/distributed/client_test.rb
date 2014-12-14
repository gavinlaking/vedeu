require 'test_helper'

module Vedeu

  module Distributed

    describe Client do

      let(:described) { Client.new(uri) }
      let(:uri) {}

      describe '.connect' do
      end

      describe '#initialize' do
        it { return_type_for(described, Client) }
        it { assigns(described, '@uri', '') }
      end

      describe '#disconnect' do
      end

    end # Client

  end # Distributed

end # Vedeu
