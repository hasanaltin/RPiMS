#!/bin/bash

#  Author : Dariusz Kowalczyk
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License Version 2 as
#  published by the Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.

zabbix_server=$(awk -F= '/^ServerActive=/{print $2}' /etc/zabbix/zabbix_agentd.conf)
host_ip=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

case "$1" in

    'info_when_door_is_opened')
        zabbix_sender -z $zabbix_server -p 10051 -s "$host_ip" -k trap -o "The $2 is opened"
    ;;

    'info_when_door_is_closed')
        zabbix_sender -z $zabbix_server -p 10051 -s "$host_ip" -k trap -o "The $2 is closed"
    ;;

    'info_when_door_has_been_opened')
        zabbix_sender -z $zabbix_server -p 10051 -s "$host_ip" -k trap -o "The $2 has been opened"
    ;;

    'info_when_door_has_been_closed')
        zabbix_sender -z $zabbix_server -p 10051 -s "$host_ip" -k trap -o "The $2 has been closed"
    ;;

    'info_when_motion')
        zabbix_sender -z $zabbix_server -p 10051 -s "$host_ip" -k trap -o "The $2 motion was detected"
    ;;

    'info_when_no_motion')
        zabbix_sender -z $zabbix_server -p 10051 -s "$host_ip" -k trap -o "The $2 no motion"
    ;;

           *)
        echo -e "\nUsage: zabbix_sender.sh info_when_door_is_opened|info_when_door_is_closed|info_when_door_has_been_opened|info_when_door_has_been_closed|info_when_motion|info_when_no_motion"
    ;;

esac
