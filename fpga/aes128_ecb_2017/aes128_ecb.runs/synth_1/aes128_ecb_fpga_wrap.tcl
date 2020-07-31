# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7k325tffg900-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.cache/wt [current_project]
set_property parent.project_path /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part xilinx.com:kc705:part0:1.5 [current_project]
set_property ip_output_repo /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  /home/user/aes128/src/aes128_enc.sv
  /home/user/aes128/src/wrap/axi_interface.sv
  /home/user/aes128/src/wrap/system_manager.sv
  /home/user/aes128/src/wrap/aes128_ecb_fpga_wrap.sv
}
read_ip -quiet /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen.xci
set_property used_in_implementation false [get_files -all /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen_board.xdc]
set_property used_in_implementation false [get_files -all /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen.xdc]
set_property used_in_implementation false [get_files -all /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen_ooc.xdc]

read_ip -quiet /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/sources_1/ip/axi_uartlite_module/axi_uartlite_module.xci
set_property used_in_implementation false [get_files -all /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/sources_1/ip/axi_uartlite_module/axi_uartlite_module_board.xdc]
set_property used_in_implementation false [get_files -all /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/sources_1/ip/axi_uartlite_module/axi_uartlite_module_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/sources_1/ip/axi_uartlite_module/axi_uartlite_module.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/constrs_1/new/pinout.xdc
set_property used_in_implementation false [get_files /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/constrs_1/new/pinout.xdc]

read_xdc /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/constrs_1/new/timings.xdc
set_property used_in_implementation false [get_files /home/user/aes128/fpga/aes128_ecb_2017/aes128_ecb.srcs/constrs_1/new/timings.xdc]


synth_design -top aes128_ecb_fpga_wrap -part xc7k325tffg900-2


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef aes128_ecb_fpga_wrap.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file aes128_ecb_fpga_wrap_utilization_synth.rpt -pb aes128_ecb_fpga_wrap_utilization_synth.pb"
