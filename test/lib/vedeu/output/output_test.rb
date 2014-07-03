require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/output/output'

module Vedeu
  describe Output do
    let(:described_class) { Output }
    let(:output)          {}

    before do
      InterfaceRepository.create({
        name: 'dummy',
        width: 15,
        height: 2,
        cursor: true
      })
      Terminal.stubs(:output).returns(output)
    end

    after { InterfaceRepository.reset }

    describe '#initialize' do
      let(:subject) { described_class.new }

      it 'returns an Output instance' do
        subject.must_be_instance_of(Output)
      end
    end

    # describe '.render' do
    #   let(:subject) { described_class.render }

    #   context 'when the interfaces have content' do
    #     let(:output) {
    #       [
    #         [
    #           "\e[1;1H               \e[1;1HTesting Outpu...\e[?25h",
    #           "\e[2;1H               \e[2;1H\e[?25h"
    #         ]
    #       ]
    #     }

    #     before { Compositor.arrange({ 'dummy' => [[{ text: 'Testing Output.render' }]] }) }

    #     it { subject.must_equal(output) }
    #   end

    #   context 'when the interfaces have no content' do
    #     let(:output) {
    #       [
    #         [
    #           "\e[1;1H               \e[1;1H\e[?25h",
    #           "\e[2;1H               \e[2;1H\e[?25h"
    #         ]
    #       ]
    #     }

    #     it { subject.must_equal(output) }
    #   end
    # end
  end
end
