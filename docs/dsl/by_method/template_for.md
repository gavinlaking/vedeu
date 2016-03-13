### template_for

Load content from an ERb template.

    Vedeu.renders do
      template_for(:my_interface,
                   '/path/to/template.erb',
                   @some_object,
                   options)
    end
