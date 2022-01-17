# Advanced-DigtalClock
## Specification and Feature
The board that I use only has a 4-digit seven segment display for output and 4 buttons as input for controlling the clock function  
This whole file has multiple function showing below 
>1.switching digit  
>2.disable or enable the alarm function  
>3.setting the clock digit (hour,minute,second)  
>4.setting the alarm clock digit (hour,minute,second)  
>5.counting down timer  
### Caution: The project has some flaw that wait for improving. I will describe at the end!!!
## Design Draft and Finite state machine 
Here is the illustration of function set
![sdaf](https://user-images.githubusercontent.com/92795777/149643797-32dda0d8-6bfe-4e73-881b-01f7a7138fcc.png)
>note: value +1 means the setting value would count up in cycle (ex:minute 00 ~ 59 ...)  
### The design draft of entire circuit
Before I build this project,I draw a sketch that describe how many function module it needs and the connection relation between these function module.
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
This state diagram is Moore machine. I won't go on the detail of it,you can learn more about the differnence between the Moore machine and Mealey machine from other resource,in this design I will use the Moore machine as my finite state machine.
>we will replace the state shown on the state diagram with the sign (s0 ~ s7),the list of decoding can be found in the clock_FSM vhd file.  
>b1 and b2 are the input of the Finite state machine, the binary number below the state is the output of Finite state machine.    
Notice that the clock feed in the FSM is only 2hz,the reason why the clock is incredibly slow is that if we increase the frequency of the clock,the speed of state transition would be too fast to view.So we need the low frequency to stable our FSM.
