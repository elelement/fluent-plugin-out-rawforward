# Forward Raw Messages for Fluentd

Used to forward anything collected by Fluentd into a TCP port, without any post encoding or post input modification. Specially useful to send commands to a Telnet server.

It has been tested sending "put" commands to a Kairosdb server, to its Telnet interface.


## Installation

```
gem install fluent-plugin-out_rawforward
```

## Usage

```xml
 <source>
    @type forward
    bind 0.0.0.0
    port 24224
</source>

<match **>
    type rawforward
    buffer_type file
    buffer_path /var/log/fluent/raw_forward_buffer
    <server>
        name my_server
        host localhost
        port 4242
    </server>
</match>
```

Multiple `<server>` entries may be configured, but only the first one responding will be used. The source message must be a valid JSON containing a "log" key:

```
2017-07-24 19:14:23 +0300 uc.read.example: {"log":"put example_3_2_movement_door 1500912863 0 name=movement_door type=3 device=3 uc=example"}
```

## Testing

To test:
```
bundle exec rake test
```

## Acknowledgement

Based on Uken's fluent-plugin-out_rawtcp plugin (https://github.com/uken/fluent-plugin-out_rawtcp).

