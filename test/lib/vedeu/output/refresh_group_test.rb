require 'test_helper'

module Vedeu

  describe RefreshGroup do

    let(:described) { Vedeu::RefreshGroup }
    let(:instance)  { described.new(_name) }
    let(:_name)     { 'Vedeu::RefreshGroup' }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
    end

    describe '.by_name' do
      it { described.must_respond_to(:by_name) }
    end

    describe '#by_name' do
      subject { instance.by_name }

      # @todo
      # it { skip }
    end

  end # RefreshGroup

end # Vedeu
