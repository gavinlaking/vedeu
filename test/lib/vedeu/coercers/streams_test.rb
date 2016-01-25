# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe Streams do

      let(:described) { Vedeu::Coercers::Streams }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}
      let(:klass)     { Vedeu::Views::Streams }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        it { described.must_respond_to(:coerce) }
      end

      describe '#coerce' do
        subject { instance.coerce }
      end

    end # Streams

  end # Coercers

end # Vedeu
