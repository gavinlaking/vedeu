require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/composition'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe Composition do
    let(:described_class)    { Composition }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         { { interfaces: interfaces } }
    let(:interfaces)         { { name: 'dummy' } }

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns a Composition instance' do
        subject.must_be_instance_of(Composition)
      end
    end

    describe '#enqueue' do
      let(:subject) { described_instance.enqueue }

      it 'creates a composition and enqueues the interface for rendering' do
        skip
      end
    end

    describe '#to_json' do
      let(:subject) { described_instance.to_json }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end
    end

    describe '#to_s' do
      let(:subject) { described_instance.to_s }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'single interface, single line, single stream' do
        let(:json)       { File.read('test/support/json/int1_lin1_str1.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        it 'returns the stringified content' do
          subject.must_equal("\e[1;1HSome text...")
        end
      end

      context 'single interface, single line, multiple streams' do
        let(:json)       { File.read('test/support/json/int1_lin1_str3.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        it 'returns the stringified content' do
          subject.must_equal("\e[1;1HSome text... more text...")
        end
      end

      context 'single interface, multiple lines, single stream' do
        let(:json)       { File.read('test/support/json/int1_lin2_str1.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        it 'returns the stringified content' do
          subject.must_equal("\e[1;1HSome text...\e[2;1HSome text...")
        end
      end

      context 'single interface, multiple lines, multiple streams' do
        let(:json)       { File.read('test/support/json/int1_lin2_str3.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        it 'returns the stringified content' do
          subject.must_equal("\e[1;1HSome text... more text...\e[2;1HSome text... more text...")
        end
      end

      context 'single interface, multiple lines, multiple streams, streams contain styles' do
        let(:json)       { File.read('test/support/json/int1_lin2_str3_styles.json') }
        let(:attributes) { Oj.load(json, symbol_keys: true) }

        it 'returns the stringified content' do
          subject.must_equal("\e[1;1H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...")
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
          subject.must_equal("\e[3;3HSome text...\e[6;6HSome text...")
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
          subject.must_equal("\e[3;3HSome text... more text...\e[6;6HSome text... more text...")
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
          subject.must_equal("\e[3;3HSome text...\e[4;3HSome text...\e[3;3HSome text...\e[4;3HSome text...")
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
          subject.must_equal("\e[3;3HSome text... more text...\e[4;3HSome text... more text...\e[6;6HSome text... more text...\e[7;6HSome text... more text...")
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
          subject.must_equal("\e[3;3H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[4;3H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[6;6H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[7;6H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...")
        end
      end
    end
  end
end
