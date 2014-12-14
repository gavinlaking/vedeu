require 'test_helper'

module Vedeu

  module Distributed

    describe Uri do

      let(:described) { Uri.new }

      describe '#initialize' do
        it { return_type_for(described, Uri) }
        it { assigns(described, '@host', 'druby://localhost') }
        it { assigns(described, '@port', 21420) }
      end

      describe '#host' do
        context 'when the host has been defined by the client application' do
          let(:host) { 'druby://myserver' }

          it 'returns the host' do
            Uri.new(host).host.must_equal('druby://myserver')
          end
        end

        context 'when the host has not been redefined' do
          it 'returns the default host' do
            Uri.new.host.must_equal('druby://localhost')
          end
        end
      end

      describe '#port' do
        context 'when the port has been defined by the client application' do
          let(:port) { 40000 }

          it 'returns the port' do
            Uri.new(nil, port).port.must_equal(40000)
          end
        end

        context 'when the port has not been redefined' do
          it 'returns the default port' do
            Uri.new.port.must_equal(21420)
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

  end # Distributed

end # Vedeu
