require 'test_helper'

module Vedeu

  class TestInterfaceModel
    include Vedeu::Model
    include Vedeu::DisplayBuffer

    def name
      'test_interface_model'
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

    describe '#store_immediate' do
      subject { example_instance.store_immediate }

      it { return_type_for(subject, example_model) }
    end

    describe '#store_deferred' do
      subject { example_instance.store_deferred }

      it { return_type_for(subject, example_model) }

      context 'when the buffer is not already registered' do
      end

      context 'when the buffer is already registered' do
      end
    end

  end # DisplayBuffer

end # Vedeu
