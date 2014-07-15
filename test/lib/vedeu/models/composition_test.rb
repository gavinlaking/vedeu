require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/composition'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe Composition do
    let(:described_class)    { Composition }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         { { interfaces: interfaces } }
    let(:interfaces)         {
      {
        name:   'dummy',
        width:  40,
        height: 25
      }
    }

    describe '#initialize' do
      def subject
        Composition.new(attributes)
      end

      it 'returns a Composition instance' do
        subject.must_be_instance_of(Composition)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@interfaces')
          .must_be_instance_of(Array)
      end
    end

    describe '#interfaces' do
      def subject
        Composition.new(attributes).interfaces
      end

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns a collection of interfaces' do
        subject.first.must_be_instance_of(Interface)
      end

      context 'when no interfaces are associated' do
        let(:attributes) { {} }

        it 'returns an empty collection' do
          subject.must_be_empty
        end
      end
    end

    describe '.enqueue' do
      def subject
        Composition.enqueue(composition)
      end
      let(:composition) {
        {
          interfaces: [
            { name: 'enq1', lines: { streams: { text: 'Some text...'} } },
            { name: 'enq2', lines: { streams: { text: 'Some text...'} } }
          ]
        }
      }

      before do
        InterfaceRepository.create(name: 'enq1', width: 15, height: 2)
        InterfaceRepository.create(name: 'enq2', width: 15, height: 2)
      end

      it 'returns an Composition' do
        subject.must_be_instance_of(Composition)
      end

      it 'returns a collection of interfaces' do
        subject.interfaces.first.must_be_instance_of(Interface)
      end

      it 'enqueues the interfaces for rendering' do
        subject.interfaces.first.enqueued?.must_equal(true)
      end
    end

    describe '#to_json' do
      def subject
        Composition.new(attributes).to_json
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the model as JSON' do
        #subject.must_equal("{\"interfaces\":[{\"colour\":null,\"style\":\"\",\"name\":\"dummy\",\"lines\":[{\"colour\":null,\"style\":\"\",\"model\":{},\"streams\":[{\"colour\":null,\"style\":\"\",\"text\":\"Some text...\"}]}],\"y\":1,\"x\":1,\"z\":1,\"width\":40,\"height\":25,\"current\":\"\",\"cursor\":true}]}")
        subject.must_equal("{\"interfaces\":[{\"colour\":null,\"style\":\"\",\"name\":\"dummy\",\"lines\":[],\"y\":1,\"x\":1,\"z\":1,\"width\":40,\"height\":25,\"current\":\"\",\"cursor\":true}]}")
      end
    end

    describe '#to_s' do
      def subject
        Composition.new(attributes).to_s
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'single interface, single line, single stream' do
        let(:json)       { File.read('test/support/json/int1_lin1_str1.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int1_lin1_str1', y: 3, x: 3, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...")
        end
      end

      context 'single interface, single line, multiple streams' do
        let(:json)       { File.read('test/support/json/int1_lin1_str3.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int1_lin1_str3', y: 3, x: 3, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text... more text...")
        end
      end

      context 'single interface, multiple lines, single stream' do
        let(:json)       { File.read('test/support/json/int1_lin2_str1.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int1_lin2_str1', y: 3, x: 3, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...\e[4;3HSome text...")
        end
      end

      context 'single interface, multiple lines, multiple streams' do
        let(:json)       { File.read('test/support/json/int1_lin2_str3.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int1_lin2_str3', y: 3, x: 3, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text... more text...\e[4;3HSome text... more text...")
        end
      end

      context 'single interface, multiple lines, multiple streams, streams contain styles' do
        let(:json)       { File.read('test/support/json/int1_lin2_str3_styles.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int1_lin2_str3_styles', y: 3, x: 3, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...")
        end
      end

      context 'multiple interfaces, single line, single stream' do
        let(:json)       { File.read('test/support/json/int2_lin1_str1.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int2_lin1_str1_1', y: 3, x: 3, width: 10, height: 3 })
          InterfaceRepository.create({ name: 'int2_lin1_str1_2', y: 6, x: 6, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...\e[6;6H          \e[6;6H\e[7;6H          \e[7;6H\e[8;6H          \e[8;6H\e[6;6HSome text...")
        end
      end

      context 'multiple interfaces, single line, multiple streams' do
        let(:json)       { File.read('test/support/json/int2_lin1_str3.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int2_lin1_str3_1', y: 3, x: 3, width: 10, height: 3 })
          InterfaceRepository.create({ name: 'int2_lin1_str3_2', y: 6, x: 6, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text... more text...\e[6;6H          \e[6;6H\e[7;6H          \e[7;6H\e[8;6H          \e[8;6H\e[6;6HSome text... more text...")
        end
      end

      context 'multiple interfaces, multiple lines, single stream' do
        let(:json)       { File.read('test/support/json/int2_lin2_str1.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int2_lin2_str1_1', y: 3, x: 3, width: 10, height: 3 })
          InterfaceRepository.create({ name: 'int2_lin2_str1_2', y: 6, x: 6, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...\e[4;3HSome text...\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...\e[4;3HSome text...")
        end
      end

      context 'multiple interfaces, multiple lines, multiple streams' do
        let(:json)       { File.read('test/support/json/int2_lin2_str3.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int2_lin2_str3_1', y: 3, x: 3, width: 10, height: 3 })
          InterfaceRepository.create({ name: 'int2_lin2_str3_2', y: 6, x: 6, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text... more text...\e[4;3HSome text... more text...\e[6;6H          \e[6;6H\e[7;6H          \e[7;6H\e[8;6H          \e[8;6H\e[6;6HSome text... more text...\e[7;6HSome text... more text...")
        end
      end

      context 'multiple interfaces, multiple lines, multiple streams, streams contain styles' do
        let(:json)       { File.read('test/support/json/int2_lin2_str3_styles.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        before do
          InterfaceRepository.create({ name: 'int2_lin2_str3_styles_1', y: 3, x: 3, width: 10, height: 3 })
          InterfaceRepository.create({ name: 'int2_lin2_str3_styles_2', y: 6, x: 6, width: 10, height: 3 })
        end

        it 'returns the stringified content' do
          subject.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[4;3H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[6;6H          \e[6;6H\e[7;6H          \e[7;6H\e[8;6H          \e[8;6H\e[6;6H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[7;6H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...")
        end
      end
    end
  end
end
