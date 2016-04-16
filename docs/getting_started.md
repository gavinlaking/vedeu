# @title Getting Started with Vedeu
# Getting Started with Vedeu

## Installation

First, install the gem locally:

    gem install vedeu

This will provide a new command to help build your client application.
Similar to Ruby on Rails, although not nearly as advanced as the Rails
equivalent, hopefully the `vedeu` command generators will get you off
the ground:

    vedeu

## Generating a new application

The following command will build a new application. Substitute
`your_app_name` for your desired application name.

    vedeu new your_app_name

If `your_app_name` already exists, Vedeu will only write new files
that do not exist at the file path. The generated files are a skeleton
Vedeu client application. Let's take a look at these files
individually.

```bash
|
|- app_name/
|   |
    |- app/
    |   |- controllers/
    |   |   |- application_controller.rb
    |   |
    |   |- helpers/
    |   |   |- application_helper.rb
    |   |
    |   |- models/
    |   |   |- keymaps/
    |   |       |- _global_.rb
    |   |
    |   |- views/
    |       |- interfaces/
    |       |- templates/
    |
    |- bin/
    |   |- app_name
    |
    |- config/
    |   |- add_name
    |   |- configuration.rb
    |
    |- lib/
    |- test/
    |- vendor/
    |- application.rb
    |- Gemfile
```

### app/controllers/

The controllers directory is the place to store the events and
behaviour logic of your application. It will manage the choosing of
views and models based on previous choices. Think of them as the
orchestrators of your application.

In web applications, the controller typically handles the routed
request and interacts with the models and sets up the views. In Vedeu,
it does much the same, minus the requests.

### app/helpers/

'Ruby on Rails' has a concept of helpers, which although not very
object-oriented, allow you to share functionality/behaviour across
multiple views. Vedeu uses this concept too, as it will be familiar to
many Rails developers and might be helpful to beginners.

### app/models/

Much like `lib`, this directory is for your application logic code.
Some people prefer to use `app/models`, others like to use `lib`. Some
even use both!

### app/models/keymaps/

This will contain the global keymap (which affects all of your
application) plus any specific interface keymaps which only affect a
certain interface when in focus. By default the global keymap contains
a few simple definitions:

- **`q`**

  **Quit**. Internally triggers the :_exit_ system event which in turn
  requests the application stops. This triggers the event :cleanup
  which the client application can bind to and perform any tidying up
  it wishes to perform before exiting.

- **`<esc>`**

  **Mode Switch**. Toggle between cooked, fake and raw terminal modes.

- **`<tab>`**

  **Focus Next**. Focus the next interface in the focus list.

- **`<shift+tab>`**

  **Focus Previous**. Focus the previous interface in the focus list.

### app/views/

This will contain classes which produce the views needed by Vedeu to
make your application come alive!

### app/views/interfaces/

This will contain the information Vedeu needs to draw the various
interfaces and views of your application.

### app/views/templates/

This will house the templates your application will use to display
views. You can populate templates with generic view information and
supplement it with variable data from your application.

### bin/

This will contain executable Ruby scripts (or Bash, or shell language
of your choice) which will launch your application or provide
command-line behaviours.

### config/

This will contain any configuration your application needs to run,
plus the configuration for Vedeu. This configuration affects the way
Vedeu works with your application.

### lib/

This is for code your application may use to support code you have in
`app/models`.

### test/

This is for the tests you might write to help ensure your application
executes in the way you expect.

### vendor/

This is for third-party code which your application might want to
ship with. Usually you will include various Ruby gems to provide
functionality, but you might want to do something special.


## Adding a new view to your application

The following command will build a new view within your application.
Substitute `some_view_name` for your desired application name. As with
generating a new application, If `some_view_name` already exists,
Vedeu will only write new files that do not exist at the file path.

    cd your_app_name
    vedeu view some_view_name

The generated files are skeleton Vedeu view files. Let's talk about
the files it will create and populate:

```bash
|
|- app_name/
|   |
    |- app/
    |   |- controllers/
    |   |   |- view_name_controller.rb
    |   |
    |   |- helpers/
    |   |   |- view_name_helper.rb
    |   |
    |   |- models/
    |   |   |- keymaps/
    |   |       |- view_name.rb
    |   |
    |   |- views/
    |       |- interfaces/
    |       |   |- view_name.rb
    |       |
    |       |- templates/
    |       |   |- view_name.erb
    |       |
    |       |- view_name.rb
    |...
```
