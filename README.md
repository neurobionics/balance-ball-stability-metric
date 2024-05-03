# StayBall Tester

## Description

The purpose of this project is to act as a test for walking stability, for use in testing whether a prosthetic, exo, or other walking aid is effective at its goal of improving the stability of one's walking. The project itself is composed of a simple UI showing a green star in the center of the "play area", as well as a blue circle that starts in the center and then moves in accordance with a simple model of the dynamics of a ball rolling on a tilted plane, using a device equipped with accelerometers to inform the model's motion. The object of the "game" is to keep the blue circle as close to the green star as possible for the duration of a test. 

The basic idea is that a subject will be asked to walk at a normal, comfortable gait, first without a movement aid or with a movement aid that the researcher wants to test against, and play the game while walking. Then, the subject will be asked to switch to using the researcher's movement aid and play again. The thought here is that subjects scores will reflect whether the aid is actually improving their walking stability(1). There is a practice mode to allow subjects to be acclimated to the dynamics of the game, during which the green star periodically moves to random positions within the play area. 

This experiment is intended for use on a Microsoft Surface Pro, specifically the one in the Rehabilitation Lab in the Ford Robotics Building at UMich, but there's no real reason it couldn't be used elsewhere. Windows device sensors can just be a pain to access sometimes.

```diff
-(1) though it is important to note that this correlation has NOT been tested or proven yet.
```

## Background

"Walking stability" may seem like a nebulous term, and even within the fields where the concept is most relevant, there is some debate over how to measure it. This project is acting under the understanding that a measure correlates with walking stability if it correlates negatively with actual fall incidence, but if you're curious and would like to learn more, this paper is a great place to start: https://royalsocietypublishing.org/doi/epdf/10.1098/rsif.2012.0999

## What's Inside?

So, a tour of this repo!
- __StayBall Server Release/__ holds the executable for the data server for this project. This is the program that reads accelerometer data from the Surface Pro and sends it to the MATLAB app that does most of the work for this project.
- __StayBall_Server_Source/__ holds the source code for the .NET solution that the above is compiled from. This is included in case you need to make any changes to the data server for any reason.
- __archive/__ holds some older versions of some bits and pieces of this project, warts and all. It's mostly there as a curiosity, and not a lot of note can be gleaned, but it might be interesting to someone.
- __images/__ just holds the images used in this document. Nothing special.
- __analysis.m__ is a small piece of MATLAB code that might be useful in troubleshooting the StayBall Server, because all it does is send a request and print its value, as opposed to requests embedded in a looping MATLAB script.
- __experiment_gui.mlapp__ is the MATLAB script for the actual StayBall Tester app, for use with the StayBall Server. It's the brains of the operation, where our calculations and UI happen.
- __experiment_gui_mobile.mlapp__ is the MATLAB script for the app for use with MATLAB Mobile. You only need to use one or the other.

## Installation

For usage on the Surface Pro, this project requires:
- .NET8.0 SDK: https://dotnet.microsoft.com/en-us/download/dotnet/8.0 installed on said Surface Pro.
- MATLAB. This was coded in R2023b.
- You need at least __StayBall Server Release/__ and __experiment_gui.mlapp__ to run in this configuration.

For usage with MATLAB Mobile:
- The C# server is unnecessary in this case.
- Install MATLAB Mobile on a phone, using the same account as the computer you are running __experiment_gui_mobile.mlapp__ from and logged into the same wifi.
- You should otherwise only need __experiment_gui_mobile.mlapp__ to run in this configuration.

## Usage

### Launch on Surface Pro

To launch in this configuration, you will want to launch the server first, and when that is up and running, then you will launch the MATLAB app.

To launch the server, you will want to open up PowerShell and navigate to the directory that holds __StayBall Server.exe__ and use the command ` & '.\StayBall Server.exe'`. No output is the expected behavior here, and it will look like the command line is waiting for you. This means the server is running. After this, all you should need to do is run __experiment_gui.mlapp__!

### Launch Using MATLAB Mobile

To launch in this configuration, you just need to make sure your phone is open to MATLAB Mobile at the moment when __experiment_gui_mobile.mlapp__ tries to connect to it. This happens within the first few seconds after launching the app, so as long as MATLAB Mobile is open when you hit "Run", it should work fine.

### Using the app

![App GUI](images/exp_gui.PNG?raw=true "app")

The functionality in the app is fairly simple and self-explanatory, but here's the basics:
- The __green star__ denotes (0,0) on the grid. This is thought of as the goal location for the __blue circle__.
- The __blue circle__ marks the current location of the modeled "ball rolling on a tilted plane" that is the basis for this app. 

