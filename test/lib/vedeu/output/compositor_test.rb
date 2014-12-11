require 'test_helper'

module Vedeu

  describe Compositor do
    let(:interface) {
      {
        name: 'indium'
      }
    }
    let(:buffer) {
      Buffer.new({ name: 'indium' })
    }

    before do
      Focus.stubs(:cursor).returns("\e[?25l")
      Terminal.console.stubs(:print)
    end

    describe '#initialize' do
      subject { Compositor.new(interface, buffer) }

      it 'returns an instance of Compositor' do
        subject.must_be_instance_of(Compositor)
      end

      it 'assigns the interface' do
        subject.instance_variable_get("@interface").must_equal(interface)
      end

      it 'assigns the buffer' do
        subject.instance_variable_get("@buffer").must_equal(buffer)
      end
    end

    describe '#compose' do
      subject { Compositor.new(interface, buffer).compose }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the updated interface attributes' do
        subject.must_equal([{}])
      end
    end

  end # Compositor

end # Vedeu
