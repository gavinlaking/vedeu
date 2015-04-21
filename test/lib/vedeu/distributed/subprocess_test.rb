require 'test_helper'

module Vedeu

  describe Subprocess do

    let(:described)   { Vedeu::Subprocess }
    let(:instance)    { described.new(application) }
    let(:application) {}

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Vedeu::Subprocess) }
      it do
        subject.instance_variable_get('@application').must_equal(application)
      end
      it { subject.instance_variable_get('@pid').must_equal(nil) }
    end

  end # Subprocess

end # Vedeu
