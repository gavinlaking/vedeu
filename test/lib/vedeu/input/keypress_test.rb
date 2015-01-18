require 'test_helper'

module Vedeu

  describe Keypress do

    let(:described) { Vedeu::Keypress }
    let(:instance) { described.new(key) }
    let(:key) { 'a' }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, described) }
      it { assigns(subject, '@key', key) }
    end

    describe '.keypress' do
      subject { described.keypress(key) }

      it { return_type_for(subject, Array) }
    end

  end # Keypress

end # Vedeu
