# --------------------------------
# Initialization script for Vivado
# --------------------------------
# removing the old board files
set_param board.repoPaths ""
# add the new board files (this way we ensure always to have the correct board files for every lab)
set PRJ_ROOT_LOCATION $env(PRJ_ROOT)
set_param board.repoPaths $PRJ_ROOT_LOCATION/board_files/pynq-z2
unset PRJ_ROOT_LOCATION