# UVM-Verification-of-Single-Port-RAM

## Architecture:

16 memory locations, each 32 bits wide\
Input signals: Data_In (32 bits), Address (4 bits), Enable, Clock, Reset, and Write signals (1 bit each)\
Output signals: Data_Out (32 bits) and Valid signal (1 bit)\
Operations occur on positive clock edge\
Uses asynchronous reset\
Valid signal is high for one clock cycle when producing new output\
Write signal determines operation type (high for write, low for read)

## The verification strategy focuses on Simulation Based Verification and covers three main areas:

## Functional Coverage:


Read Operation: Verify all 16 locations can be read\
Write Operation: Ensure correct data writing to all locations\
Valid Signal: Confirm one-cycle assertion after output\
Reset Signal: Verify both assertion and de-assertion\
Clock Signal: Confirm operation timing


## Code Coverage:


Statement Coverage: All RTL code lines executed\
Branch Coverage: All conditional branches covered\
Toggle Coverage: All signals toggle between 1 and 0


## Scenario Coverage:


Read scenarios: Testing with various enable/reset conditions\
Write scenarios: Testing with different signal combinations\
Edge cases: Boundary conditions and consecutive operations

## Test Items include specific test cases for:

Reset-asserted operations\
Enable-low operations\
Normal read/write operations\
Out-of-bound operations

## Exit Criteria:

100% functional coverage\
100% code coverage\
Complete scenario coverage including edge cases

![image](https://github.com/user-attachments/assets/43e8d1e8-355f-4197-9b4f-075ba78c5376)


![image](https://github.com/user-attachments/assets/8d294389-fd26-4945-865f-3b2f4a6a72d5)
