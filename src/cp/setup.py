import socket
import sys
import os
import time
import math

LOOPBACK_PORT = 196

hostname = socket.gethostname()
print("Hostname: {}".format(hostname))
fp_port_configs=None
l2_forward_configs=None
active_dev_ports = None


if hostname == 'P4-2':
    fp_port_configs = [
                    ('1/0', '100G', 'NONE', 2),    
                    ('2/0', '100G', 'NONE', 2), 
                    # more config with your topology
                    ]
    l2_forward_configs =[]



def add_port_config(port_config):
    speed_dict = {'10G':'BF_SPEED_10G', '25G':'BF_SPEED_25G', '40G':'BF_SPEED_40G', '100G':'BF_SPEED_100G'}
    fec_dict = {'NONE':'BF_FEC_TYP_NONE', 'FC':'BF_FEC_TYP_FC', 'RS':'BF_FEC_TYP_RS'}
    an_dict = {0:'PM_AN_DEFAULT', 1:'PM_AN_FORCE_ENABLE', 2:'PM_AN_FORCE_DISABLE'}
    lanes_dict = {'10G':(0,1,2,3), '25G':(0,1,2,3), '40G':(0,), '50G':(0,2), '100G':(0,)}
    
    # extract and map values from the config first
    conf_port = int(port_config[0].split('/')[0])
    lane = port_config[0].split('/')[1]
    conf_speed = speed_dict[port_config[1]]
    conf_fec = fec_dict[port_config[2]]
    conf_an = an_dict[port_config[3]]


    if lane == '-': # need to add all possible lanes
        lanes = lanes_dict[port_config[1]]
        for lane in lanes:
            dp = bfrt.port.port_hdl_info.get(CONN_ID=conf_port, CHNL_ID=lane, print_ents=False).data[b'$DEV_PORT']
            bfrt.port.port.add(DEV_PORT=dp, SPEED=conf_speed, FEC=conf_fec, AUTO_NEGOTIATION=conf_an, PORT_ENABLE=True)
    else: # specific lane is requested
        conf_lane = int(lane)
        dp = bfrt.port.port_hdl_info.get(CONN_ID=conf_port, CHNL_ID=conf_lane, print_ents=False).data[b'$DEV_PORT']
        bfrt.port.port.add(DEV_PORT=dp, SPEED=conf_speed, FEC=conf_fec, AUTO_NEGOTIATION=conf_an, PORT_ENABLE=True)



def set_expert_forward_table(l2_forward_configs):
    table = bfrt.loadbalance.pipe.SwitchIngress.forward_table
    for l2_forward_config in l2_forward_configs:
        table.add_with_expert_forward(*l2_forward_config)

    


def set_reg_val():
    ingress = bfrt.loadbalance.pipe.SwitchIngress
    ingress.port_counter_0.mod(0,1);
    ingress.port_counter_1.mod(0,1);
    ingress.port_counter_2.mod(0,1);
    ingress.port_counter_3.mod(0,1);
    ingress.packets_counter.mod(0,4);
    # ingress.port_counter_4.mod(0,1);
    # ingress.port_counter_5.mod(0,1);
    # ingress.port_counter_6.mod(0,1);
    # ingress.port_counter_7.mod(0,1);

def set_last_expert_table():
    table = bfrt.loadbalance.pipe.SwitchIngress.last_device_id_table
    for experts in range(255):
        if experts == 0:
            continue
        device_index = experts.bit_length() - 1
        table.add_with_get_last_device_id(experts,device_index)

def create_8_copy_multicast_group(target_port):
    for i in range(8):
        # bfrt.pre.node.add(multicast_node_id=i, multicast_rid=i+1, multicast_lag_id=[], dev_port=[target_port])
        bfrt.pre.node.add(i,i+1,[],[target_port])

    # bfrt.pre.mgid.add(mgid=777, multicast_node_id=[0,1,2,3], multicast_node_l1_xid_valid=[False], multicast_node_l1_xid=[0])
    bfrt.pre.mgid.add(777,[i for i in range(8)],[False]*8,[0]*8)



if hostname == 'P4-2':
    for port_config in fp_port_configs:
        add_port_config(port_config)

set_reg_val()
set_last_expert_table()
set_expert_forward_table(l2_forward_configs)
create_8_copy_multicast_group(LOOPBACK_PORT)

print('setup over')
