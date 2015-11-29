require 'test_helper'

module Vedeu

  module Renderers

    describe HTML do

      let(:described)  { Vedeu::Renderers::HTML }
      let(:instance)   { described.new(options) }
      let(:options)    {
        {
          content:       content,
          end_tag:       end_tag,
          end_row_tag:   end_row_tag,
          filename:      filename,
          start_tag:     start_tag,
          start_row_tag: start_row_tag,
          template:      template,
          timestamp:     timestamp,
          write_file:    write_file,
        }
      }
      let(:content)       { '' }
      let(:end_tag)       { '</td>' }
      let(:end_row_tag)   { '</tr>' }
      let(:filename)      { 'out' }
      let(:start_tag)     { '<td' }
      let(:start_row_tag) { '<tr>' }
      let(:template)      {
        ::File.dirname(__FILE__) + '/../../../support/templates/html_renderer.vedeu'
      }
      let(:timestamp)     { false }
      let(:write_file)    { false }
      let(:buffer)        { Vedeu::Buffers::Terminal }

      before do
        Vedeu::Configuration.stubs(:compression?).returns(false)
        ::File.stubs(:write)
        Vedeu.stubs(:height).returns(2)
        Vedeu.stubs(:width).returns(4)
        Vedeu::Buffers::Terminal.reset!
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
        it { instance.instance_variable_get('@output').must_equal(nil) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
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
          "<html>\n" \
          "  <head>\n" \
          "    <style type='text/css'>\n" \
          "      body {\n" \
          "        background:#000;\n" \
          "      }\n" \
          "      td {\n" \
          "        border:1px #171717 solid;\n" \
          "        font-size:12px;\n" \
          "        font-family:monospace;\n" \
          "        height:18px;\n" \
          "        margin:1px;\n" \
          "        text-align:center;\n" \
          "        vertical-align:center;\n" \
          "        width:18px;\n" \
          "      }\n" \
          "    </style>\n" \
          "  </head>\n" \
          "  <body>\n" \
          "    <table>\n" \
          "      <tr>\n" \
          "<td style='border:1px #ff0000 solid;background:#ff0000;color:#ffffff;'>a</td></tr>\n" \
          "    </table>\n" \
          "  </body>\n" \
          "</html>\n"
        }

        subject { instance.render(output) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal(expected) }
      end

    end # HTML

  end # Renderers

end # Vedeu
