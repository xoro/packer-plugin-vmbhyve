#!/bin/sh

export PACKER_LOG="1"
export PACKER_LOG_PATH="log/packer.log"
script_name="$(basename "${0}")"

# Build the packer plugin
printf "%b %b INFO:  Building the packer plugin:\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"
if ! (cd .. && go build; cd -); then
    printf "%b %b ERROR: ==>> FAILED\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"
    exit 1
fi
printf "%b %b INFO:  ==>> SUCCEDED\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"

# Initialize the plugin
printf "%b %b INFO:  Initializing the plugin:\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"
if ! packer init .; then
    printf "%b %b ERROR: ==>> FAILED\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"
    exit 2
fi
printf "%b %b INFO:  ==>> SUCCEDED\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"

# Validate the configuration
printf "%b %b INFO:  Validating the configuration:\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"
if ! packer validate .; then
    printf "%b %b ERROR: ==>> FAILED\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"
    exit 3
fi
printf "%b %b INFO:  ==>> SUCCEDED\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"

# Build the configuration
printf "%b %b INFO:  Building the packer example configuration:\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"
if ! packer build .; then
    printf "%b %b ERROR: ==>> FAILED\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"
    exit 4
fi
printf "%b %b INFO:  ==>> SUCCEDED\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${script_name}"

exit 0
