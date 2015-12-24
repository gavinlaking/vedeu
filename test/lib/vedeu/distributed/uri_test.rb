require 'test_helper'

module Vedeu

  module Distributed

    describe Uri do

      let(:described) { Vedeu::Distributed::Uri }
      let(:instance)  { described.new(host, port) }
      let(:host)      {}
      let(:port)      {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@host').must_equal('localhost') }
        it { instance.instance_variable_get('@port').must_equal(21_420) }
      end

      describe '#host' do
        subject { instance.host }

        context 'when the host has been defined by the client application' do
          let(:host) { 'myserver' }

          it 'returns the host' do
            subject.must_equal('myserver')
          end
        end

        context 'when the host has not been redefined' do
          it 'returns the default host' do
            subject.must_equal('localhost')
          end
        end
      end

      describe '#port' do
        subject { instance.port }

        context 'when the port has been defined by the client application' do
          let(:port) { 40_000 }

          it 'returns the port' do
            subject.must_equal(40_000)
          end
        end

        context 'when the port has not been redefined' do
          it 'returns the default port' do
            subject.must_equal(21_420)
          end
        end
      end

      describe '#to_s' do
        let(:host) { 'myserver' }
        let(:port) { 40_000 }

        subject { instance.to_s }

        it 'returns a single value for the uri' do
          subject.must_equal('druby://myserver:40000')
        end
      end

      describe '#to_str' do
        it { instance.must_respond_to(:to_str) }
      end

    end # Uri

  end # Distributed

end # Vedeu
