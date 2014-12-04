require 'test_helper'

module Vedeu

  module Distributed

    describe Uri do
      let(:host) {}
      let(:port) {}

      describe '#initialize' do
        it 'returns an instance of itself' do
          Uri.new(host, port).must_be_instance_of(Uri)
        end
      end

      describe '#host' do
        context 'when the host has been defined by the client application' do
          let(:host) { 'druby://myserver' }

          it 'returns the host' do
            Uri.new(host, port).host.must_equal('druby://myserver')
          end
        end

        context 'when the host has not been redefined' do
          it 'returns the default host' do
            Uri.new(host, port).host.must_equal('druby://localhost')
          end
        end
      end

      describe '#port' do
        context 'when the port has been defined by the client application' do
          let(:port) { 40000 }

          it 'returns the port' do
            Uri.new(host, port).port.must_equal(40000)
          end
        end

        context 'when the port has not been redefined' do
          it 'returns the default port' do
            Uri.new(host, port).port.must_equal(21420)
          end
        end
      end

      describe '#to_s' do
        let(:host) { 'druby://myserver' }
        let(:port) { 40000 }

        it 'returns a single value for the uri' do
          Uri.new(host, port).to_s.must_equal('druby://myserver:40000')
        end
      end
    end # Uri

    describe Server do
      let(:uri)     {}
      let(:service) {}

      describe '#initialize' do
        it 'returns an instance of itself' do
          Server.new(uri, service).must_be_instance_of(Server)
        end
      end

      describe '#' do
      end

    end # Server

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
