#!/bin/bash

function top_apps() {
    echo "Top 10 Most Used Applications:"
    ps aux --sort=-%cpu | head -n 11 | awk '{print $1, $3, $4, $11}' | column -t
    echo ""
}

# network monitoring 

function network_monitoring() {
    echo "Network Monitoring:"
    echo "Concurrent connections:"
    netstat -an | grep ESTABLISHED | wc -l
    echo "Packet drops:"
    netstat -i | grep -E '^\w+' | awk '{print $1, $4, $5}' | column -t
    echo "MB in/out:"
    vnstat --oneline | awk -F';' '{print "In: " $2 " MB, Out: " $3 " MB"}'
    echo ""
}

# Disk usage 

function disk_usage() {
    echo "Disk Usage:"
    df -h | awk '{print $1, $5}' | column -t
    echo ""
}

# System Load 

function system_load() {
    echo "System Load:"
    uptime
    echo "CPU Usage:"
    mpstat | awk 'NR==4 {print "User:", $3, "System:", $5, "Idle:", $12}'
    echo ""
}

# Memory usage 

function memory_usage() {
    echo "Memory Usage:"
    free -h
    echo ""
}

# Process Monitoring

function process_monitoring() {
    echo "Process Monitoring:"
    echo "Number of active processes:"
    ps aux | wc -l
    echo "Top 5 processes by CPU usage:"
    ps aux --sort=-%cpu | head -n 6 | awk '{print $1, $3, $11}' | column -t
    echo "Top 5 processes by memory usage:"
    ps aux --sort=-%mem | head -n 6 | awk '{print $1, $4, $11}' | column -t
    echo ""
}

# Service Monitoring 

function service_monitoring() {
    echo "Service Monitoring:"
    for service in sshd nginx apache2 iptables; do
        systemctl is-active --quiet $service && echo "$service: Running" || echo "$service: Not Running"
    done
    echo ""
}

# Custom Dashboard with Command-Line Switches

function show_dashboard() {
    case "$1" in
        -cpu) top_apps ;;
        -network) network_monitoring ;;
        -disk) disk_usage ;;
        -load) system_load ;;
        -memory) memory_usage ;;
        -process) process_monitoring ;;
        -services) service_monitoring ;;
        *) echo "Usage: $0 {-cpu|-network|-disk|-load|-memory|-process|-services}" ;;
    esac
}

if [ "$#" -eq 0 ]; then
    echo "No arguments provided. Displaying full dashboard."
    top_apps
    network_monitoring
    disk_usage
    system_load
    memory_usage
    process_monitoring
    service_monitoring
else
    show_dashboard "$1"
fi

