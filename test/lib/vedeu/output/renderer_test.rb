require_relative '../../../test_helper'

module Vedeu
  describe Renderer do
    let(:described_class)    { Renderer }
    let(:described_instance) { described_class.new }
    let(:subject)            { described_instance }

    it 'returns a Renderer instance' do
      subject.must_be_instance_of(Renderer)
    end
  end
end
