require 'test_helper'

module Vedeu

  module Renderers

    describe HTML do

      let(:described)  { Vedeu::Renderers::HTML }
      let(:instance)   { described.new(options) }
      let(:options)    {
        {
          content:    content,
          write_file: write_file,
        }
      }
      let(:content)     { [''] }
      let(:write_file) { false }

      before { ::File.stubs(:write) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
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
        let(:content) {
          [
            [
              Vedeu::Views::Char.new(value: 't'),
              Vedeu::Views::Char.new(value: 'e'),
              Vedeu::Views::Char.new(value: 's'),
              Vedeu::Views::Char.new(value: 't'),
            ]
          ]
        }

        subject { instance.html_body }

        it { subject.must_be_instance_of(String) }

        # it do
        #   subject.must_equal(
        #     "<tr>\n" \
        #     "<td style=''>t</td>\n" \
        #     "<td style=''>e</td>\n" \
        #     "<td style=''>s</td>\n" \
        #     "<td style=''>t</td>\n" \
        #     "</tr>\n"
        #   )
        # end
      end

    end # HTML

  end # Renderers

end # Vedeu
