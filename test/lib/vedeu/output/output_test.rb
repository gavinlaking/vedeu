require_relative '../../../test_helper'

module Vedeu
  describe Output do
    let(:described_class) { Output }
    let(:subject)         { described_class.new }
    let(:output)          {}

    before do
      InterfaceRepository.create({ name: 'dummy', width: 15, height: 2, cursor: true })
      Terminal.stubs(:output).returns(output)
    end

    after { InterfaceRepository.reset }

    it 'returns an Output instance' do
      subject.must_be_instance_of(Output)
    end

    describe '.render' do
      let(:subject) { described_class.render }

      context 'when the interfaces have content' do
        let(:output) {
          [
            [
              "\e[38;2;39m\e[48;2;49m\e[1;1H               \e[1;1HTesting Outpu...\e[38;2;39m\e[48;2;49m\e[?25h",
              "\e[38;2;39m\e[48;2;49m\e[2;1H               \e[2;1H\e[38;2;39m\e[48;2;49m\e[?25h"
            ]
          ]
        }

        before { Compositor.arrange({ 'dummy' => [[{ text: 'Testing Output.render' }]] }) }

        it { subject.must_equal(output) }
      end

      context 'when the interfaces have no content' do
        let(:output) {
          [
            [
              "\e[38;2;39m\e[48;2;49m\e[1;1H               \e[1;1H\e[38;2;39m\e[48;2;49m\e[?25h",
              "\e[38;2;39m\e[48;2;49m\e[2;1H               \e[2;1H\e[38;2;39m\e[48;2;49m\e[?25h"
            ]
          ]
        }

        it { subject.must_equal(output) }
      end
    end
  end
end
