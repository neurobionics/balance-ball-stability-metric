

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.eecs.umich.edu/melodie/stayball-tester.git
git branch -M main
git push -uf origin main
```


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



## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.


## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Thank you to Kevin Best, the advisor for this project as a ROB 590 independent study at UMich.
Thank you to Aria for helping me through the slog that is C#.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
