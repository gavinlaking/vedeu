require 'test_helper'

describe 'building views' do

  let(:view) {
    Vedeu.interfaces.find('my_interface')
  }

  before do
    Vedeu.buffers.reset
    Vedeu.interfaces.reset
    Vedeu.interface 'my_interface' do
      geometry do
        height 5
        width  15
      end
    end
  end

  describe 'a view with no content' do
    before do
      Vedeu.views do
        view 'my_interface' do
          # ...
        end
      end
    end

    subject { view }

    it { subject.lines.size.must_equal(0) }
  end

  describe 'a view with a single empty line' do
    before do
      Vedeu.views do
        view 'my_interface' do
          lines do
          end
        end
      end
    end

    subject { view }

    it { subject.lines.size.must_equal(1) }
  end

  describe 'a view with multiple empty lines' do
    before do
      Vedeu.views do
        view 'my_interface' do
          lines do
          end
          lines do
          end
        end
      end
    end

    subject { view }

    it { subject.lines.size.must_equal(2) }
  end

  describe 'a view with a single line with single stream' do
    before do
      Vedeu.views do
        view 'my_interface' do
          lines do
            text 'Some text'
          end
        end
      end
    end

    subject { view }

    it { subject.lines.size.must_equal(1) }
  end

  describe 'a view with a single line with multiple streams' do
    before do
      Vedeu.views do
        view 'my_interface' do
          lines do
            text 'Some text'
            text 'Some more text'
          end
        end
      end
    end

    subject { view }

    it { subject.lines.size.must_equal(1) }
  end

  describe 'a view with multiple lines with single stream' do
    before do
      Vedeu.views do
        view 'my_interface' do
          lines do
            text 'Some text'
          end
          lines do
            text 'Some more text'
          end
        end
      end
    end

    subject { view }

    it { subject.lines.size.must_equal(2) }
  end

  describe 'a view with multiple lines with multiple streams' do
    before do
      Vedeu.views do
        view 'my_interface' do
          lines do
            text 'Some text'
            text 'Some more text'
          end
          lines do
            text 'More text'
            text 'Even more text'
          end
        end
      end
    end

    subject { view }

    it { subject.lines.size.must_equal(2) }
  end

  describe 'a view with multiple lines with multiple streams' do
    before do
      Vedeu.views do
        view 'my_interface' do
          lines do
            streams do
              text 'Some text'
              text 'Some more text'
            end
          end
          lines do
            streams do
              background '#ffff00'
              foreground '#ff0000'
              text 'More text'
              text 'Even more text'
            end
            streams do
              background '#ff00ff'
              foreground '#ffff00'
              text 'Woah text'
            end
            streams do
              background '#00ff00'
              foreground '#ff00ff'
              text 'Woah even more text'
            end
          end
        end
      end
    end

    subject { view }

    it { subject.lines.size.must_equal(2) }
  end

  # describe 'a view with multiple lines with single stream (using line)' do
  #   before do
  #     Vedeu.views do
  #       view 'my_interface' do
  #         lines do
  #           line 'Some text'
  #         end
  #         lines do
  #           line 'Some more text'
  #         end
  #       end
  #     end
  #   end

  #   subject { view }

  #   it { subject.lines.size.must_equal(2) } # 4?
  # end

  # describe 'a view with multiple lines with single stream' do
  #   before do
  #     Vedeu.views do
  #       view 'my_interface' do
  #         lines do
  #           line 'Some text'
  #           line 'Some more text'
  #         end
  #       end
  #     end
  #   end

  #   subject { view }

  #   it { subject.lines.size.must_equal(2) } # 3?
  # end

  # describe 'a view with multiple lines with different colours' do
  #   before do
  #     Vedeu.views do
  #       view 'my_interface' do
  #         lines do
  #           line do
  #             background '#ffff00'
  #             foreground '#ff0000'
  #             text 'Some text'
  #           end
  #           line do
  #             background '#00ffff'
  #             foreground '#0000ff'
  #             text 'Some more text'
  #           end
  #         end
  #       end
  #     end
  #   end

  #   subject { view }

  #   it { subject.lines.size.must_equal(2) } # 3?
  # end

  # describe 'a view with multiple lines with different colours' do
  #   before do
  #     Vedeu.views do
  #       view 'my_interface' do
  #         lines do
  #           background '#ffff00'
  #           foreground '#ff0000'
  #           line do
  #             background '#000000'
  #             foreground '#ff00ff'
  #             text 'Some text'
  #           end
  #           line do
  #             background '#00ffff'
  #             foreground '#0000ff'
  #             text 'Some more text'
  #           end
  #         end
  #       end
  #     end
  #   end

  #   subject { view }

  #   it { subject.lines.size.must_equal(2) } # 3?
  # end

end
