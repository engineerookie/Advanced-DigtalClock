# Advanced-DigtalClock
## Specification and Feature
The board that I use only has a 4-digit seven segment display for output and 4 buttons as input for controlling the clock function  
This whole file has multiple function showing below 
>1.switching digit  
>2.disable or enable the alarm function  
>3.setting the clock digit (hour,minute,second)  
>4.setting the alarm clock digit (hour,minute,second)  
>5.counting down timer  
### Caution: The project has some flaw that wait for improving!!!
## Design Draft and Finite state machine 
Here is the illustration of function set
![sdaf](https://user-images.githubusercontent.com/92795777/149643797-32dda0d8-6bfe-4e73-881b-01f7a7138fcc.png)
>note: value +1 means the setting value would count up in cycle (ex:minute 00 ~ 59 ...)  
### The design draft of entire circuit
Before I build this project,I draw a sketch that describe how many function module it needs and the connection relation between these function module.Considering the FPGA board that I use,the board only has one 4-digits seven-segment and 5 push buttons can be used in this project.Hence I need to create a latch circuit for transitting some push button to the switch and create a selector to switch the display digit to show (hour:minute:second)
Here you can see some of these function module and their connection relation.what in my thought is that I need others module correspond to the output of finite state machine.
And that is the main idea while I draw the sketch
![20220117_155044](https://user-images.githubusercontent.com/92795777/149730736-36c91e16-5f7e-4317-b84d-075312a6612b.jpg)
And there is another RTL netlist diagram that is created by Quaturs after complited the entire VHDL coding.
![RTL_diagram](https://user-images.githubusercontent.com/92795777/149730298-b1c4cb23-231f-4f78-9ad9-daaec4427643.png)
The RTL netlist does not seem the same as the sketch should be because I add some external function so that the entire hardware can be well-functioning.
>(ex: push button debounce,latch circuit for transiting the push button to mechanical switch...I would explain them later)  
## The detail of each module 
![FSM_diagram](https://user-images.githubusercontent.com/92795777/149733012-8985543b-561c-499f-a8ec-13151d603e65.png)
### Finite state machine
In this case,the finite state machine is the core of our design. According to the diagram of function set,b1 (button 1) and b2 are the input of finite state machine and mode is our State.The State diagram shows at below. 
![qwef](https://user-images.githubusercontent.com/92795777/149723582-7ead500e-b602-4751-9e52-05e3657c39ab.png)
This state diagram is Moore machine.In this design I will use the Moore machine as my finite state machine.
>we will replace the state shown on the state diagram with the sign (s0 ~ s7),the list of decoding can be found in the clock_FSM vhd file that are the coding comment.  
>b1 and b2 are the input of the Finite state machine, the binary number below the state is the output of Finite state machine.
    
Notice that the clock feed in the FSM is only 2hz,the reason why the clock is incredibly slow is that if we increase the frequency of the clock,the speed of state transition would be too fast to view.So we need the low frequency to stable our FSM.

Here is a simple testbench for simulating the FSM module.
![狀態機測試](https://user-images.githubusercontent.com/92795777/149763221-7d3a5b57-907d-473b-895f-2438e6a18904.png)
As the simulation commit the result,we can find the flaw of Moore machine is that the present state transferring delay one cycle.However,the output of the FSM doesn't delay,it ensure that whole function won't go wrong or collapse.  
### Clock generater
![FSM_diagram](https://user-images.githubusercontent.com/92795777/149765529-221adc9c-2273-46c7-ae12-e2fd43618dc0.png)
