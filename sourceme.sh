#!/bin/bash

#-----------#
# Variables #
#-----------#
EMBEDDED_SYSTEMS_LAB_TEMPLATE_URL="https://gitlab.kuleuven.be/campus-geel/embedded-systems-lab-za5499-za5512/lab-template/embedded-systems-lab-template.git"

#-----------#
# Functions #
#-----------#
print_info() {
    printf "\x1b[1;96mInfo\x1b[0;39m: $@\n"
}
print_error() {
    printf "\x1b[1;91mError\x1b[0;39m: $@\n"
}

get_embedded_systems_lab_template() {
    print_info "Updating from Embedded Systems Lab Template..."
    
    git clone $EMBEDDED_SYSTEMS_LAB_TEMPLATE_URL
    git_status=$?

    # Check if git clone went as planned
    if [ $git_status -ne 0 ]; then
        print_error "Failed to update from Embedded Systems Lab Template!"
        return 1
    fi
}

#-------------#
# Main script #
#-------------#
if [ -n "${PRJ_ROOT+set}" ]; then
    print_error "Script was already sourced!"
    return 1
else
    # environment variables
    export PRJ_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    export PRJ_ROOT_DIR=$(basename "${PRJ_ROOT}")

    # alias for Vivado
    alias vivado='vivado -source $PRJ_ROOT/scripts/vivado_init.tcl'
    # scratch folder location
    alias embedded_systems_lab='cd /esat/cg-scratch/$USER/embedded_systems_lab'

    # change directory to the project root
    cd "$PRJ_ROOT"

    # get the embedded systems lab template
    if [ ! -d $PRJ_ROOT/scripts ]; then
        get_embedded_systems_lab_template
        if [ $? -eq 1 ]; then # check the return value of the get_embedded_systems_lab_template function
            unset PRJ_ROOT
            unalias vivado
            return 1
        else
            # source the init.sh script
            source $PRJ_ROOT/embedded-systems-lab-template/scripts/init.sh 1
        fi
    else
        # source the init.sh script
        source $PRJ_ROOT/scripts/init.sh 0
    fi
fi
