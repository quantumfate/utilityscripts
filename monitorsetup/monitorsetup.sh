#!/bin/sh

# This script will determine how screens should be positioned relative
# to each other based on their respective width.
#
#
# relative positon from the upper left corner
# +0+0 <=> +x+y

#   +-------------------+-------------------+-------------------+---> x axis
#   |       screen 1    |       screen 2    |       screen 3    |
#   +-------------------+-------------------+-------------------+
#   |
#   |
#   |
#   y axis
#
#
# position = Y x X

## retrieving arguments
DOCKED=false

for i in "$@"; do
  case "$i" in
    -d | --docked)
      DOCKED=true
      ;;
  esac
done


script_dir="/home/leonch/.scripts/monitorsetup/"

create () {
    touch ${script_dir}$1
    chmod ${2} ${script_dir}$1
    chown ${3}:${3} ${script_dir}$1
    echo "${finalCommand}" > ${script_dir}$1
}

commandBuilder=""
finalCommand=""

if [ "$DOCKED" = true ] 
then

  # monitor # resolution # frequency # x relative from top # rotation # primary
  left=("HDMI-A-0" "2560x1440" "60" "0" "normal" "no")
  middle=("DisplayPort-1" "2560x1440" "60" "0" "normal" "no")
  right=("eDP" "1920x1080" "60" "360" "normal" "yes")

  # Set the monitor variable for the current setup
  monitors=(left middle right)

else

  # monitor # resolution # frequency # x relative from top # rotation # primary
  # detailed tiling with --pos option
  main=("eDP" "1920x1080" "60" "0" "normal" "yes" "yes")

  # Set the monitor variable for the current setup
  monitors=(main)

fi

current_position="0x0"
max_screen_width=0
appended_width=0

## Get the sum of all connected screen widths
for monitor in "${monitors[@]}"
do
  
  # Get the values of the current montor
  eval "values=(\"\${$monitor[@]}\")"

  # Check if a monitor is actually connected
  if xrandr --query | grep -q "${values[0]} connected"; then
      
      # Split the resolution of the current monitor into the width and height values
      IFS='x' read -ra resolution_parts <<< "${values[1]}"
      width=${resolution_parts[0]}
      
      max_screen_width=$(( max_screen_width + width ))
      
  fi
done


## Build the xrandr command
for monitor in "${monitors[@]}"
do
  
  # Get the values of the current montor
  eval "values=(\"\${$monitor[@]}\")"

  # Check if a monitor is actually connected
  if xrandr --query | grep -q "${values[0]} connected"; then

      # Add the current monitor to the command
      commandBuilder+=" --output ${values[0]}"

      if [[ ${values[5]} == "yes" ]]; then
        commandBuilder+=" --primary"
      fi
      
      # Relative position on the y axis from the top
      y=${values[3]}
      
      # Split the resolution of the current monitor into the width and height values
      IFS='x' read -ra resolution_parts <<< "${values[1]}"
      
      current_width=${resolution_parts[0]}
      
      # Determine the top left pixel for the current screen
      current_x_pos=$(( ( max_screen_width + appended_width ) - max_screen_width ))

      # Update the current position to the right of the current monitor
      current_position="${current_x_pos}x$y"
      
      # adding the rest of the command
      commandBuilder+=" --mode ${values[1]} --rate ${values[2]} --rotation ${values[4]}"

      # adding the calculated position
      commandBuilder+=" --pos ${current_position}"
      appended_width=$(( appended_width + current_width ))

      finalCommand+="$commandBuilder"
      commandBuilder=""
  fi
done


if [[ ! -z $finalCommand ]]; then
  create "latestcommand" "644" "leonch"
  xrandr $finalCommand
fi

