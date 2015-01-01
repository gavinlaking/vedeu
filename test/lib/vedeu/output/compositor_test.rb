require 'test_helper'

module Vedeu

  describe Compositor do

    let(:described) { Compositor.new(interface, buffer) }
    let(:interface) { mock('Interface') }
    let(:buffer)    { mock('Buffer') }

    # before do
    #   buffer.stubs(:content).returns([{}])
    # end

    # let(:interface) {
    #   {
    #     name: 'indium'
    #   }
    # }
    # let(:buffer) {
    #   Buffer.new({ name: 'indium' })
    # }

    # before do
    #   Focus.stubs(:cursor).returns("\e[?25l")
    #   Terminal.console.stubs(:print)
    # end

    describe '#initialize' do
      it { return_type_for(described, Compositor) }
      it { assigns(described, '@interface', interface) }
      it { assigns(described, '@buffer', buffer) }
    end

    describe '#compose' do
      it { skip }
    end

  end # Compositor

end # Vedeu
