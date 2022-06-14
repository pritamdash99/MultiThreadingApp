# MultiThreadingApp
An iOS App showing multithreading concepts.

This app uses Thread class and creates sub classes to do parallel operations, it also uses Image view to change image using multithreading concepts 
KeyNote : 
(GCD : Grand Central Dispatch)
Whatever data you want to pass from 1 thread to another you can easily do that but have to follow procedure :
Create a code and pass it to the next thread from the current thread to get executed.
Thread executed by OS, has threadNumber.
Here the concept of DispatchQueue comes to play.
Every thread can have an extra queue known as dispatchQueue where it can recieve and hold "code blocks" sent from other thread.
So when OS recieves the new threads number it will also execute the new thread's dispatchQueue.
 
Main thread by default has a dispatchQueue attached to it.

Attaching a demo of the app bellow :

https://user-images.githubusercontent.com/80701312/173635149-dfad545b-d65d-4583-be89-431cc743f7a4.mp4


