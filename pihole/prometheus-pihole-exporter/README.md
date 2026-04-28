# Pi-hole — DNS + DHCP

Grafana dashboard for [`prometheus_pihole_exporter`](https://github.com/reloaded/prometheus_pihole_exporter), a Prometheus exporter for Pi-hole v6.

## Coverage

The dashboard is split into five rows; each panel honours the `instance` template variable so you can scope to a single Pi-hole or view all of them at once.

- **Status** — `pihole_up`, today's totals (queries / blocked / clients / gravity domains), block ratio gauge, blocking on/off
- **DNS** — query rate (total / blocked / forwarded / cached), query type breakdown, reply-type breakdown, FTL-status breakdown
- **Upstreams** — per-upstream query rate + reported response time
- **FTL runtime** — CPU %, memory %, scrape duration
- **DHCP** — active / expired leases by family, message rate (`DHCPACK / NAK / OFFER / REQUEST / DECLINE / RELEASE / DISCOVER / INFORM`), time since last DHCP event, leases-by-family table
- **Health** (collapsed by default) — per-collector `pihole_collector_up`, component versions table

## Required metrics

The dashboard expects every metric the exporter emits at `v0.1.0`:

```
pihole_up
pihole_scrape_duration_seconds
pihole_collector_up{collector}
pihole_info{core_version,ftl_version,web_version}
pihole_dns_queries_total
pihole_dns_queries_blocked_total
pihole_dns_queries_forwarded_total
pihole_dns_queries_cached_total
pihole_dns_queries_blocked_ratio
pihole_dns_queries_unique_domains
pihole_dns_queries_per_second
pihole_dns_queries_by_type_total{type}
pihole_dns_queries_by_status_total{status}
pihole_dns_queries_by_reply_total{reply}
pihole_dns_clients_active
pihole_dns_clients_total
pihole_blocking_enabled
pihole_gravity_domains
pihole_gravity_last_update_timestamp_seconds
pihole_dns_upstream_queries_total{upstream,ip,port}
pihole_dns_upstream_response_seconds
pihole_dns_upstream_response_variance_seconds
pihole_ftl_privacy_level
pihole_ftl_memory_percent
pihole_ftl_cpu_percent
pihole_ftl_clients_active
pihole_ftl_clients_total
pihole_dnsmasq_cache_inserted_total
pihole_dnsmasq_cache_live_freed_total
pihole_dnsmasq_queries_forwarded_total
pihole_dhcp_leases_active{family}
pihole_dhcp_leases_expired{family}
pihole_dhcp_leases_total{family}
pihole_dhcp_lease_info{mac,ip,hostname,family}
pihole_dhcp_lease_expires_timestamp_seconds
pihole_dhcp_messages_total{type}
pihole_dhcp_log_parse_errors_total
pihole_dhcp_log_last_event_timestamp_seconds
```

The exporter's [README](https://github.com/reloaded/prometheus_pihole_exporter/blob/main/README.md) describes the per-collector toggles — DHCP collectors are off by default and require the exporter to have read access to the leases file / dnsmasq log.

## Multi-instance

The `instance` variable is populated from `label_values(pihole_up, instance)`. Each Pi-hole the exporter knows about (one entry per `instances:` key in the exporter's YAML config) shows up here automatically. Multi-select + an "All" entry are enabled, so the same dashboard renders cleanly with one Pi-hole today and an active-passive pair tomorrow.

## Compatibility

- Schema version 39 (Grafana 11+).
- Prometheus datasource picked via the `datasource` template variable; works with any datasource that accepts the standard `${datasource}` syntax.
