require_relative '../../../test_helper'

module Vedeu
  describe Menu do
    let(:described_class)    { Menu }
    let(:described_instance) { described_class.new(index) }
    let(:index)              {}

    describe '#initialize' do
      it 'returns a Menu instance' do
        described_instance.must_be_instance_of(Menu)
      end
    end
  end
end
