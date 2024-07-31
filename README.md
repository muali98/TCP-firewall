# FPGA-based TCP Firewall on Zynq and MicroBlaze with Mailbox, BRAM, and DDR Storage
The firewall works by setting up a TCP server on the Zynq Processor, which receives packets and sends the payload to the MicroBlaze. The MicroBlaze then analyzes the payload for malicious content and reports back to the Zynq, which then informs the user of the results. The firewall filters incoming data by allowing numbers and alphabets to pass through while blocking symbols.

The payload is transferred between the two processors using a mailbox and the length of the payload is communicated using BRAM (both payload and length can be transferred either using mailbox or BRAM but for testing purposes, both mailbox and BRAM were used). The server on Zynq Processor also stores TCP payloads in DDR memory, to keep the history of all the received packets, ensuring no overwrites.

<img width="1275" alt="image" src="https://github.com/user-attachments/assets/203e19f4-3d8f-4757-a36f-d0702f7c4aca">
