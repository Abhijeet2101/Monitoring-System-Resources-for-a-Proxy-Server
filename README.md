# Monitoring System Resources for Proxy Server

## Overview
This script monitors various system resources and presents them in a dashboard format. It updates the data every few seconds and allows users to view specific parts of the dashboard using command-line switches.

## Usage
Make sure the script is executable:
```bash
chmod +x monitor.sh

# View Full Dashboard
./monitor.sh

# View Specific Sections
# CPU usage
./monitor.sh -cpu

# Network Monitoring:

./monitor.sh -network

# Disk Usage:

./monitor.sh -disk

# System Load:

./monitor.sh -load

# Memory Usage:

./monitor.sh -memory

# Process Monitoring:

./monitor.sh -process

# Service Monitoring:

./monitor.sh -services
