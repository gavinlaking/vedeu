require 'test_helper'

module Vedeu

  module Distributed

    describe Server do

      let(:described) { Server.new(uri, service) }
      let(:uri)     {}
      let(:service) {}

      describe '#initialize' do
        it { return_type_for(described, Server) }
        it { assigns(described, '@uri', uri) }
        it { assigns(described, '@service', service) }
      end

      describe '#start' do
      end

      describe '#stop' do
      end

    end # Server

  end # Distributed

end # Vedeu
