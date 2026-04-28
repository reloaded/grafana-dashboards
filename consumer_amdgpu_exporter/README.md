# consumer_amdgpu_exporter dashboards

Companion dashboards for
[reloaded/consumer_amdgpu_exporter](https://github.com/reloaded/consumer_amdgpu_exporter)
— a Prometheus exporter purpose-built for **consumer-grade AMD
GPUs** (RDNA / RDNA2 / RDNA3). Runs alongside the upstream
`rocm/device-metrics-exporter` instead of replacing it; the
companion role
[`metrics_consumer_amdgpu_exporter`](https://github.com/reloaded/ai-network/tree/main/ansible/roles/metrics_consumer_amdgpu_exporter)
in `reloaded/ai-network` deploys both side-by-side on AMD GPU
hosts.

## `dashboard.json`

Single-host / single-GPU view with twelve panels:

- **Identity**: `amdgpu_info` table (model, vbios, driver,
  pci_addr, revision; plus `amd-smi`-sourced uuid / vbios_date /
  market_name when that backend is enabled), performance level,
  GPU count.
- **Activity & temperature**: GPU + memory busy %; edge /
  junction / mem temperatures on a shared axis.
- **Power & fans**: power draw vs. cap (default TDP and current
  cap drawn as dashed reference lines); per-fan RPM and PWM%
  on twin axes.
- **Clocks & voltage**: active DPM step on every domain
  (sclk/mclk/fclk/socclk/vclk/dclk/pcie); voltage rails
  (vddgfx/vddnb).
- **Memory & PCIe**: VRAM used vs. total, GTT used, CPU-visible
  VRAM (BAR window), PCIe link speed (GT/s) + width (lanes).
- **Per-process**: top 10 processes by VRAM (table); per-engine
  busy as `rate()` of `amdgpu_process_engine_busy_seconds_total`,
  labelled with pid / comm / engine.

## Variables

| Variable | Source | Notes |
|---|---|---|
| `datasource` | Prometheus datasource picker | Default `Prometheus` |
| `host` | `label_values(amdgpu_nodes_total, instance)` | Multi-select, `All` default |
| `gpu` | `label_values(amdgpu_info{instance=~"$host"}, gpu)` | Multi-select, `All` default; values are sysfs DRM card IDs (`card0`, `card1`, …) |

## Pinning

Pin to a SHA from `metrics_core/defaults/main.yml`:

```yaml
consumer_amdgpu:
  enabled: true
  filename: consumer-amdgpu.json
  url: "https://raw.githubusercontent.com/reloaded/grafana-dashboards/<sha>/consumer_amdgpu_exporter/dashboard.json"
```
