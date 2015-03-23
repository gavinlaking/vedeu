require 'test_helper'

module Vedeu

  describe HTMLRenderer do

    let(:described) { Vedeu::HTMLRenderer }
    let(:instance)  { described.new(output) }
    let(:output)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::HTMLRenderer) }
      it { instance.instance_variable_get('@output').must_equal(output) }
    end

    describe '#render' do
      subject { instance.render }

      it { subject.must_be_instance_of(String) }
    end

    describe '.to_file' do
      before { File.stubs(:open) }

      subject { described.to_file(output, path) }

      context 'when a path is given' do
        let(:path) { '/tmp/test_vedeu_html_renderer.html' }

        #it { subject.must_equal('') }
      end

      context 'when a path is not given' do
        let(:path) {}


      end
    end

    describe '#html_body' do
      subject { instance.html_body }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal('') }

      context 'when there is output' do
        let(:output) {
          [
            [
              Vedeu::Char.new({ value: 't' }),
              Vedeu::Char.new({ value: 'e' }),
              Vedeu::Char.new({ value: 's' }),
              Vedeu::Char.new({ value: 't' }),
            ]
          ]
        }

        it { subject.must_equal(
          "<tr>\n" \
          "<td style='background:#000;color:#222;border:1px #000 solid;'>t</td>\n" \
          "<td style='background:#000;color:#222;border:1px #000 solid;'>e</td>\n" \
          "<td style='background:#000;color:#222;border:1px #000 solid;'>s</td>\n" \
          "<td style='background:#000;color:#222;border:1px #000 solid;'>t</td>\n" \
          "</tr>\n") }
      end
    end

  end # HTMLRenderer

end # Vedeu
