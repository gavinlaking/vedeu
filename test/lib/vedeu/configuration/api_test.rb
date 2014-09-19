require 'test_helper'

module Vedeu
  module Configuration

    describe API do

      before { Configuration.reset }
      after  { Configuration.reset }

      describe '.configure' do
        it 'returns the default configuration' do
          Vedeu.configure do
            # ...
          end.must_equal(
            {
              colour_mode: 16777216,
              debug: false,
              interactive: true,
              once: false,
              system_keys: {
                exit: "q",
                focus_next: :tab,
                focus_prev: :shift_tab,
                mode_switch: :escape
              },
              terminal_mode: :raw,
              trace: false
            }
          )
        end
      end

      describe '' do
        it '' do
          configuration = Vedeu.configure do
            interactive false
          end

          configuration[:interactive].must_equal(false)
        end

        it '' do
          configuration = Vedeu.configure do
            interactive true
          end

          configuration[:interactive].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            interactive
          end

          configuration[:interactive].must_equal(true)
        end
      end

      describe '' do
        it '' do
          configuration = Vedeu.configure do
            standalone false
          end

          configuration[:interactive].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            standalone true
          end

          configuration[:interactive].must_equal(false)
        end

        it '' do
          configuration = Vedeu.configure do
            standalone
          end

          configuration[:interactive].must_equal(false)
        end
      end

      describe '' do
        it '' do
          configuration = Vedeu.configure do
            once false
          end

          configuration[:once].must_equal(false)
        end

        it '' do
          configuration = Vedeu.configure do
            once true
          end

          configuration[:once].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            once
          end

          configuration[:once].must_equal(true)
        end
      end

      describe '' do
        it '' do
          configuration = Vedeu.configure do
            many false
          end

          configuration[:once].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            many true
          end

          configuration[:once].must_equal(false)
        end

        it '' do
          configuration = Vedeu.configure do
            many
          end

          configuration[:once].must_equal(false)
        end
      end

      describe '' do
        # it '' do
        #   configuration = Vedeu.configure do
        #     terminal_mode
        #   end

        #   proc { configuration }.must_raise(InvalidSyntax)
        # end

        it '' do
          configuration = Vedeu.configure do
            terminal_mode :cooked
          end

          configuration[:terminal_mode].must_equal(:cooked)
        end

        it '' do
          configuration = Vedeu.configure do
            terminal_mode cooked
          end

          configuration[:terminal_mode].must_equal(:cooked)
        end

        it '' do
          configuration = Vedeu.configure do
            terminal_mode :raw
          end

          configuration[:terminal_mode].must_equal(:raw)
        end

        it '' do
          configuration = Vedeu.configure do
            terminal_mode raw
          end

          configuration[:terminal_mode].must_equal(:raw)
        end
      end

      describe '' do
        it '' do
          configuration = Vedeu.configure do
            cooked
          end

          configuration[:terminal_mode].must_equal(:cooked)
        end
      end

      describe '' do
        it '' do
          configuration = Vedeu.configure do
            raw
          end

          configuration[:terminal_mode].must_equal(:raw)
        end
      end

      describe '' do
        it '' do
          configuration = Vedeu.configure do
            debug
          end

          configuration[:debug].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            debug true
          end

          configuration[:debug].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            debug false
          end

          configuration[:debug].must_equal(false)
        end

        it '' do
          configuration = Vedeu.configure do
            trace true
          end

          configuration[:debug].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            debug false
            trace true
          end

          configuration[:debug].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            debug true
            trace false
          end

          configuration[:debug].must_equal(true)
        end

        it '' do
          configuration = Vedeu.configure do
            debug false
            trace false
          end

          configuration[:debug].must_equal(false)
        end
      end

      describe '' do
        it '' do
          configuration = Vedeu.configure do
            trace false
          end

          configuration[:trace].must_equal(false)
          configuration[:debug].must_equal(false)
        end

        it '' do
          configuration = Vedeu.configure do
            trace true
          end

          configuration[:trace].must_equal(true)
          configuration[:debug].must_equal(true)
        end
      end

      describe '' do
        # it '' do
        #   configuration = Vedeu.configure do
        #     colour_mode
        #   end

        #   proc { configuration }.must_raise(InvalidSyntax)
        # end

        # it '' do
        #   configuration = Vedeu.configure do
        #     colour_mode 1234
        #   end

        #   proc { configuration }.must_raise(InvalidSyntax)
        # end

        it '' do
          configuration = Vedeu.configure do
            colour_mode 256
          end

          configuration[:colour_mode].must_equal(256)
        end
      end

      describe '' do
        # it '' do
        #   configuration = Vedeu.configure do
        #     exit_key
        #   end

        #   proc { configuration }.must_raise(InvalidSyntax)
        # end

        # it '' do
        #   configuration = Vedeu.configure do
        #     exit_key ''
        #   end

        #   proc { configuration }.must_raise(InvalidSyntax)
        # end

        # it '' do
        #   configuration = Vedeu.configure do
        #     exit_key 123
        #   end

        #   proc { configuration }.must_raise(InvalidSyntax)
        # end

        # it '' do
        #   configuration = { system_keys: {} }

        #   Vedeu.configure do
        #     exit_key 'x'
        #   end

        #   configuration[:system_keys].must_equal('x')
        # end
      end

      # describe '' do
      #   it '' do
      #     configuration = Vedeu.configure do
      #       focus_next_key
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       focus_next_key ''
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       focus_next_key 123
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       focus_next_key :right
      #     end

      #     configuration[:system_keys][:focus_next].must_equal(:right)
      #   end
      # end

      # describe '' do
      #   it '' do
      #     configuration = Vedeu.configure do
      #       focus_prev_key
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       focus_prev_key ''
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       focus_prev_key 123
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       focus_prev_key :left
      #     end

      #     configuration[:system_keys][:focus_prev].must_equal(:left)
      #   end
      # end

      # describe '' do
      #   it '' do
      #     configuration = Vedeu.configure do
      #       mode_switch_key
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       mode_switch_key ''
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       mode_switch_key 123
      #     end

      #     proc { configuration }.must_raise(InvalidSyntax)
      #   end

      #   it '' do
      #     configuration = Vedeu.configure do
      #       mode_switch_key :enter
      #     end

      #     configuration[:system_keys][:mode_switch].must_equal(:enter)
      #   end
      # end

    end

  end
end
