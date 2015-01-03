require 'test_helper'

module Vedeu

  class CoercionsTestClass

    include Coercions

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

  end # CoercionsTestClass

  describe Coercions do

    describe '.coerce' do
      let(:described) { Vedeu::Style }
      let(:value)     { 'bold' }

      subject { described.coerce(value) }

      it { return_type_for(subject, described) }

      context 'when the value is nil' do
        let(:value) { nil }

        it { return_type_for(subject, described) }
      end

      context 'when the value is a Style already' do
        let(:value) { Vedeu::Style.new('bold') }

        it { subject.must_equal(value) }
      end

      context 'when the value is an Array' do
        let(:value)  { [:bold, :blink] }

        it { subject.value.must_equal([:bold, :blink]) }
      end
    end

    describe '.coercer' do
      [nil, [], {}].each do |empty_value|
        it 'returns an empty collection when nil or empty' do
          CoercionsTestClass.coercer(empty_value).must_equal([])
        end
      end

      it 'returns when an object' do
        klass = CoercionsTestClass.new

        CoercionsTestClass.coercer([klass]).must_equal([klass])
      end

      it 'returns a collection of models when a single hash' do
        coerced = CoercionsTestClass.coercer({ :name => 'test1' })
        coerced.must_be_instance_of(Array)
        coerced.first.attributes.must_equal({ name: "test1" })
      end

      it 'returns a collection of models when multiple hashes' do
        coerced = CoercionsTestClass.coercer([
          { :name => 'test1' }, { :name => 'test2' }
        ])
        coerced.size.must_equal(2)
        coerced.map(&:attributes).must_equal(
          [{ name: "test1" }, { name: "test2" }]
        )
      end

      it 'returns a collection of models when a single array' do
        coerced = CoercionsTestClass.coercer([{ :name => 'test3' }])
        coerced.size.must_equal(1)
        coerced.first.attributes.must_equal({ name: "test3" })
      end
    end

  end # Coercions

end # Vedeu
