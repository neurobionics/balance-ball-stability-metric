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
- __experiment_gui.mlapp__ is the MATLAB script for the actual StayBall Tester app. It's the brains of the operation, where our calculations and UI happen.

## Installation
For usage on the Surface Pro, this project requires:
- .NET8.0 SDK: https://dotnet.microsoft.com/en-us/download/dotnet/8.0 installed on said Surface Pro.
- MATLAB. This was coded in R2023b.
- You need at least __StayBall Server Release/__ and __experiment_gui.mlapp__ to run in this configuration.

For usage with MATLAB Mobile:
- The C# server is unnecessary in this case.
- Install MATLAB Mobile on a phone, using the same account as the computer you are running experiment_gui from and logged into the same wifi.
- You should otherwise only need __experiment_gui.mlapp__ to run in this configuration.
- Edit experiment_gui.mlapp such that the appropriate sections (as outlined in the comments themselves) are either uncommented or commented for the usage you want. 

## Usage

### Launch on Surface Pro

To launch in this configuration, you will want to launch the server first, and when that is up and running, then you will launch the MATLAB app.

To launch the server, you will want to open up PowerShell and navigate to the directory that holds __StayBall Server.exe__ and use the command ` & '.\StayBall Server.exe'`. No output is the expected behavior here, and it will look like the command line is waiting for you. This means the server is running. After this, all you should need to do is run __experiment_gui.mlapp__!

### Launch Using MATLAB Mobile

To launch in this configuration, you just need to make sure your phone is open to MATLAB Mobile at the moment when __experiment_gui.mlapp__ tries to connect to it. This happens within the first few seconds after launching the app, so as long as MATLAB Mobile is open when you hit "Run", it should work fine.

### Using the app

(in progress)

## Known Issues

### TargetFramework Issues and Editting __StayBall Server.csproj__:

- Just in case something gets messed up with the framework targetting or the Surface gets a new version of Windows, I've included this. Basically, if you need to change the version of Windows that the data server targets, you'll first need to find which version of Windows you're running. This can be achieved by navigating to __System Information__ and checking the underlined values:
![alt text](images/system_info.png?raw=true "sysinfo") 

- The file you need (__Stayball Server.csproj__) to edit is found within StayBall_Server_Source in this repo. To open it, you should open the associated solution (__StayBall Server.sln__) in Visual Studio. The .csproj should look like this if you open it: 
![alt text](images/framework_edit.png?raw=true "framework")

The line you need to edit is underlined here, and your input should take the form of "net8.0-windows10.0.{your build}.0". Fortunately, if you do something wrong here, when you build and try to run the server, it will spit out an error which lists the acceptible inputs. Just use the one that's closest to your build, but not higher (later) than.

## Authors and acknowledgment
Thank you to Kevin Best, the advisor for this project as a ROB 590 independent study at UMich.
Thank you to Aria for helping me through the slog that is C#.


