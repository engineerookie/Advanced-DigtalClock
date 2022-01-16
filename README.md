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
here is the illustration of function set

![sdaf](https://user-images.githubusercontent.com/92795777/149643797-32dda0d8-6bfe-4e73-881b-01f7a7138fcc.png)
>note: value +1 means the setting value would count up in cycle (ex:minute 00 ~ 59 ...)  

### Finite state machine
in this case,we need the state machine to construct our digital clock.According to the illustration of function set,b1 (button 1) and b2 are the input of finite state machine and mode is our State.The State diagram shows at below 
![qwef](https://user-images.githubusercontent.com/92795777/149647110-00e9469c-c9cd-4243-9c09-34f555041af5.png)
>This state diagram is Moore machine and the smaller font is state decode (s0~s7),they will used in the VHDL coding  
>b1 and b2 are the input of the Finite state nachine, the binary number below the state is the output of Finite state machine
