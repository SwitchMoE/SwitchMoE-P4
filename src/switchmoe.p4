/* -*- P4_16 -*- */
#include <core.p4>
#if __TARGET_TOFINO__ == 2
#include <t2na.p4>
#else
#include <tna.p4>
#endif

#include "includes/headers.p4"
#include "includes/parser.p4"



control SwitchIngress(
    /* User */
    inout headers_t                       hdr,
    inout metadata_t                      meta,
    /* Intrinsic */
    in    ingress_intrinsic_metadata_t               ig_intr_md,
    in    ingress_intrinsic_metadata_from_parser_t   ig_prsr_md,
    inout ingress_intrinsic_metadata_for_deparser_t  ig_dprsr_md,
    inout ingress_intrinsic_metadata_for_tm_t        ig_intr_md_for_tm)
{   
	Register<bit<8>, _>(EXPERT_CAPACITY) expert_location;
    RegisterAction<bit<8>, _, bit<8>>(expert_location)
    get_expert_node_location={
        void apply(inout bit<8> register_data, out bit<8> result){
            result = register_data;
        }
    };

	RegisterAction<bit<8>, _, bit<8>>(expert_location)
	update_expert_node_location={
		void apply(inout bit<8> register_data){
			register_data = hdr.moe_update.device_bitmap;
		}
	};

	Register<bit<32>,_>(1) packets_counter;

	RegisterAction<bit<32>,_,bit<32>>(packets_counter)
	get_packets_count_avg_and_plus_count_1 = {
		void apply(inout bit<32> register_data,out bit<32> result){
			result = register_data;
			register_data = register_data + 1;
		}
	};


	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t0_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t1_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t2_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t3_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t4_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t5_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t6_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t7_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t8_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t9_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t10_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t11_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t12_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t13_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t14_reg;
	Register<INAData_t, _>(MAX_EXPERT_COUNT) INAData_t15_reg;

	RegisterAction<INAData_t, _, void>(INAData_t0_reg) ina_aggregation_0 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data0;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t0_reg) ina_aggregation_clear_0 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t1_reg) ina_aggregation_1 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data1;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t1_reg) ina_aggregation_clear_1 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t2_reg) ina_aggregation_2 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data2;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t2_reg) ina_aggregation_clear_2 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t3_reg) ina_aggregation_3 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data3;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t3_reg) ina_aggregation_clear_3 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t4_reg) ina_aggregation_4 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data4;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t4_reg) ina_aggregation_clear_4 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t5_reg) ina_aggregation_5 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data5;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t5_reg) ina_aggregation_clear_5 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t6_reg) ina_aggregation_6 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data6;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t6_reg) ina_aggregation_clear_6 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t7_reg) ina_aggregation_7 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data7;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t7_reg) ina_aggregation_clear_7 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t8_reg) ina_aggregation_8 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data8;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t8_reg) ina_aggregation_clear_8 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t9_reg) ina_aggregation_9 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data9;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t9_reg) ina_aggregation_clear_9 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t10_reg) ina_aggregation_10 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data10;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t10_reg) ina_aggregation_clear_10 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t11_reg) ina_aggregation_11 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data11;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t11_reg) ina_aggregation_clear_11 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t12_reg) ina_aggregation_12 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data12;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t12_reg) ina_aggregation_clear_12 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t13_reg) ina_aggregation_13 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data13;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t13_reg) ina_aggregation_clear_13 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t14_reg) ina_aggregation_14 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data14;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t14_reg) ina_aggregation_clear_14 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	RegisterAction<INAData_t, _, void>(INAData_t15_reg) ina_aggregation_15 = {
		void apply(inout INAData_t value) {
			value = value + hdr.moe_ina.data15;
		}
	};

	RegisterAction<INAData_t, _, INAData_t>(INAData_t15_reg) ina_aggregation_clear_15 = {
		void apply(inout INAData_t value, out INAData_t result) {
			result = value;
			value = 0;
		}
	};

	Register<bit<8>,_>(MAX_EXPERT_COUNT) ina_count_reg;

	RegisterAction<bit<8>,_,bit<8>>(ina_count_reg) check_all_token_arrived={
		void apply(inout bit<8> value,out bit<8> result){
			value = value + 1;
			result = value;
		}
	};

    // Register<bit<8>, bit<1>>(1) port_counter_4;
    // Register<bit<8>, bit<1>>(1) port_counter_5;
    // Register<bit<8>, bit<1>>(1) port_counter_6;
    // Register<bit<8>, bit<1>>(1) port_counter_7;
    
    Register<Counter_t, bit<1>>(1) port_counter_0;
    Register<Counter_t, bit<1>>(1) port_counter_1;  
    Register<Counter_t, bit<1>>(1) port_counter_2;
    Register<Counter_t, bit<1>>(1) port_counter_3;

    RegisterAction<Counter_t, bit<1>, bit<1>>(port_counter_0) read_port_0 = {
        void apply(inout Counter_t value, out bit<1> result) {
			result = 0;
			if(value <=meta.avg_count || meta.last_device_id == 0)
			{
				result = 1;
				value = value + 1;
			}

        }
    };
    
	RegisterAction<Counter_t, bit<1>, bit<1>>(port_counter_1) read_port_1 = {
		void apply(inout Counter_t value, out bit<1> result) {
			result = 0;
			if(value <= meta.avg_count || meta.last_device_id == 1)
			{
				result = 1;
				value = value + 1;
			}
		}
	};

	RegisterAction<Counter_t, bit<1>, bit<1>>(port_counter_2) read_port_2 = {
		void apply(inout Counter_t value, out bit<1> result) {
			result = 0;
			if(value <= meta.avg_count || meta.last_device_id == 2)
			{
				result = 1;
				value = value + 1;
			}
		}
	};

	RegisterAction<Counter_t, bit<1>, bit<1>>(port_counter_3) read_port_3 = {
		void apply(inout Counter_t value, out bit<1> result) {
			result = 0;
			if(value <= meta.avg_count || meta.last_device_id == 3)
			{
				result = 1;
				value = value + 1;
			}
		}
	};
    
	action expert_forward(PortId_t port){
		ig_intr_md_for_tm.ucast_egress_port=port;
	}

	action get_last_device_id(DeviceId_t id){
		meta.last_device_id = id;
	}

	action setup_multicast_replication() {  
        // set PRE 
        ig_intr_md_for_tm.mcast_grp_a = FOUR_WAY_MCAST_GROUP;  
        
    } 

	table last_device_id_table{
		key = {
			meta.device_bitmap: exact;	
		}
		actions = {
			get_last_device_id;
		}
		size = 256;
	}

	table forward_table {
		key = {
			meta.device_id: exact;
		}
		actions = {
			expert_forward;
		}
		size = 256;
	}

	apply{
		hdr.ethernet.dst_addr = ig_prsr_md.global_tstamp;
		if(hdr.moe.type == 8w0 && hdr.moe_routing.is_recirc == 1)	// data packet for routing
		{
			// 8bit 1001_1100
			meta.device_bitmap = get_expert_node_location.execute(hdr.moe_routing.expert_id);
			meta.sum_count = get_packets_count_avg_and_plus_count_1.execute(0);
			meta.avg_count = meta.sum_count>>2;
			last_device_id_table.apply();

            if(meta.device_bitmap[0:0]==1){
				bit<1> result = read_port_0.execute(0);
				if(result ==1){
					meta.device_id = 0;
					meta.avg_count = 0;
				}
			}
			if(meta.device_bitmap[1:1]==1 && meta.avg_count != 0){
				bit<1> result = read_port_1.execute(0);
				if(result ==1){
					meta.device_id = 1;
					meta.avg_count = 0;
				}
			}

			if(meta.device_bitmap[2:2]==1 && meta.avg_count != 0){
				bit<1> result = read_port_2.execute(0);
				if(result ==1){
					meta.device_id = 2;
					meta.avg_count = 0;
				}
			}

			if(meta.device_bitmap[3:3]==1 && meta.avg_count !=0){
				bit<1> result = read_port_3.execute(0);
				if(result ==1){
					meta.device_id = 3;
					meta.avg_count = 0;
				}
			}
			//expert_forward((bit<9>)meta.index);
		}
		else if(hdr.moe.type == 8w0 && hdr.moe_routing.is_recirc == 0){
			meta.device_id = 0;
			// use PRE
			setup_multicast_replication();

		}
		else if(hdr.moe.type == 8w1)	// update packet
		{
			meta.device_id = 0;
			update_expert_node_location.execute(hdr.moe_update.expert_id);
		}
		else if(hdr.moe.type == 8w2)
		{
			meta.token_id = hdr.moe_ina.token_id;
			meta.over_flag = check_all_token_arrived.execute(meta.token_id);
			if (meta.over_flag & (bit<8>)3 == 0)
			{
				meta.data0 = ina_aggregation_clear_0.execute(meta.token_id);
				meta.data1 = ina_aggregation_clear_1.execute(meta.token_id);
				meta.data2 = ina_aggregation_clear_2.execute(meta.token_id);
				meta.data3 = ina_aggregation_clear_3.execute(meta.token_id);
				meta.data4 = ina_aggregation_clear_4.execute(meta.token_id);
				meta.data5 = ina_aggregation_clear_5.execute(meta.token_id);
				meta.data6 = ina_aggregation_clear_6.execute(meta.token_id);
				meta.data7 = ina_aggregation_clear_7.execute(meta.token_id);
				meta.data8 = ina_aggregation_clear_8.execute(meta.token_id);
				meta.data9 = ina_aggregation_clear_9.execute(meta.token_id);
				meta.data10 = ina_aggregation_clear_10.execute(meta.token_id);
				meta.data11 = ina_aggregation_clear_11.execute(meta.token_id);
				meta.data12 = ina_aggregation_clear_12.execute(meta.token_id);
				meta.data13 = ina_aggregation_clear_13.execute(meta.token_id);
				meta.data14 = ina_aggregation_clear_14.execute(meta.token_id);
				meta.data15 = ina_aggregation_clear_15.execute(meta.token_id);
				
				hdr.moe_ina.data0 = meta.data0 + hdr.moe_ina.data0;
				hdr.moe_ina.data1 = meta.data1 + hdr.moe_ina.data1;
				hdr.moe_ina.data2 = meta.data2 + hdr.moe_ina.data2;
				hdr.moe_ina.data3 = meta.data3 + hdr.moe_ina.data3;
				hdr.moe_ina.data4 = meta.data4 + hdr.moe_ina.data4;
				hdr.moe_ina.data5 = meta.data5 + hdr.moe_ina.data5;
				hdr.moe_ina.data6 = meta.data6 + hdr.moe_ina.data6;
				hdr.moe_ina.data7 = meta.data7 + hdr.moe_ina.data7;
				hdr.moe_ina.data8 = meta.data8 + hdr.moe_ina.data8;
				hdr.moe_ina.data9 = meta.data9 + hdr.moe_ina.data9;
				hdr.moe_ina.data10 = meta.data10 + hdr.moe_ina.data10;
				hdr.moe_ina.data11 = meta.data11 + hdr.moe_ina.data11;
				hdr.moe_ina.data12 = meta.data12 + hdr.moe_ina.data12;
				hdr.moe_ina.data13 = meta.data13 + hdr.moe_ina.data13;
				hdr.moe_ina.data14 = meta.data14 + hdr.moe_ina.data14;
				hdr.moe_ina.data15 = meta.data15 + hdr.moe_ina.data15;

			}
			else
			{
				// Execute aggregations for data0 to data15 when over_flag is set
				ina_aggregation_0.execute(meta.token_id);
				ina_aggregation_1.execute(meta.token_id);
				ina_aggregation_2.execute(meta.token_id);
				ina_aggregation_3.execute(meta.token_id);
				ina_aggregation_4.execute(meta.token_id);
				ina_aggregation_5.execute(meta.token_id);
				ina_aggregation_6.execute(meta.token_id);
				ina_aggregation_7.execute(meta.token_id);
				ina_aggregation_8.execute(meta.token_id);
				ina_aggregation_9.execute(meta.token_id);
				ina_aggregation_10.execute(meta.token_id);
				ina_aggregation_11.execute(meta.token_id);
				ina_aggregation_12.execute(meta.token_id);
				ina_aggregation_13.execute(meta.token_id);
				ina_aggregation_14.execute(meta.token_id);
				ina_aggregation_15.execute(meta.token_id);
			}
		}
		meta.device_id = 0;
		forward_table.apply();
	}
}


