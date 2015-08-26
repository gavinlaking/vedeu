require 'test_helper'

module Vedeu

  describe LocklessLogDevice do

    let(:described)        { Vedeu::LocklessLogDevice }
    let(:instance)         { described.new(file_or_filename) }
    let(:file_or_filename) {}

    describe '#initialize' do
      # it { instance.must_be_instance_of(described) }
      # it {
      #   instance.instance_variable_get('@file_or_filename').
      #     must_equal(file_or_filename)
      # }
    end

    describe '#write' do
      subject { instance.write(message) }
    end

    describe '#close' do
      subject { instance.close }
    end

  end # LocklessLogDevice

end # Vedeu
