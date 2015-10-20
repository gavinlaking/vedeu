require 'test_helper'

module Vedeu

  module Renderers

    describe JSON do

      let(:described) { Vedeu::Renderers::JSON }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:output)    { Vedeu::Models::Page.new }

      before do
        ::File.stubs(:write)
        Vedeu.stubs(:height).returns(1)
        Vedeu.stubs(:width).returns(1)
        # Vedeu::Configuration.stubs(:compression?).returns(false)
        Vedeu::Terminal::Buffer.reset
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal("{\n}") }
      end

      describe '#render' do
        let(:output) {
          Vedeu::Models::Page.coerce([
            Vedeu::Views::Char.new(value: 'a',
                                   colour: {
                                     background: '#ff0000',
                                     foreground: '#ffffff' }),
          ])
        }
        let(:expected) {
          "[\n"   \
          "  {\n" \
          "    \"border\": \"\",\n" \
          "    \"colour\": {\n" \
          "      \"background\": \"\\u001b[48;2;255;0;0m\",\n" \
          "      \"foreground\": \"\\u001b[38;2;255;255;255m\"\n" \
          "    },\n" \
          "    \"parent\": {\n" \
          "    },\n" \
          "    \"position\": {\n" \
          "      \"y\": null,\n" \
          "      \"x\": null\n" \
          "    },\n" \
          "    \"style\": \"\",\n" \
          "    \"value\": \"a\"\n" \
          "  }\n" \
          "]"
        }

        subject { instance.render(output) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal(expected) }
      end

    end # JSON

  end # Renderers

end # Vedeu
