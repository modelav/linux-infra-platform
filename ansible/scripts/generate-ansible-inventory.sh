#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TERRAFORM_DIR="${ROOT_DIR}/terraform"
INVENTORY_DIR="${ROOT_DIR}/ansible/inventory"

BOOTSTRAP_INVENTORY="${INVENTORY_DIR}/bootstrap.generated.ini"
NORMAL_INVENTORY="${INVENTORY_DIR}/hosts.generated.ini"

require_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "ERROR: '$1' is required but was not found." >&2
        exit 1
    fi
}

require_command terraform
require_command jq

mkdir -p "$INVENTORY_DIR"

echo "==> Reading Terraform outputs..."

terraform_output="$(
    terraform -chdir="$TERRAFORM_DIR" output -json
)"

app_public_ip="$(jq -er '.app_server_public_ip.value' <<< "$terraform_output")"
app_private_ip="$(jq -er '.app_server_private_ip.value' <<< "$terraform_output")"

monitoring_public_ip="$(jq -er '.monitoring_server_public_ip.value' <<< "$terraform_output")"
monitoring_private_ip="$(jq -er '.monitoring_server_private_ip.value' <<< "$terraform_output")"

echo "==> Generating bootstrap inventory..."

cat > "$BOOTSTRAP_INVENTORY" <<EOF
[app]
app_server ansible_host=${app_public_ip} private_ip=${app_private_ip}

[monitoring]
monitoring_server ansible_host=${monitoring_public_ip} private_ip=${monitoring_private_ip}

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_ed25519

EOF

echo "==> Generating normal inventory..."

cat > "$NORMAL_INVENTORY" <<EOF
[app]
app_server ansible_host=${app_public_ip} private_ip=${app_private_ip}

[monitoring]
monitoring_server ansible_host=${monitoring_public_ip} private_ip=${monitoring_private_ip}

[all:vars]
ansible_user=admin
EOF

echo
echo "Generated:"
echo "  ${BOOTSTRAP_INVENTORY}"
echo "  ${NORMAL_INVENTORY}"