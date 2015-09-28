# @title Vedeu Configuration
# Vedeu Configuration

Vedeu provides a simple DSL for configuration.

    Vedeu.configure do

      # add configuration options here, each of which are listed
      # below...

    end

If you need to access the value of Vedeu's configuration for whatever
reason, simply ask for it:

    # => The current value of 'base_path'
    Vedeu.configuration.base_path

## Configuration Options

### base_path
{include:Vedeu::Config::API#base_path}

### colour_mode
{include:Vedeu::Config::API#colour_mode}

### compression / compression!
{include:Vedeu::Config::API#compression}

### cooked / cooked!
{include:Vedeu::Config::API#cooked}

### debug / debug!
{include:Vedeu::Config::API#debug}

### drb / drb!
{include:Vedeu::Config::API#drb}

### drb_host
{include:Vedeu::Config::API#drb_host}

### drb_port
{include:Vedeu::Config::API#drb_port}

### drb_height
{include:Vedeu::Config::API#drb_height}

### drb_width
{include:Vedeu::Config::API#drb_width}

### interactive / interactive!
{include:Vedeu::Config::API#interactive}

### log
{include:Vedeu::Config::API#log}

### log_only
{include:Vedeu::Config::API#log_only}

### raw / raw!
{include:Vedeu::Config::API#raw}

### renderer / renderers
{include:Vedeu::Config::API#renderer}

### root
{include:Vedeu::Config::API#root}

### run_once / run_once!
{include:Vedeu::Config::API#run_once}

### standalone / standalone!
{include:Vedeu::Config::API#standalone}

### stderr
{include:Vedeu::Config::API#stderr}

### stdin
{include:Vedeu::Config::API#stdin}

### stdout
{include:Vedeu::Config::API#stdout}

### terminal_mode
{include:Vedeu::Config::API#terminal_mode}
