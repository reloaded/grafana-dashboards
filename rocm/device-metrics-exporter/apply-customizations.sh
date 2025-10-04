#!/bin/bash
set -euo pipefail

file="$1"
bak="${file}.bak.$(date +%s)"
cp -a "$file" "$bak"
echo "[*] Backup written to $bak"

# Apply ordered replacements
sed -E \
  -e 's/gpu_uuid=\\"[$]g_gpu_uuid\\", gpu_id=\\"[$]g_gpu_id\\"/hostname=~\\"$g_hostname|.*\\", gpu_id=~\\"$g_gpu_id|.*\\"/g' \
  -e 's/gpu_uuid=\\"[$]g_gpu_uuid\\", hostname=\\"[$]g_hostname\\", gpu_id=\\"[$]g_gpu_id\\"/hostname=~\\"$g_hostname|.*\\", gpu_id=~\\"$g_gpu_id|.*\\"/g' \
  -e 's/gpu_uuid=\\"[$]g_gpu_uuid\\", card_model=~\\"102-D65208-0C\|102-D67305-00\|102-D65209-0C\\", gpu_id=\\"[$]g_gpu_id\\"/hostname=~\\"$g_hostname|.*\\", card_model=~\\"102-D65208-0C|102-D67305-00|102-D65209-0C\\", gpu_id=~\\"$g_gpu_id|.*\\"/g' \
  -e 's/gpu_uuid=\\"[$]g_gpu_uuid\\", card_model!~\\"102-D65208-0C\|102-D67305-00\|102-D65209-0C\\", gpu_id=\\"[$]g_gpu_id\\"/hostname=~\\"$g_hostname|.*\\", card_model!~\\"102-D65208-0C|102-D67305-00|102-D65209-0C\\", gpu_id=\\"$g_gpu_id\\"/g' \
  -e 's/gpu_uuid=\\"[$]g_gpu_uuid\\", card_model=~\\"102-G30211-00\|102-G30211-0C\|102-G30211-4C\|102-G30212-0C\|102-G30213-00\|102-G30213-0C\\", gpu_id=\\"[$]g_gpu_id\\"/hostname=~\\"$g_hostname|.*\\", card_model=~\\"102-G30211-00|102-G30211-0C|102-G30211-4C|102-G30212-0C|102-G30213-00|102-G30213-0C\\", gpu_id=\\"$g_gpu_id\\"/g' \
  -e 's/gpu_uuid=\\"[$]g_gpu_uuid\\", card_model!~\\"102-G30211-00\|102-G30211-0C\|102-G30211-4C\|102-G30212-0C\|102-G30213-00\|102-G30213-0C\\", gpu_id=\\"[$]g_gpu_id\\"/hostname=~\\"$g_hostname|.*\\", card_model!~\\"102-G30211-00|102-G30211-0C|102-G30211-4C|102-G30212-0C|102-G30213-00|102-G30213-0C\\", gpu_id=\\"$g_gpu_id\\"/g' \
  -e 's/gpu_uuid=\\"[$]g_gpu_uuid\\", hostname=\\"[$]g_hostname\\"/gpu_id=~\\"$g_gpu_id|.*\\", hostname=\\"$g_hostname\\"/g' \
  -e 's/gpu_id=\\"[$]g_gpu_id\\"/gpu_id=~\\"$g_gpu_id|.*\\"/g' \
  -e 's/hostname=\\"[$]g_hostname\\"/hostname=~\\"$g_hostname|.*\\"/g' \
  -e 's/gpu_uuid=\\"[$]g_gpu_uuid\\"/gpu_id=~\\"$g_gpu_id|.*\\"/g' \
  "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"

echo "[✓] Updated $file"

rm "$bak"