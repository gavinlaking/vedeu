require 'test_helper'

module Vedeu

  describe Keymap do

    let(:described)  { Keymap.new(interfaces, keys) }
    let(:interfaces) { [] }
    let(:keys)       { [] }

    describe '#initialize' do
      it { return_type_for(described, Keymap) }
      it { assigns(described, '@interfaces', []) }
      it { assigns(described, '@keys', []) }
    end

    describe '#deputy' do
      it { return_type_for(described.deputy, DSL::Keymap) }
    end

  end # Keymap

end # Vedeu
