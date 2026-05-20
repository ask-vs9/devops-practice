#!/bin/bash

service_name="nginx"

read -p "Do you want to check the status? (y/n): " choice

if [ "$choice" = "y" ]; then
    systemctl status $service_name

        if systemctl is-active --quiet $service_name; then
                echo "$service_name is active"
                    else
                            echo "$service_name is not active"
                                fi

                                else
                                    echo "Skipped."
                                    fi
