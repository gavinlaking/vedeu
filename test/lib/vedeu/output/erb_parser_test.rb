require 'test_helper'
require 'vedeu/output/erb_parser'
require 'vedeu/support/helpers'

class UserView
  def initialize
    @output = ''
  end

  def value
    'Testing Vedeu.'
  end

  def interface
    'test'
  end

  def path
    'test/support/template.erb'
  end
end

module Vedeu
  describe ERBParser do
    describe '.parse' do
      it 'parses the template when the template file was found' do
        skip
        parser = ERBParser.parse(UserView.new)
        parser.must_equal("This is the test template.\n\n\e[38;5;55mTesting Vedeu.\n\e[48;5;226mTesting Vedeu.\n\e[38;5;208m\e[48;5;226mTesting Vedeu.\n\e[4mTesting Vedeu.\n\nSome more content...\n")
      end

      it 'parses the template when the template file was found' do
        parser = ERBParser.parse(UserView.new)
        parser.must_equal(
          {
            interfaces: [
              {
                name:  'test',
                lines: [
                  {
                    streams: { text: 'This is the test template.' }
                  }, {
                    streams: { text: '' }
                  }, {
                    streams: { text: "\e[38;5;55mTesting Vedeu." }
                  }, {
                    streams: { text: "\e[48;5;226mTesting Vedeu." }
                  }, {
                    streams: { text: "\e[38;5;208m\e[48;5;226mTesting Vedeu." }
                  }, {
                    streams: { text: "\e[4mTesting Vedeu." }
                  }, {
                    streams: { text: '' }
                  }, {
                    streams: { text: 'Some more content...' }
                  }
                ]
              }
            ]
          }
        )
      end

      it 'raises an exception when the template file cannot be found' do
        user_view = UserView.new
        user_view.stub(:path, '/some/wrong/path/template.erb') do
          proc { ERBParser.parse(user_view) }.must_raise(Errno::ENOENT)
        end
      end


      it 'parses the template and colour directives within' do
        user_view = UserView.new
        user_view.stub(:path, 'test/support/erb/colour.erb') do
          ERBParser.parse(user_view).must_equal(
            {
              interfaces: [
                {
                  name:  'test',
                  lines: [
                    {
                      streams: {
                        text: "\e[38;5;52mDark red text on default background."
                      }
                    }, {
                      streams: {
                        text: "\e[48;5;201mDefault text on magenta background."
                      }
                    }, {
                      streams: {
                        text: "\e[38;5;196m\e[48;5;17mRed text on dark blue background."
                      }
                    }
                  ]
                }
              ]
            }
          )
        end
      end

      it 'parses the template and style directives within' do
        user_view = UserView.new
        user_view.stub(:path, 'test/support/erb/style.erb') do
          ERBParser.parse(user_view).must_equal(
            {
              interfaces: [
                {
                  name:  'test',
                  lines: [
                    {
                      streams: { text: 'Empty style leads to nothing.' }
                    }, {
                      streams: { text: "\e[4mUnderlined text." }
                    }, {
                      streams: { text: 'Unknown style leads to nothing.' }
                    }
                  ]
                }
              ]
            }
          )
        end
      end

      it 'parses the template and both colour and style directives within' do
        user_view = UserView.new
        user_view.stub(:path, 'test/support/erb/colour_style.erb') do
          ERBParser.parse(user_view).must_equal(
            {
              interfaces: [
                {
                  name:  'test',
                  lines: [
                    {
                      streams: {
                        text: "\e[38;5;21m\e[4m\e[48;5;17mBlue underline text on dark blue background."
                      }
                    }
                  ]
                }
              ]
            }
          )
        end
      end

      it 'treats sections of the template as one line' do
        user_view = UserView.new
        user_view.stub(:path, 'test/support/erb/line.erb') do
          ERBParser.parse(user_view).must_equal(
            {
              interfaces: [
                {
                  name:  'test',
                  lines: [
                    {
                      streams: {
                        text: "  This is line one.  This is line two."
                      }
                    }
                  ]
                }
              ]
            }
          )
        end
      end

      it 'treats sections of the template as one line with a foreground' do
        user_view = UserView.new
        user_view.stub(:path, 'test/support/erb/line_foreground.erb') do
          ERBParser.parse(user_view).must_equal(
            {
              interfaces: [
                {
                  name:  'test',
                  lines: [
                    {
                      streams: {
                        text: "  \e[38;5;226mThis is line one.\e[38;2;39m  This is line two."
                      }
                    }
                  ]
                }
              ]
            }
          )
        end
      end

      it 'treats sections of the template as one line with a foreground' do
        user_view = UserView.new
        user_view.stub(:path, 'test/support/erb/line_foreground_2x.erb') do
          ERBParser.parse(user_view).must_equal(
            {
              interfaces: [
                {
                  name:  'test',
                  lines: [
                    {
                      streams: {
                        text: "  \e[38;5;226mThis is line one.\e[38;2;39m  \e[38;5;196mThis is line two.\e[38;2;39m  This is line three."
                      }
                    }
                  ]
                }
              ]
            }
          )
        end
      end

      it 'treats sections of the template as one line' do
        skip
        user_view = UserView.new
        user_view.stub(:path, 'test/support/erb/line_2x.erb') do
          ERBParser.parse(user_view).must_equal(
            {
              interfaces: [
                {
                  name:  'test',
                  lines: [
                    {
                      streams: {
                        text: "  This is line one.  This is line two."
                      }
                    }, {
                      streams: {
                        text: "  This is line three.  This is line four."
                      }
                    }
                  ]
                }
              ]
            }
          )
        end
      end
    end
  end
end