The goal of a test subject should be to tilt the Surface Pro or smartphone screen to keep the __blue circle__ as close as possible to the __green star__ for the duration of the test, which is modifiable in `BeginTestButtonPushed` as the value of `app.event_duration`.
- The "Begin Test" button will trigger a short countdown, reset the __blue circle__'s position to (0,0), and then begin recording test data and counting down the remaining test time (set as detailed above). At the end of this duration, a short prompt will pop up on screen and the recorded data will be saved, after which the app will return to "idle" state, which is the state it launches in. 
- The "Begin Practice" button will trigger a short countdown, reset the __blue circle__'s position to (0,0), and then for `app.event_duration` seconds, set in `BeginPracticeButtonPushed`, the __green star__'s location will be randomized within ([-3,3],[-3,3]) every `app.practice_interval` seconds. The purpose of this is to act as an acclimation period to get subjects used to the dynamics of the app.

## Known Issues

### Accumulating Input Lag

The MATLAB Mobile version of the app exhibits a persistent problem where the longer the app runs for, the more the on-screen response of the ball lags in responding to the input. Most of the semester has been spent on trying to solve this issue, and that's why I've gone to the trouble of setting up a C# data server for the accelerometer data. 

### TargetFramework Issues and Editting __StayBall Server.csproj__:

- Just in case something gets messed up with the framework targetting or the Surface gets a new version of Windows, I've included this. Basically, if you need to change the version of Windows that the data server targets, you'll first need to find which version of Windows you're running. This can be achieved by navigating to __System Information__ and checking the underlined values:
![Windows System Information](images/system_info.png?raw=true "sysinfo") 

- The file you need (__Stayball Server.csproj__) to edit is found within StayBall_Server_Source in this repo. To open it, you should open the associated solution (__StayBall Server.sln__) in Visual Studio. The .csproj should look like this if you open it: 
![Visual Studio open to the .csproj](images/framework_edit.png?raw=true "framework")

The line you need to edit is underlined here, and your input should take the form of "net8.0-windows10.0.{your build}.0". Fortunately, if you do something wrong here, when you build and try to run the server, it will spit out an error which lists the acceptible inputs. Just use the one that's closest to your build, but not higher (later) than.

## Lessons Learned

So now that I'm done working on this, what are some things that I wish I'd known at the beginning?

- The UI loop is SACRED! - A lot of what gave me trouble this semester was not realizing that I was totally overloading the loop that refreshes the axes with calculation processes and figure plotting. If at all possible, it is better to take as much as possible of these processes out of the UI loop and update values within the UI loop, or do something more clever, just as long as the UI refresh isn't waiting on these processes. This might be CS 101, extremely basic stuff to a lot of people, but I'm a mechanical engineer, so I had to learn this the hard way.

- Take a step back! - I realized about halfway through this that to implement some of the functionality I wanted, I needed to implement a state machine or something like it. As a result of my ill-planned attempt at this, I think it ends up being quite sloppy and its pieces are a bit spread out and disorganized, which is not the most conducive to making something like this work, or to fixing problems with it.

- Use your resources! - I would never have been able to get the data server up and running without the help of my friend Aria. C# may not be too bad to someone with experience, but to a newcomer its quite daunting.

- Perhaps updating a set of axes in MATLAB is not the most effective way to do what we are trying to do here. I'm unsure what platform would work best, but this app is at the __very__ least a good rough draft for such an app. 


## Further Directions

I only had a semester to work on this, so there's a lot I considered doing that didn't end up being realistic. I've included some of those ideas here because someone, somewhere down the line, might want that information.

- Making an Integrated App - So, the most obvious thing would be to make this project all runnable from one click on either a Surface, Android, or iOS app. That would seem to solve a lot of issues that plague the project as it is now. I didn't really have time to learn enough app development to make that happen, unfortunately, but I figure it probably wouldn't be too hard, especially for someone who has app development experience and has access to this project. It would also be valuable to make this multiplatform, in pursuit of the goal of creating a useful, widely-referenced and used tool for measuring improvements in walking stability. 

- Processing Sensor Data - I am under the impression that some gentle low pass filtering or something of that nature applied to the sensor data would make the app run smoother.

- Tuning Acceleration - Everything you need for this can be found in the `double_integrator_dynamics` function. It just needs a bit of work to feel more like a happy medium that isn't dead easy, but also isn't just wild and hugely fluctuating all the time.

## Authors and acknowledgment
Thank you to Kevin Best, the advisor for this project as a ROB 590 independent study at UMich.

Thank you to Aria for helping me through the slog that is C#.


