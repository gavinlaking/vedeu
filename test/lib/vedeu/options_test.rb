require 'test_helper'

module Vedeu

  describe Options do

    let(:described) { Vedeu::Options }
    let(:instance)  { described.new(options, defaults) }
    let(:options)   {}
    let(:defaults)  {}

    describe '#initialize' do
      subject { instance }

      it { instance.must_be_instance_of(described) }

      context 'when the options are nil and defaults are nil' do
        it { instance.instance_variable_get('@options').must_equal({}) }
        it { instance.instance_variable_get('@defaults').must_equal({}) }
      end

      context 'when the options are empty and the defaults are empty' do
        let(:options)  { {} }
        let(:defaults) { {} }

        it { instance.instance_variable_get('@options').must_equal({}) }
        it { instance.instance_variable_get('@defaults').must_equal({}) }
      end

      context 'when an option is set but no default is set' do
        let(:options)  { { element: :hydrogen } }
        let(:defaults) { {} }

        it { (instance.methods - Object.methods).must_equal([:element]) }
        it { instance.element.must_equal(:hydrogen) }
      end

      context 'when an option is set but a default is set' do
        let(:options)  { { element: :lithium } }
        let(:defaults) { { element: :helium } }

        it { (instance.methods - Object.methods).must_equal([:element]) }
        it { instance.element.must_equal(:lithium) }
      end

      context 'when no option is set but a default is set' do
        let(:options)  { {} }
        let(:defaults) { { element: :beryllium } }

        it { (instance.methods - Object.methods).must_equal([:element]) }
        it { instance.element.must_equal(:beryllium) }
      end
    end

  end # Options

end # Vedeu
