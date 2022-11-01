#!/usr/bin/env bash

# This file should not change unless the CIS benchmark for Bottlerocket changes
# If changes are needed, perform a Docker build and push the image to the shared ECR repo

# Flush iptables rules
iptables -F

# 3.4.1.1 Ensure IPv4 default deny firewall policy (Automated)
#iptables -P INPUT DROP # this is need to allows K8s use cases such as kubectl exec/logs
ptables -P OUTPUT DROP
iptables -P FORWARD DROP

# 3.4.1.2 Ensure IPv4 loopback traffic is configured (Automated)
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -s 127.0.0.0/8 -j DROP

# 3.4.1.3 Ensure IPv4 outbound and established connections are configured (Manual)
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT

# Flush ip6tables rules 
ip6tables -F

# 3.4.2.1 Ensure IPv6 default deny firewall policy (Automated)
#ip6tables -P INPUT DROP # this is need to allows K8s use cases such as kubectl exec/logs
ip6tables -P OUTPUT DROP
ip6tables -P FORWARD DROP

# 3.4.2.2 Ensure IPv6 loopback traffic is configured (Automated)
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT
ip6tables -A INPUT -s ::1 -j DROP

# 3.4.2.3 Ensure IPv6 outbound and established connections are configured (Manual)
ip6tables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT
ip6tables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
ip6tables -A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT
ip6tables -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT