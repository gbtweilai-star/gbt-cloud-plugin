#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_cloud_plugin info
PYTHONPATH=src python -m gbt_cloud_plugin check --payload '{}'
PYTHONPATH=src python -m gbt_cloud_plugin run   --payload '{}'
