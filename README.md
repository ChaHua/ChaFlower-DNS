Unbound (with DNSSEC validation)
===========
[![Build Status](https://travis-ci.org/obi12341/docker-unbound.svg?branch=master)](https://travis-ci.org/obi12341/docker-unbound)

# Running

Clone dnsmasq-china-list into assets folder.

```git clone https://github.com/felixonmars/dnsmasq-china-list assets/dnsmasq-china-list```

Modify Makefile and build the conf file for unbound.

```cp assets/Makefile assets/dnsmasq-china-list/ && cd assets/dnsmasq-china-list && make unbound```

Run with docker-compose

```docker-compose up -d```

# Configuration
These options can be set:

- **DO_IPV6**: Enable or disable ipv6. (Default: "yes", Possible Values: "yes, no")
- **DO_IPV4**: Enable or disable ipv4. (Default: "yes", Possible Values: "yes, no")
- **DO_UDP**: Enable or disable udp. (Default: "yes", Possible Values: "yes, no")
- **DO_TCP**: Enable or disable tcp. (Default: "yes", Possible Values: "yes, no")
- **VERBOSITY**: Verbosity number, 0 is least verbose. (Default: "0", Possible Values: "<integer>")
- **NUM_THREADS**: Number of threads to create. 1 disables threading. (Default: "1", Possible Values: "<integer>")
- **SO_RCVBUFF**: Buffer size for UDP port 53 incoming. Use 4m to catch query spikes for busy servers. (Default: "0", Possible Values: "<integer>")
- **SO_SNDBUF**: Buffer size for UDP port 53 outgoing. Use 4m to handle spikes on very busy servers. (Default: "0", Possible Values: "<integer>")
- **SO_REUSEPORT**: Use SO_REUSEPORT to distribute queries over threads. (Default: "no", Possible Values: "yes, no")
- **EDNS_BUFFER_SIZE**: EDNS reassembly buffer to advertise to UDP peers. 1480 can solve fragmentation (timeouts). (Default: "4096", Possible Values: "<integer>")
- **MSG_CACHE_SIZE**: The amount of memory to use for the message cache. Plain value in bytes or you can append k, m or G. (Default: "4m", Possible Values: "<integer>")
- **RRSET_CACHE_SIZE**: The amount of memory to use for the RRset cache. Plain value in bytes or you can append k, m or G. (Default: "4m", Possible Values: "<integer>")
- **CACHE_MIN_TTL**: The time to live (TTL) value lower bound, in seconds. If more than an hour could easily give trouble due to stale data. (Default: "0", Possible Values: "<integer>")
- **CACHE_MAX_TTL**: The time to live (TTL) value cap for RRsets and messages in the cache. Items are not cached for longer. In seconds. (Default: "86400", Possible Values: "<integer>")
- **CACHE_MAX_NEGATIVE_TTL**: The time to live (TTL) value cap for negative responses in the cache. (Default: "3600", Possible Values: "<integer>")
- **HIDE_IDENTITY**: Enable to not answer id.server and hostname.bind queries. (Default: "no", Possible Values: "yes, no")
- **HIDE_VERSION**: Enable to not answer version.server and version.bind queries. (Default: "no", Possible Values: "yes, no")
- **STATISTICS_INTERVAL**: print statistics to the log (for every thread) every N seconds. (Default: "0", Possible Values: "0, 1")
- **STATISTICS_CUMULATIVE**: enable cumulative statistics, without clearing them after printing. (Default: "no", Possible Values: "yes, no")
- **EXTENDED_STATISTICS**: enable extended statistics (query types, answer codes, status) printed from unbound-control. (Default: "no", Possible Values: "yes, no")
