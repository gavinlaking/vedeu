require 'test_helper'

module Vedeu
  describe Move do
    before do
      Interfaces.reset
      Cursors.add({ name: 'thorium' })
    end

    context 'when no interfaces are defined' do
      it { proc { Move.down }.must_raise(NoInterfacesDefined) }

      it { proc { Move.up }.must_raise(NoInterfacesDefined) }

      it { proc { Move.right }.must_raise(NoInterfacesDefined) }

      it { proc { Move.left }.must_raise(NoInterfacesDefined) }
    end

    context 'when there is at least one interface defined' do
      before { Focus.stubs(:current).returns('thorium') }

      it { Move.down.must_be_instance_of(Array) }

      it { Move.up.must_be_instance_of(Array) }

      it { Move.right.must_be_instance_of(Array) }

      it { Move.left.must_be_instance_of(Array) }
    end
  end
end
