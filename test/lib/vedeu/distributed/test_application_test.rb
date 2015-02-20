require 'test_helper'

module Vedeu

  describe TestApplication do

    let(:described)  { Vedeu::TestApplication }
    let(:instance)   { described.new(attributes) }
    let(:attributes) { {} }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Vedeu::TestApplication) }
      # it { subject.instance_variable_get('@attributes').must_equal(attributes) }
    end

    describe '#lib_dir' do
      subject { instance.lib_dir }

      it { subject.must_be_instance_of(String) }
    end

  end # TestApplication

end # Vedeu