/*******************
 * Egress Pipeline *
 * *****************/

control SwitchEgress(
    inout headers_t hdr,
    inout metadata_t meta,
    in egress_intrinsic_metadata_t eg_intr_md,
    in egress_intrinsic_metadata_from_parser_t eg_intr_md_from_prsr,
    inout egress_intrinsic_metadata_for_deparser_t eg_intr_md_for_dprsr,
    inout egress_intrinsic_metadata_for_output_port_t eg_intr_md_for_oport){

	apply{
		if (eg_intr_md.egress_rid !=0 ){
			if (eg_intr_md.egress_rid == 1) {  
				hdr.moe_routing.expert_id = hdr.moe_routing.top_0;  
			} else if (eg_intr_md.egress_rid == 2) {  
				hdr.moe_routing.expert_id = hdr.moe_routing.top_1;  
			} else if (eg_intr_md.egress_rid == 3) {  
				hdr.moe_routing.expert_id = hdr.moe_routing.top_2;  
			} else if (eg_intr_md.egress_rid == 4) {  
				hdr.moe_routing.expert_id = hdr.moe_routing.top_3;  
			} else if (eg_intr_md.egress_rid == 5) {  
				hdr.moe_routing.expert_id = hdr.moe_routing.top_4;  
			}  
			 else if (eg_intr_md.egress_rid == 6) {  
				hdr.moe_routing.expert_id = hdr.moe_routing.top_5;  
			}  
			 else if (eg_intr_md.egress_rid == 7) {  
				hdr.moe_routing.expert_id = hdr.moe_routing.top_6;  
			}  
			 else if (eg_intr_md.egress_rid == 8) {  
				hdr.moe_routing.expert_id = hdr.moe_routing.top_7;  
			}  
			hdr.moe_routing.is_recirc = 1;
		}
		// record the end time
		hdr.ethernet.src_addr = eg_intr_md_from_prsr.global_tstamp;
	}


} // End of SwitchEgress


Pipeline(SwitchIngressParser(),
		 SwitchIngress(),
		 SwitchIngressDeparser(),
		 SwitchEgressParser(),
		 SwitchEgress(),
		 SwitchEgressDeparser()
		 ) pipe;

Switch(pipe) main;
