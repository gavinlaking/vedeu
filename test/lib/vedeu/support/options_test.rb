require 'test_helper'

module Vedeu

  describe Options do

    let(:described) { Vedeu::Options }
    let(:instance)  { described.new(options) }
    let(:options)   {
      {}
    }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@_options').must_equal(options) }
    end

    describe '#_build' do
      subject { instance._build }

      it { subject.must_be_instance_of(described) }

      context 'with no options' do
        it 'defines no methods' do
          subject
          instance._defined.must_equal([])
        end
      end

      context 'with a predicate option' do
        let(:options) {
          {
            predicate: false
          }
        }

        it 'defines the method and the predicate as an alias to that method' do
          subject
          instance.must_respond_to(:predicate)
          instance.predicate.must_equal(false)

          instance.must_respond_to(:predicate?)
          instance.predicate?.must_equal(false)

          instance._defined.must_equal([:predicate, :predicate?])
        end
      end

      context 'with a normal option' do
        let(:options) {
          {
            some_option: 'some_value'
          }
        }

        it 'defines the method' do
          subject
          instance.must_respond_to(:some_option)
          instance.some_option.must_equal('some_value')

          instance.wont_respond_to(:some_option?)

          instance._defined.must_equal([:some_option])
        end
      end
    end

  end # Option

end # Vedeu
