require 'test_helper'

module Vedeu

  describe Borders do

    let(:described) { Vedeu::Borders }

    describe '.borders' do
      subject { described.borders }

      it { subject.must_be_instance_of(described) }
    end

  end # Borders

end # Vedeu
