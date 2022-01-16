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
