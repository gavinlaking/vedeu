require_relative '../../../test_helper'

module Vedeu
  module Buffer
    describe Composition do
      let(:described_class)    { Composition }
      let(:described_instance) { described_class.new(attributes) }
      let(:json)               { File.read(Vedeu.root_path + '/test/support/single_interface.json') }
      let(:attributes)         { Oj.load(json) }

      describe '#initialize' do
        let(:subject) { described_instance }

        it 'returns a Composition instance' do
          subject.must_be_instance_of(Composition)
        end

        it 'has an interface attribute' do
          subject.interface.must_be_instance_of(Array)
        end
      end

      describe '#to_compositor' do
        let(:subject) { described_instance.to_compositor }

        it 'returns a Hash' do
          subject.must_be_instance_of(Hash)
        end

        it 'returns the composition as a Compositor format' do
          subject.must_equal({"dummy"=>[[{:style=>[], :colour=>[]}, {:style=>[:normal], :colour=>[:yellow, :black], :text=>"Some text..."}]]})
        end
      end

      describe '#to_hash' do
        let(:subject) { described_instance.to_hash }

        it 'returns a Hash' do
          subject.must_be_instance_of(Hash)
        end

        it 'returns the composition as a Hash' do
          subject.must_equal({"interface"=>[{"name"=>"dummy", "line"=>[{"style"=>nil, "foreground"=>nil, "background"=>nil, "stream"=>[{"style"=>["normal"], "foreground"=>"yellow", "background"=>"black", "text"=>"Some text..."}]}]}]})
        end
      end

      describe '#to_json' do
        let(:subject) { described_instance.to_json }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns a String' do
          subject.must_equal("{\"interface\":[{\"name\":\"dummy\",\"line\":[{\"style\":null,\"foreground\":null,\"background\":null,\"stream\":[{\"style\":[\"normal\"],\"foreground\":\"yellow\",\"background\":\"black\",\"text\":\"Some text...\"}]}]}]}")
        end
      end
    end
  end
end
