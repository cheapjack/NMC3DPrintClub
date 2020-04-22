## My CheapBook

Install of
Ubuntu 18.04.4 LTS
18.04
bionic

## Hardware

Modified Item: 	No 						Release Year: 	2017
Operating System Edition: 	Professional 			Memory: 	16GB
Colour: 	Black 						Product Line: 	X1 Yoga
Maximum Resolution: 	1920 x 1080 				Processor Type: 	Intel Core i7 6th Gen
Operating System: 	Windows 10 				Non-Domestic Product: 	No
Graphics Processing Type: 	Integrated//On-Board Graphics 	Storage Type: 	SSD (Solid State Drive)
Custom Bundle: 	No 						RAM Size: 	16 GB
Type: 	Convertible 2-in-1 Laptop/Tablet 			Brand: 	Lenovo
Processor Speed: 	2.6 GHz 				Most Suitable For: 	Serious Gaming
Manufacturer Colour: 	Black 					Hardware Connectivity: 	Mini DisplayPort, HDMI, USB 3.0
Features: 	10/100 LAN Card, Backlit Keyboard, Bluetooth, Built-in Microphone, Built-in Webcam, Touchscreen 	Processor: 	Intel Core i7 6th Gen.
Hard Drive Capacity: 	512GB 					SSD Capacity: 	512GB
MPN: 	20FR-S1N600 						Screen Size: 	14"
Manufacturer warranty: 	None 					EAN: 	0192330648264

## Applications, installed stuff

[Pandoc](https://github.com/jgm/pandoc/releases/tag/2.9.1.1)
Settings are in `~/.bashrc` including **aliases** etc.

I'm following the convention of applications I download outside of `apt install` or the Ubuntu Software packages  in `/usr/local/bin` and keeping `.AppImage` packages there also. Theres some fiddling to be done to get `.desktop` files so they can open in the Activities window. For all users these are kept in `/usr/share/applications`

https://specifications.freedesktop.org/desktop-entry-spec/latest/

### Backups

I'm following this [tar basics](http://www.linfo.org/tar.html) tutorial and this [Ubuntu backup tutorial](https://help.ubuntu.com/community/BackupYourSystem/TAR)

I'll also leave them in home locally. `tarBasics` `BackupTutorial`

#### Create

`cd` into home

Basic use of tar to compress the home folder 

`tar -cvpzf backup.tar.gz --exclude=backup.tar.gz --one-file-system *`

create, verbose, permissions, gz compression, filename --what-not-to-include

To do the same with a bigger list of

`tar -cvzpf - --exclude=backup.tar.gz \
--exclude=backup \
--exclude=Desktop * \
--exclude=Documents \
--exclude=Downloads \
--exclude=fontconfig \
--exclude=gems \
--exclude=Music \
--exclude=snap \
--exclude=Videos \
--exclude=Zotero \
|  pv -s 2G > backup.tar.gz`

tar create, verbose_mode, gzip, retain_permissions, file_name, pass_file_name_into_pv --exclude=all_the_files_folders_you_dont_need_with_new_lines\, pipe into pv, -s estimated_the_size_of_the_dir ./ pipe_into_awk_which_processes_it_using_du_into_a_variable_if_you_dont_know

`|  pv -s $(du -sb ./ | awk '{print $1}') > backup.tar.gz`

Then move to an external drive 

#### Restore
`mkdir backup_directory`

`tar -xvpzf backup.tar.gz -C backup_directory/ --numeric-owner`

Move into the backup_directory first, keep numeric owners in case on a different system

### Notes

PrusaSlicer is best running in a screen `screen -S PrusaSlicer` The detach the screen with `ctrl` & `d`. List screens with `screen -ls` and return to the screen you made for PrusaSlicer with `screen -r PrusaSlicer`

## vim

Ive tried to follow conventions of packages like `pack/mycolors/opt/dark/colors/vim-colors-solarized/colors/solarized.vim` but that seemed to not really work so I've followed the basic convention of git cloning or unzipping into individual pack directories, to maintain them then `cp` them into the right folder 

I've since shifted to Vundle so in vim run 

`:h vundle` or `:PluginList`

Checkout [Vundle](https://github.com/VundleVim/Vundle.Vim)

### Colors

so I copied `pack/mycolors/opt/dark/colors/vim-colors-solarized/colors/solarized.vim` to `~/.vim/colors`



### Keycode Defaults

keycode 112 = Prior NoSymbol Prior
keycode 117 = Next NoSymbol Next

```
# Disable
$ xmodmap -e 'keycode 112 = '

# Enable
$ xmodmap -e 'keycode 112 = Prior NoSymbol Prior'
$ xmodmap -e 'keycode 117 = Next NoSymbol Next'
```
### Vim tips

Setup is in the `~/.vimrc` file as standard

Word count in vim by selecting text in visual mode and pressing `g` followed by `ctrl` & `g`	

# NMC3DPrintClub
