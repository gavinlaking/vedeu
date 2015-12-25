# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Interfaces

    describe Null do

      let(:described)  { Vedeu::Interfaces::Null }
      let(:instance)   { described.new }

      describe '#group' do
        subject { instance.group }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

    end # Null

  end # Interfaces

end # Vedeu
