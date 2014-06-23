require_relative '../../../../test_helper'

module Vedeu
  module Buffer
    describe Parser do
      let(:described_class)    { Parser }
      let(:described_instance) { described_class.new(composition) }
      let(:subject)            { described_instance }
      let(:composition)        {
        json = File.read(Vedeu.root_path + '/test/support/composition.json')
        hash = Yajl::Parser.parse(json)
        Vedeu::Buffer::Composition.new(hash)
      }

      it 'returns a Parser instance' do
        subject.must_be_instance_of(Buffer::Parser)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@composition').must_equal(composition)
      end

      describe '#parse' do
        let(:subject) { described_instance.parse }

        it { subject.must_equal('test') }
      end
    end
  end
end
