require_relative '../../../../test_helper'

module Vedeu
  module Buffer
    describe Parser do
      let(:described_class)    { Parser }
      let(:described_instance) { described_class.new(composition) }
      let(:subject)            { described_instance }
      let(:json)               { File.read(Vedeu.root_path + '/test/support/composition.json') }
      let(:json_as_hash)       { Oj.load(json) }
      let(:composition)        { Vedeu::Buffer::Composition.new(json_as_hash) }

      it 'returns a Parser instance' do
        subject.must_be_instance_of(Buffer::Parser)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@composition').must_equal(composition)
      end

      describe '#to_compositor' do
        let(:subject) { described_instance.to_compositor }

        it 'returns a Hash' do
          subject.must_be_instance_of(Hash)
        end

        it 'returns the composition as a Compositor format' do
          subject.must_equal({"dumb"=>[[{:style=>[:normal], :colour=>[:red, :black]}, {:style=>[:underline, :negative], :colour=>[:yellow, :black], :text=>"Some text..."}, {:style=>[:normal], :colour=>[:green, :black], :text=>"Some more text..."}], [{:style=>[], :colour=>[]}, {:style=>[], :colour=>[], :text=>"Even more text..."}]], "dumber"=>[[{:style=>[], :colour=>[]}, {:style=>[], :colour=>[], :text=>"Yet more text..."}]]})
        end
      end

      describe '#to_hash' do
        let(:subject) { described_instance.to_hash }

        it 'returns a Hash' do
          subject.must_be_instance_of(Hash)
        end

        it 'returns the composition as a Hash' do
          subject.must_equal({"interface"=>[{"name"=>"dumb", "line"=>[{"style"=>["normal"], "foreground"=>"red", "background"=>"black", "stream"=>[{"style"=>["underline", "negative"], "foreground"=>"yellow", "background"=>"black", "text"=>"Some text..."}, {"style"=>["normal"], "foreground"=>"green", "background"=>"black", "text"=>"Some more text..."}]}, {"style"=>nil, "foreground"=>nil, "background"=>nil, "stream"=>[{"style"=>nil, "foreground"=>nil, "background"=>nil, "text"=>"Even more text..."}]}]}, {"name"=>"dumber", "line"=>[{"style"=>nil, "foreground"=>nil, "background"=>nil, "stream"=>[{"style"=>nil, "foreground"=>nil, "background"=>nil, "text"=>"Yet more text..."}]}]}]})
        end
      end

      describe '#to_json' do
        let(:subject) { described_instance.to_json }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns a String' do
          subject.must_equal("{\"interface\":[{\"name\":\"dumb\",\"line\":[{\"style\":[\"normal\"],\"foreground\":\"red\",\"background\":\"black\",\"stream\":[{\"style\":[\"underline\",\"negative\"],\"foreground\":\"yellow\",\"background\":\"black\",\"text\":\"Some text...\"},{\"style\":[\"normal\"],\"foreground\":\"green\",\"background\":\"black\",\"text\":\"Some more text...\"}]},{\"style\":null,\"foreground\":null,\"background\":null,\"stream\":[{\"style\":null,\"foreground\":null,\"background\":null,\"text\":\"Even more text...\"}]}]},{\"name\":\"dumber\",\"line\":[{\"style\":null,\"foreground\":null,\"background\":null,\"stream\":[{\"style\":null,\"foreground\":null,\"background\":null,\"text\":\"Yet more text...\"}]}]}]}")
        end
      end
    end
  end
end
