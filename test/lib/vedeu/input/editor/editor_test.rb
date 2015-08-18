require 'test_helper'

module Vedeu

  module Editor

    describe Editor do

      let(:described) { Vedeu::Editor::Editor }
      let(:instance)  {
        described.new(input: input, name: _name)
      }
      let(:input)     {}
      let(:_name)     {}
      let(:document)  { Vedeu::Editor::Document.new(data: data) }
      let(:data)      {
        "Hydrogen\n"  \
        "Helium\n"    \
        "Lithium\n"   \
        "Beryllium\n" \
        "Boron\n"     \
        "Carbon\n"    \
        "Nitrogen\n"  \
        "Oxygen\n"    \
        "Fluorine\n"  \
        "Neon\n"      \
        "Sodium\n"    \
        "Magnesium"
      }

      before do
        Vedeu.documents.stubs(:by_name).returns(document)
      end

      describe '#initialize' do
        it { instance.instance_variable_get('@input').must_equal(input) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.keypress' do
      end

      describe '#keypress' do
        it { instance.must_respond_to(:keypress) }
      end

    end # Editor

  end # Editor

end # Vedeu
