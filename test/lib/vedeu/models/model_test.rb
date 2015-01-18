require 'test_helper'

module Vedeu

  describe Model do
    let(:model_instance) { ModelTestClass.new(attributes) }
    let(:attributes) {
      {
        name: 'hydrogen'
      }
    }

    describe '#deputy' do
      subject { model_instance.deputy }

      it 'returns the DSL instance' do
        return_type_for(subject, DSL::ModelTestClass)
      end
    end

    describe '#store' do
      subject { model_instance.store }

      it 'returns the model' do
        return_type_for(subject, ModelTestClass)
      end
    end

    # describe '#demodulize' do
    #   let(:klass) {}

    #   subject { described.demodulize(klass) }

    #   context 'with nil' do
    #     it { subject.must_equal('') }
    #   end

    #   context 'with an empty string' do
    #     let(:klass) { '' }

    #     it { subject.must_equal('') }
    #   end

    #   context 'with a namespaced class' do
    #     let(:klass) { Vedeu::DSL::Interface }

    #     it { subject.must_equal('Interface') }
    #   end

    #   context 'with a non-namespaced class' do
    #     let(:klass) { Composition }

    #     it { subject.must_equal('Composition') }
    #   end
    # end

  end # Model

end # Vedeu
