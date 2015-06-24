require 'test_helper'

module Vedeu

  class TestInterfaceModel
    include Vedeu::Model
    include Vedeu::DisplayBuffer

    def colour
      Vedeu::Colour.new(background: '#000000', foreground: '#ffffff')
    end

    def name
      'test_interface_model'
    end

    def style
      Vedeu::Style.new(:normal)
    end

    private

    def repository
      Vedeu.interfaces
    end
  end

  describe DisplayBuffer do

    let(:described)        { Vedeu::DisplayBuffer }
    let(:example_model)    { Vedeu::TestInterfaceModel }
    let(:example_instance) { example_model.new }

    before do
      example_instance.store

      Vedeu::Refresh.stubs(:by_name)
    end
    after { Vedeu.interfaces.reset }

    describe '#store_immediate' do
      subject { example_instance.store_immediate }

      it { subject.must_be_instance_of(example_model) }
    end

    describe '#store_deferred' do
      subject { example_instance.store_deferred }

      it { subject.must_be_instance_of(example_model) }

      context 'when the name is not defined' do
        before { example_instance.stubs(:name) }

        it { proc { subject }.must_raise(InvalidSyntax) }
      end

      context 'when the buffer is not already registered' do
        # it { skip }
      end

      context 'when the buffer is already registered' do
        # it { skip }
      end
    end

  end # DisplayBuffer

end # Vedeu
