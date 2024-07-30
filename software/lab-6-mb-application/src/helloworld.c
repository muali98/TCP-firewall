#include "platform.h"
#include "xmbox.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "xil_types.h"
#include "xparameters.h"
#include <stdio.h>
#include <stdlib.h>

//u32 requested_bytes(){
//	//length of payload stored in first DDR memory address
//	u32 payload_length = Xil_In32(XPAR_PS7_DDR_0_S_AXI_BASEADDR);
//	u32 requestedBytes = payload_length * 4;
//	return requestedBytes;
//}



int main() {


    // Mailbox config and driver object
    XMbox_Config *cfg_ptr_mbox;
    XMbox mbox;

	// retrieve configuration based on device ID
	cfg_ptr_mbox = XMbox_LookupConfig(XPAR_MBOX_0_DEVICE_ID);
	// initialization of the Mailbox IP
	XMbox_CfgInitialize(&mbox, cfg_ptr_mbox, cfg_ptr_mbox->BaseAddress);

	init_platform();

	u32 payload_length=100;
    u32 recv_payload[payload_length];
    u32 filtered_payload[payload_length];
    u32 requested_bytes = payload_length * 4;
    u32 bytesSent;

    while (1) {

    	// Read data from the mailbox/zynq
        XMbox_ReadBlocking(&mbox, recv_payload, requested_bytes);

        // getting the length of received payload
        payload_length = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR);

        // Filter English alphabets and numbers
        int filtered_index = 0;
        for (int i = 0; i < payload_length; i++) {
            // Check if the current value falls within the ASCII range of English alphabets or numbers
            if ((recv_payload[i] >= 'A' && recv_payload[i] <= 'Z') ||    // English uppercase letters
                (recv_payload[i] >= 'a' && recv_payload[i] <= 'z') ||    // English lowercase letters
                (recv_payload[i] >= '0' && recv_payload[i] <= '9')) {    // Numbers
                 // Store the filtered value
                 filtered_payload[filtered_index++] = recv_payload[i];
             }
        }

        // Writing length of filtered payload to second BRAM memory address
        Xil_Out32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR+4 , filtered_index);


        // Write back the filtered data to the mailbox
        XMbox_Write(&mbox, filtered_payload, requested_bytes, &bytesSent);
    }

    cleanup_platform();
    return 0;
}
