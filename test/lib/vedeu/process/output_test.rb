require_relative '../../../test_helper'

module Vedeu
  describe Output do
    let(:described_class) { Output }
    let(:subject)         { described_class.new }
    let(:result)          {}
    let(:queued_result)   { { 'dummy' => [['queued...']] } }

    before do
      Interface.create({ name: 'dummy', width: 10, height: 2, cursor: true })
    end

    after do
      InterfaceRepository.reset
    end

    it 'returns an Output instance' do
      subject.must_be_instance_of(Output)
    end

    describe '.render' do
      let(:subject) { described_class.render }
    end
  end
end
