require 'test_helper'

module Vedeu

  describe Offsets do

    before do
      Interfaces.reset
      Registrar.record({ name: 'thorium' })
      Terminal.console.stubs(:print)
    end

    context 'when no interfaces are defined' do
      before { Interfaces.reset }

      it { proc { Offsets.down }.must_raise(NoInterfacesDefined) }

      it { proc { Offsets.up }.must_raise(NoInterfacesDefined) }

      it { proc { Offsets.right }.must_raise(NoInterfacesDefined) }

      it { proc { Offsets.left }.must_raise(NoInterfacesDefined) }
    end

    context 'when there is at least one interface defined' do
      before { Focus.stubs(:current).returns('thorium') }

      it { Offsets.down.must_be_instance_of(Array) }

      it { Offsets.up.must_be_instance_of(Array) }

      it { Offsets.right.must_be_instance_of(Array) }

      it { Offsets.left.must_be_instance_of(Array) }
    end

  end # Offsets

end # Vedeu
