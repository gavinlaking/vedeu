# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class DSLModelTestClass

    attr_reader :name

    def initialize(name)
      @name = name
    end

  end # DSLModelTestClass

  class DSLModuleTestClass

    include Vedeu::DSL

  end # DSLTestClass

  describe DSL do

    let(:described) { Vedeu::DSL }
    let(:instance)  { Vedeu::DSLModuleTestClass.new(model, client) }
    let(:model)     { Vedeu::DSLModelTestClass.new(_name) }
    let(:client)    {}
    let(:_name)     {}

    describe '#name' do
      subject { instance.name }

      context 'when the model is nil' do
        let(:model) {}

        it { subject.must_equal(nil) }
      end

      context 'when the model is not nil' do
        context 'when the model has a name' do
          let(:_name) { :vedeu_dsl }

          it { subject.must_equal(_name) }
        end

        context 'when the model has no name' do
          it { subject.must_equal(nil) }
        end
      end
    end

  end # DSL

end # Vedeu
