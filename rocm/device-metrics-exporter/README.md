# github.com/ROCm/device-metrics-exporter Grafana Dashboards

These dashboards are customized versions of the ones provided by [rocm/device-metrics-exporter](https://github.com/ROCm/device-metrics-exporter) for my own home lab running consumer grade AMD GPUs like the RX 7900 XTX 24GB.

Since I'm running on consumer grade GPUs and not datacenter GPUs not every metric provided by rocm/device-metrics-exporter are available, but a handful are available for consumption. Because of the consumer vs datacenter GPU differences I had to customize this dashboard with the below changes.

Run these search/replaces in exactly this order:

- Replace `gpu_uuid=\"$g_gpu_uuid\", gpu_id=\"$g_gpu_id\"`
    with `hostname=~\"$g_hostname|.*\", gpu_id=~\"$g_gpu_id|.*\"`
- Replace `gpu_uuid=\"$g_gpu_uuid\", hostname=\"$g_hostname\", gpu_id=\"$g_gpu_id\"` 
    with `hostname=~\"$g_hostname|.*\", gpu_id=~\"$g_gpu_id|.*\"`
- Replace `gpu_uuid=\"$g_gpu_uuid\", card_model=~\"102-D65208-0C|102-D67305-00|102-D65209-0C\", gpu_id=\"$g_gpu_id\"` 
    with `hostname=~\"$g_hostname|.*\", card_model=~\"102-D65208-0C|102-D67305-00|102-D65209-0C\", gpu_id=~\"$g_gpu_id|.*\"`
- Replace `gpu_uuid=\"$g_gpu_uuid\", card_model!~\"102-D65208-0C|102-D67305-00|102-D65209-0C\", gpu_id=\"$g_gpu_id\"` 
    with `hostname=~\"$g_hostname|.*\", card_model!~\"102-D65208-0C|102-D67305-00|102-D65209-0C\", gpu_id=\"$g_gpu_id\"`
- Replace `gpu_uuid=\"$g_gpu_uuid\", card_model=~\"102-G30211-00|102-G30211-0C|102-G30211-4C|102-G30212-0C|102-G30213-00|102-G30213-0C\", gpu_id=\"$g_gpu_id\"`
    with `hostname=~\"$g_hostname|.*\", card_model=~\"102-G30211-00|102-G30211-0C|102-G30211-4C|102-G30212-0C|102-G30213-00|102-G30213-0C\", gpu_id=\"$g_gpu_id\"`
- Replace `gpu_uuid=\"$g_gpu_uuid\", card_model!~\"102-G30211-00|102-G30211-0C|102-G30211-4C|102-G30212-0C|102-G30213-00|102-G30213-0C\", gpu_id=\"$g_gpu_id\"`
    with `hostname=~\"$g_hostname|.*\", card_model!~\"102-G30211-00|102-G30211-0C|102-G30211-4C|102-G30212-0C|102-G30213-00|102-G30213-0C\", gpu_id=\"$g_gpu_id\"`
- Replace `gpu_uuid=\"$g_gpu_uuid\", hostname=\"$g_hostname\"`
    with `gpu_id=~\"$g_gpu_id|.*\", hostname=\"$g_hostname\"`
- Replace `gpu_id=\"$g_gpu_id\"` 
    with `gpu_id=~\"$g_gpu_id|.*\"`
- Replace `hostname=\"$g_hostname\"` 
    with `hostname=~\"$g_hostname|.*\"`
- Replace `gpu_uuid=\"$g_gpu_uuid\"` 
    with `gpu_id=~\"$g_gpu_id|.*\"`