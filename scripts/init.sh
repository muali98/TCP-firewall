#!/bin/bash

CREATE_DIR_STRUCTURE=$1

print_info() {
    printf "\x1b[1;96mInfo\x1b[0;39m: $@\n"
}

# Setup the directory structure
# -----------------------------
if [ $CREATE_DIR_STRUCTURE == 1 ]; then
    print_info "Create the directory structure..."

    # environment
    mkdir -p $PRJ_ROOT/templates
    mkdir -p $PRJ_ROOT/scripts
    mkdir -p $PRJ_ROOT/vivado
    mkdir -p $PRJ_ROOT/software

    cp -a $PRJ_ROOT/embedded-systems-lab-template/scripts/init.sh $PRJ_ROOT/scripts/
    cp -a $PRJ_ROOT/embedded-systems-lab-template/scripts/vivado_init.tcl $PRJ_ROOT/scripts/
    cp -a $PRJ_ROOT/embedded-systems-lab-template/gitignore/.gitignore $PRJ_ROOT/
    cp -a $PRJ_ROOT/embedded-systems-lab-template/board_files $PRJ_ROOT/

    # templates
    cp -a $PRJ_ROOT/embedded-systems-lab-template/templates/${PRJ_ROOT_DIR}/. $PRJ_ROOT/templates/
    
    # remove the computer architecture lab template folder
    rm -rf $PRJ_ROOT/embedded-systems-lab-template
fi

# Setup the python virtual environment
# ------------------------------------
if [ ! -d $PRJ_ROOT/${PRJ_ROOT_DIR}-venv ]; then
    print_info "Create and activate the python virtual environment (packages are also installed)..."

    # setting up the python virtual environment
    cd $PRJ_ROOT
    python3 -m venv ${PRJ_ROOT_DIR}-venv
    source $PRJ_ROOT/${PRJ_ROOT_DIR}-venv/bin/activate

    # installing packages
    python3 -m pip install --upgrade pip
    pip install pyserial
else
    print_info "Activate the existing python virtual environment..."
    source $PRJ_ROOT/${PRJ_ROOT_DIR}-venv/bin/activate
fi

# Xilinx Vivado (2021.2)
# ----------------------
print_info "Set up Xilinx Vivado 2021.2..."
source ~micasusr/design/scripts/xilinx_vitis_2021.2.rc
