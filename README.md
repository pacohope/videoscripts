# Video Utility scripts

For now there's just the one script, `handbrake-batch.sh`. 

## `handbrake-batch.sh`

It recursively decends from a starting point, finding all files of a certain name pattern. It handles names that have spaces in them. I suspect it might not handle files that have lots of dots. (e.g., `party.1.mov` and `party.2.mov`)

When you run it, it will find every video file that matches the name, and run a standard `HandBrakeCLI` command to convert it. It creates a mirror of the directory hierarchy in a new place, and puts the new video file there. It makes whatever directories are necessary. It will also set the creation and modification times to be the same as the original source file.

I've tested it on MacOS. Probably runs with minimal modification on Linux.

