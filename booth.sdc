###################################################################

# Created by write_sdc on Sun Apr 28 05:06:50 2024

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_max_area 0
set_load -pin_load 1.5 [get_ports {result_pro[15]}]
set_load -pin_load 1.5 [get_ports {result_pro[14]}]
set_load -pin_load 1.5 [get_ports {result_pro[13]}]
set_load -pin_load 1.5 [get_ports {result_pro[12]}]
set_load -pin_load 1.5 [get_ports {result_pro[11]}]
set_load -pin_load 1.5 [get_ports {result_pro[10]}]
set_load -pin_load 1.5 [get_ports {result_pro[9]}]
set_load -pin_load 1.5 [get_ports {result_pro[8]}]
set_load -pin_load 1.5 [get_ports {result_pro[7]}]
set_load -pin_load 1.5 [get_ports {result_pro[6]}]
set_load -pin_load 1.5 [get_ports {result_pro[5]}]
set_load -pin_load 1.5 [get_ports {result_pro[4]}]
set_load -pin_load 1.5 [get_ports {result_pro[3]}]
set_load -pin_load 1.5 [get_ports {result_pro[2]}]
set_load -pin_load 1.5 [get_ports {result_pro[1]}]
set_load -pin_load 1.5 [get_ports {result_pro[0]}]
