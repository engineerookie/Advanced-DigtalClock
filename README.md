# Advanced-DigtalClock
## Specification and Feature
The board I am using only has a 4 digit seven segment display for output and 4 buttons for controlling the clock function as input  
This project has multiple functions as shown below. 
>1.switching digit  
>2.disable or enable the alarm function  
>3.setting the clock digit (hour,minute,second)  
>4.setting the alarm clock digit (hour,minute,second)  
>5.counting down timer  
### Note: The project is flawed and needs to be improved! ! !
## Design Draft and Finite state machine 
Here is the illustration of function set
<img src="https://user-images.githubusercontent.com/92795777/149643797-32dda0d8-6bfe-4e73-881b-01f7a7138fcc.png" width="800" height="250"> 
>note: value +1 means the setting value would count up in cycle (ex:minute 00 ~ 59 ...)  
### The design draft of entire circuit
Before I built this project, I drew a sketch that described how many functional modules it needed and the connections between these functional modules. Considering the FPGA board I'm using, the board only has a 4-bit seven-segment and 5 buttons to use in this project. So I need to create a latch circuit to convert some buttons into switches, and create a selector to toggle the display numbers to display (hours:minutes:seconds).
Here you can see some of these functional modules and their connections. My idea is that I need other modules that correspond to the outputs of the finite state machine.
This is my main idea when I sketch.
<img src="https://user-images.githubusercontent.com/92795777/149730736-36c91e16-5f7e-4317-b84d-075312a6612b.jpg" width="800" height="500">  
And there is another RTL netlist diagram that is created by Quaturs after complited the entire VHDL coding.
<img src="https://user-images.githubusercontent.com/92795777/149730298-b1c4cb23-231f-4f78-9ad9-daaec4427643.png" width="800" height="500">  
The RTL netlist doesn't seem to be the same as the sketch, because I've added some external functions so that the whole hardware can function properly.
>(ex: push button debounce,latch circuit for transiting the push button to mechanical switch...I would explain them later)  
## The detail of each module 
### Finite state machine
<img src="https://user-images.githubusercontent.com/92795777/149733012-8985543b-561c-499f-a8ec-13151d603e65.png" width="500" height="300">  
In this case,the finite state machine is the core of our design. According to the diagram of function set,b1 (button 1) and b2 are the input of finite state machine and mode is our State.The state diagram is shown in the figure below.
<img src="https://user-images.githubusercontent.com/92795777/149723582-7ead500e-b602-4751-9e52-05e3657c39ab.png" width="700" height="400">  
This state diagram is Moore machine.In this design I will use the Moore machine as my finite state machine.  

>We replace the states shown on the state diagram with symbols (s0 ~ s7), and the decoding list can be found in the clock_FSM vhd file, i.e. coding comments.  
>b1 and b2 are the input of the Finite state machine, the binary number below the state is the output of Finite state machine.
    
Note that the clock feed in the FSM is only 2hz, the reason the clock is incredibly slow is that if we increase the clock frequency, the state transitions are too fast to be viewed. So we need low frequencies to stabilize our FSM.  
Here is a simple testbench result for simulating the FSM module.  
![狀態機測試](https://user-images.githubusercontent.com/92795777/149867138-2d83927d-2871-401e-b152-59e7697a24b0.png)
It can be seen from the simulation results that the defect of the Moore machine is that the current state transition is delayed by one cycle. But there is no delay in the output of the FSM, which guarantees that the entire function will not fail or crash.
### Clock generater
<img src="https://user-images.githubusercontent.com/92795777/149897324-3cc00fd4-b425-4fe8-b671-cb001dedac90.png" width="500" height="300">  
This project only use 2 types of frequency of clock: 1hz and 2hz.The 1hz frequency is used for clock and timer function,2hz frequency is used for other application like value +1 or FSM...

### Clock and alarm digit set
<img src="https://user-images.githubusercontent.com/92795777/149862488-03a5a35f-c20e-4ffc-b7eb-79f56f817101.png" width="500" height="300">  
This module is a 4-bit register that can be visualized through a seven-segment display.I mimicked the pattern of transferring data between two registers from the textbook.  

>sd1,sd2: The sign of menu.  
>sd3:the first digit output.  
>sd4:the second digit output.  

Tri-state is very important in this module to prevent data transfer at inappropriate time.  
<img src="https://user-images.githubusercontent.com/92795777/149868100-cf84cead-40a5-4c58-ad57-e28d8583fc04.jpg" width="400" height="300">
<img src="https://user-images.githubusercontent.com/92795777/149868338-9069a7f4-9935-4eb8-9f5c-773d01da41be.png" width="500" height="250">  
Here is a simple testbench result for simulating the clk_alrm_set module.
![001](https://user-images.githubusercontent.com/92795777/149889134-c2307380-b53c-4688-99d0-7430643b7159.png)  
The purpose of the test is to check that the data outputs (sd3, sd4) are in sync with the registers and the results are in sync.  
>Take fsm_in as "001" as an example, now sd3 output should be synchronized with ch_1, sd4 should be synchronized with ch_2, sd1 and sd2 should output menu symbols  
>Here is a list of correspondences  
>fsm_in: "001" sd1 <-- "1110"(C) sd2 <-- "1010"(H) sd3 <-- ch_1 sd4 <-- ch_2  
>fsm_in: "010" sd1 <-- "1110"(C) sd2 <-- "1011"(L) sd3 <-- cm_1 sd4 <-- cm_2  
>fsm_in: "011" sd1 <-- "1110"(C) sd2 <-- "1100"(S) sd3 <-- cs_1 sd4 <-- cs_2  
>fsm_in: "100" sd1 <-- "1101"(A) sd2 <-- "1010"(H) sd3 <-- ah_1 sd4 <-- ah_2  
>fsm_in: "101" sd1 <-- "1101"(A) sd2 <-- "1011"(L) sd3 <-- am_1 sd4 <-- am_2  
>fsm_in: "110" sd1 <-- "1101"(A) sd2 <-- "1100"(S) sd3 <-- as_1 sd4 <-- as_2  
### Clock display
<img src="https://user-images.githubusercontent.com/92795777/149896843-cf0c77a7-e097-497f-abdf-e02ddcf60bc2.png" width="300" height="350">  
This module is the most complex in this entire project because it contains both the normal clock counting and clock alarm function.

>There exists a critical issue between the clock display module and the clock and alarm digital setting module and we will discuss it later  

