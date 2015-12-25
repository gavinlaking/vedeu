# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Input

    describe Keys do

      let(:described) { Vedeu::Input::Keys }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Keys

    describe Key do

      let(:described) { Vedeu::Input::Key }
      let(:instance)  { described.new(input) { :output } }
      let(:input)     { 'a' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }

        context 'when the required block is not given' do
          subject { described.new(input) }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

      describe '#input' do
        subject { instance.input }

        it 'returns the key defined' do
          subject.must_equal('a')
        end
      end

      describe '#key' do
        it { instance.must_respond_to(:key) }
      end

      describe '#output' do
        subject { instance.output }

        it 'returns the result of calling the proc' do
          subject.must_equal(:output)
        end
      end

      describe '#press' do
        it { instance.must_respond_to(:press) }
      end

      describe '#action' do
        it { instance.must_respond_to(:action) }
      end

    end # Key

  end # Input

end # Vedeu
