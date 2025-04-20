# favdir

A simple interactive shell script to manage your favorite directories and quickly `cd` into them using a beautiful text menu.

## Features

- Add, remove, and select favorite directories
- Navigate with a colorful menu interface using `figlet` and `lolcat`
- Saves favorites in `~/.favdirs`
- Automatically checks if directories exist before navigating

## Requirements

> `bash`
> >
> `figlet` (for big text)
>
> > ```npm install figlet ```
> 
> `lolcat` (optional, for colors)
>
> > ```npm install figlet```

## Installation

1. Place `favdir.sh` anywhere (e.g. `~/favdir.sh`)
2. Make it executable:
   ```
   chmod +x /favdir.sh
   ```
   3. (Optional) Add an alias to your .bashrc or .zshrc:
   ```
   alias favdir='source ~/favdir.sh'
   ```
   ## Usage
   ```
   ./favdir.sh
   ```
   
   Then just follow the on-screen menu:

- 1 to add a new directory

- 2 to remove one

- 3 to select and cd to a favorite directory

- 4 to exit
> ⚠️ If you want cd to persist after script ends, source the script:
```
source favdir.sh
```
## License
This project is licensed under the MIT License.

