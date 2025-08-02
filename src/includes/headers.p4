#pragma once
/* for random number generation */

#define EXPERT_CAPACITY 65536 // Capacity of the expert 
#define PORT_COUNT 4
#define COUNTER_WIDE 32	// wide for a couter register
#define MAX_EXPERT_COUNT 256
#define TOP_K  4
#define FOUR_WAY_MCAST_GROUP 777; 
#define LOOPBACK_PORT 64

typedef bit<32> INAData_t; // uint32
typedef bit<8> DeviceBitmap_t;
typedef bit<3> DeviceId_t;
typedef bit<8> TokenId_t;
typedef bit<COUNTER_WIDE> Counter_t;





header ethernet_h {
    bit<48>   dst_addr;
    bit<48>   src_addr;
    bit<16>   ether_type;
}

header vlan_tag_h {
    bit<3>   pcp;
    bit<1>   cfi;
    bit<12>  vid;
    bit<16>  ether_type;
}

header ipv4_h {
    bit<4>   version;
    bit<4>   ihl;
    bit<8>   diffserv;
    bit<16>  total_len;
    bit<16>  identification;
    bit<3>   flags;
    bit<13>  frag_offset;
    bit<8>   ttl;
    bit<8>   protocol;
    bit<16>  hdr_checksum;
    bit<32>  src_addr;
    bit<32>  dst_addr;
}

header udp_h {
    bit<16>  src_port;
    bit<16>  dst_port;
    bit<16>  len;
    bit<16>  checksum;
}

header SwitchMoE_h{
    bit<8> type;
}

header ROUTING_h{
    bit<16> top_0;   // 1001_0001 limited by the tofino stage
    bit<16> top_1;   
    bit<16> top_2;
    bit<16> top_3;
    bit<16> top_4;
    bit<16> top_5;
    bit<16> top_6;
    bit<16> top_7;
    bit<16> expert_id;   // 0 1 2 3
    bit<8> is_recirc;
}

header UPDATE_h{
    bit<16> expert_id;  // 0 1 2 3
    bit<8> device_bitmap;   // 1001_1000;
}

header INA_h {
    bit<8> token_id;
    INAData_t data0;
    INAData_t data1;
    INAData_t data2;
    INAData_t data3;
    INAData_t data4;
    INAData_t data5;
    INAData_t data6;
    INAData_t data7;
    INAData_t data8;
    INAData_t data9;
    INAData_t data10;
    INAData_t data11;
    INAData_t data12;
    INAData_t data13;
    INAData_t data14;
    INAData_t data15;
}

header resubmit_h {
    bit<8> port_index;  // just for resubmit to update reg
}

    /***********************  H E A D E R S  ************************/
struct headers_t {
    resubmit_h   resubmit;
    ethernet_h   ethernet;
    vlan_tag_h   vlan_tag; 
    ipv4_h       ipv4;
    udp_h        udp;
    SwitchMoE_h moe;
    ROUTING_h   moe_routing;
    UPDATE_h    moe_update;
    INA_h       moe_ina;
}


    /******  G L O B A L   I N G R E S S   M E T A D A T A  *********/

struct metadata_t {
    DeviceBitmap_t device_bitmap; // bitmap of locations for the expert node
    DeviceId_t last_device_id;
    DeviceId_t device_id;
    Counter_t avg_count;
    Counter_t sum_count;

    TokenId_t token_id;
    bit<8> over_flag;

    INAData_t data0;
    INAData_t data1;
    INAData_t data2;
    INAData_t data3;
    INAData_t data4;
    INAData_t data5;
    INAData_t data6;
    INAData_t data7;
    INAData_t data8;
    INAData_t data9;
    INAData_t data10;
    INAData_t data11;
    INAData_t data12;
    INAData_t data13;
    INAData_t data14;
    INAData_t data15;
}
