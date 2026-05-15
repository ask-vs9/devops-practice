#!/bin/bash
# Day 17 – Task 4 & 5b: Install packages with root check + error handling

# check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script as root."
        echo "Usage: sudo ./install_packages.sh"
            exit 1
            fi

            PACKAGES=("nginx" "curl" "wget")

            echo "Starting package installation check..."
            echo "======================================="

           for pkg in "${PACKAGES[@]}"; do
                if dpkg -s "$pkg" &> /dev/null; then
                        echo "[$pkg] Already installed -- skipping."
                            else
                                    echo "[$pkg] Not found. Installing..."
                                            apt install -y "$pkg" &> /dev/null && echo "[$pkg] Installed successfully." || echo "[$pkg] Installation failed."
                                                fi
                                                done

                                                echo "======================================="
                                                echo "Done."
