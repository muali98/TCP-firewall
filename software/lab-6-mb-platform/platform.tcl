# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-mb-platform/platform.tcl
# 
# OR launch xsct and run below command.
# source /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-mb-platform/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {lab-6-mb-platform}\
-hw {/users/students/r0970173/embedded_systems_lab/lab-6/vivado/design_1_wrapper.xsa}\
-proc {microblaze_0} -os {standalone} -out {/users/students/r0970173/embedded_systems_lab/lab-6/software}

platform write
platform generate -domains 
platform active {lab-6-mb-platform}
platform generate
platform generate
