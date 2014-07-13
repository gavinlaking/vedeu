require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/output/output'

module Vedeu
  describe Output do
    let(:described_module) { Output }
    let(:output)           {}

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

    describe '.render' do
      let(:subject) { described_module.render }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end
  end
end
