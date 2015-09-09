require 'test_helper'

module Vedeu

  module Renderers

    describe HTML do

      let(:described)  { Vedeu::Renderers::HTML }
      let(:instance)   { described.new(options) }
      let(:options)    {
        {
          write_file: write_file,
        }
      }
      let(:write_file) { false }
      let(:buffer)     { Vedeu::Terminal::Buffer }

      before do
        ::File.stubs(:write)
        Vedeu.stubs(:height).returns(2)
        Vedeu.stubs(:width).returns(4)
        Vedeu::Terminal::Buffer.reset
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
        it { instance.instance_variable_get('@content').must_equal(nil) }
      end

      # describe '#render' do
      #   before { ::File.stubs(:open) }

      #   subject { instance.render(content) }

      #   it { subject.must_be_instance_of(String) }

      #   context 'when the :write_file option is true' do
      #     let(:write_file) { true }

      #     context 'when a path is given' do
      #       let(:path) { '/tmp/test_vedeu_html_renderer.html' }

      #       # it do
      #       #   ::File.expects(:open)
      #       #   subject
      #       # end
      #     end

      #     context 'when a path is not given' do
      #       let(:path) {}
      #       let(:_time) { Time.new(2015, 4, 12, 16, 55) }

      #       before { Time.stubs(:now).returns(_time) }

      #       # it do
      #       #   ::File.expects(:open)#.with('/tmp/vedeu_html_1428854100.html', 'w')
      #       #   subject
      #       # end
      #     end
      #   end

      #   context 'when the :write_file options is false' do
      #     let(:write_file) { false }

      #     # @todo Add more tests.
      #     # it { skip }
      #   end
      # end

      describe '#html_body' do
        before do
          instance.render(buffer)
        end

        subject { instance.html_body }

        context 'when there is an empty buffer' do
          let(:expected) {
            "<tr>\n</tr>\n" \
            "<tr>\n</tr>\n"
          }

          it { subject.must_equal(expected) }
        end

        context 'when there is content on the buffer' do
          let(:expected) {
            "<tr>\n</tr>\n<tr>\n" \
            "<td style='border:1px #ff0000 solid;background:#ff0000;color:#ffffff;'>t</td>" \
            "<td style='border:1px #ffff00 solid;background:#ffff00;color:#000000;'>e</td>" \
            "<td style='border:1px #00ff00 solid;background:#00ff00;color:#000000;'>s</td>" \
            "<td style='border:1px #00ffff solid;background:#00ffff;color:#000000;'>t</td>" \
            "</tr>\n"
          }

          before do
            buffer.write(Vedeu::Views::Char.new(value: 't',
                                                colour: {
                                                  background: '#ff0000',
                                                  foreground: '#ffffff'
                                                }), 1, 1)
            buffer.write(Vedeu::Views::Char.new(value: 'e',
                                                colour: {
                                                  background: '#ffff00',
                                                  foreground: '#000000'
                                                }), 1, 2)
            buffer.write(Vedeu::Views::Char.new(value: 's',
                                                colour: {
                                                  background: '#00ff00',
                                                  foreground: '#000000'
                                                }), 1, 3)
            buffer.write(Vedeu::Views::Char.new(value: 't',
                                                colour: {
                                                  background: '#00ffff',
                                                  foreground: '#000000'
                                                }), 1, 4)
          end

          it { subject.must_be_instance_of(String) }
          it { subject.must_equal(expected) }
        end
      end

    end # HTML

  end # Renderers

end # Vedeu
