# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-mb-application_system/_ide/scripts/debugger_lab-6-mb-application-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-mb-application_system/_ide/scripts/debugger_lab-6-mb-application-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent PYNQ 210017480930A" && level==0 && jtag_device_ctx=="jsn-PYNQ-210017480930A-23727093-0"}
fpga -file /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-mb-application/_ide/bitstream/design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-mb-platform/export/lab-6-mb-platform/hw/design_1_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-mb-application/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-mb-application/Debug/lab-6-mb-application.elf
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /users/students/r0970173/embedded_systems_lab/lab-6/software/lab-6-zynq-application/Debug/lab-6-zynq-application.elf
configparams force-mem-access 0
bpadd -addr &main
