# StayBall Tester

## Description
The purpose of this project is to act as a test for walking stability, for use in testing whether a prosthetic, exo, or other walking aid is effective at its goal of improving the stability of one's walking. The project itself is composed of a simple UI showing a green star in the center of the "play area", as well as a blue circle that starts in the center and then moves in accordance with a simple model of the dynamics of a ball rolling on a tilted plane, using a device equipped with accelerometers to inform the model's motion. The object of the "game" is to keep the blue circle as close to the green star as possible for the duration of a test. 

The basic idea is that a subject will be asked to walk at a normal, comfortable gait, first without a movement aid or with a movement aid that the researcher wants to test against, and play the game while walking. Then, the subject will be asked to switch to using the researcher's movement aid and play again. The thought here is that subjects scores will reflect whether the aid is actually improving their walking stability(1). There is a practice mode to allow subjects to be acclimated to the dynamics of the game, during which the green star periodically moves to random positions within the play area. 

```diff
-(1) though it is important to note that this correlation has NOT been tested or proven yet.
```

## Background
"Walking stability" may seem like a nebulous term, and even within the fields where the concept is most relevant, there is some debate over how to measure it. This project is acting under the understanding that a measure correlates with walking stability if it correlates negatively with actual fall incidence, but if you're curious and would like to learn more, this paper is a great place to start: https://royalsocietypublishing.org/doi/epdf/10.1098/rsif.2012.0999

## Installation
For usage on the Surface Pro, this project requires:
- .NET8.0 SDK: https://dotnet.microsoft.com/en-us/download/dotnet/8.0
- Editting of the "Stayball Server.csproj" file (more on that in a moment)
- This may not be required, but the MATLAB code in this project was created on R2023b. 

For usage with MATLAB Mobile:
- The C# server is unnecessary in this case.
- Edit experiment_gui.mlapp such that the appropriate sections (as outlined in the comments themselves) are either uncommented or commented for the usage you want. 

(in progress)

## Usage

(in progress)

## Authors and acknowledgment
Thank you to Kevin Best, the advisor for this project as a ROB 590 independent study at UMich.
Thank you to Aria for helping me through the slog that is C#.


