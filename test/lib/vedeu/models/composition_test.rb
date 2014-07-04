require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/composition'

module Vedeu
  describe Composition do
    let(:described_class)    { Composition }
    let(:described_instance) { described_class.new(attributes) }
    let(:json)               { File.read('test/support/output_1.json') }
    let(:attributes)         { Oj.load(json) }

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns a Composition instance' do
        subject.must_be_instance_of(Composition)
      end
    end

    describe '#interfaces' do
      let(:subject) { described_instance.interfaces }

      it 'has an interfaces attribute' do
        subject.must_be_instance_of(Array)
      end
    end

    # describe '#to_json' do
    #   let(:subject) { described_instance.to_json }

    #   it 'returns a String' do
    #     subject.must_be_instance_of(String)
    #   end

    #   it 'returns a String' do
    #     subject.must_equal("{\"interface\":[{\"name\":\"dummy\",\"line\":[{\"colour\":null,\"stream\":[{\"colour\":{\"foreground\":\"#ffff00\",\"background\":\"#000000\"},\"style\":{\"value\":[\"normal\"]},\"text\":\"Some text...\"}],\"style\":null}],\"colour\":null,\"y\":1,\"x\":1,\"z\":1,\"width\":119,\"height\":34}]}")
    #   end
    # end

    # describe '#to_s' do
    #   let(:subject) { described_instance.to_s }

    #   it 'returns a String' do
    #     subject.must_be_instance_of(String)
    #   end

    #   it 'returns a String' do
    #     subject.must_equal("\e[24m\e[21m\e[27m\e[38;5;226m\e[48;5;16mSome text...")
    #   end
    # end
  end
end
