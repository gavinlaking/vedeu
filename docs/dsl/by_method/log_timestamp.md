### Vedeu.log_timestamp

Returns a formatted timestamp indicating the number of seconds the
client application has been running.

The first time this method is called, it will return `[ 0.0000] `.
Subsequent calls will be relative to this first time entry.

    Vedeu.log_timestamp # => [137.7842]
