# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe Chars do

      let(:described) { Vedeu::Coercers::Chars }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}
      let(:klass)     { Vedeu::Views::Chars }

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

    end # Chars

  end # Coercers

end # Vedeu
