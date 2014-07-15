require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/output/interface_renderer'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe InterfaceRenderer do
    let(:described_class)    { InterfaceRenderer }
    let(:described_instance) { described_class.new(interface) }
    let(:interface)          { Interface.new(attributes) }
    let(:attributes)         { { name: 'dummy', width: 20, height: 2 } }

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns an InterfaceRenderer instance' do
        subject.must_be_instance_of(InterfaceRenderer)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@interface').must_equal(interface)
      end
    end

    describe '.clear' do
      let(:subject) { described_class.clear(interface) }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the escape sequence to clear the whole interface' do
        subject.must_equal("\e[1;1H                    \e[1;1H\e[2;1H                    \e[2;1H")
      end

      context 'when the interface has colour attributes' do
        let(:attributes) { { name: 'dummy', width: 20, height: 2, colour: { foreground: '#00ff00', background: '#ffff00' } } }

        it 'returns the escape sequence to clear the whole interface' do
          subject.must_equal("\e[38;5;46m\e[48;5;226m\e[1;1H                    \e[1;1H\e[2;1H                    \e[2;1H")
        end
      end
    end

    describe '.render' do
      let(:subject)    { described_class.render(interface) }
      let(:attributes) { { name: 'dummy', width: 20, height: 2, lines: 'Some text...'} }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the content for the interface' do
        subject.must_equal("\e[1;1HSome text...")
      end
    end
  end
end
