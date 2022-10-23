#!/bin/sh

# relative positon from the upper left corner
# +0+0 <=> +x+y

# don't forget to update the position if you intend to deactivate a monitor

 ## retrieving arguments
CONVENIENT=false
DETAILED=true

for i in "$@"; do
  case "$i" in
    -c | --convenient)
      CONVENIENT=true
      DETAILED=false
      ;;
  esac
done

create () {
    touch /home/leonch/.script/monitorsetup/"$1"
    chmod "$2" /home/leonch/.script/monitorsetup/"$1"
    chown "$3":"$3" /home/leonch/.script/monitorsetup/"$1"
    echo "${finalCommand}" > /home/leonch/.script/monitorsetup/"$1"
}

commandBuilder=""
finalCommand=""
# monitor # resolution # frequency # position # rotation # activated # primary
# detailed tiling with --pos option
left=("HDMI-0" "2560x1440" "60" "0x400" "normal" "yes" "no")
middle=("DP-2" "2560x1440" "144" "2560x400" "normal" "yes" "yes")
right=("DP-0" "2560x1440" "144" "5120x0" "right" "yes" "no")

# monitor in the far left
farLeft="HDMI-0"
# monitor in the far right
farRight="DP-0"

for monitor in left[@] middle[@] right[@]
do
  values=(${!monitor})
  if [ "$CONVENIENT" = true ] && [ "${values[0]}" != "${farLeft}" ]; then
    commandBuilder+=" ${values[0]}"
  fi

  if [[ ${values[5]} == "yes" ]]; then
    commandBuilder+=" --output ${values[0]}"
    if [[ ${values[6]} == "yes" ]]; then
      commandBuilder+=" --primary"
    fi

    # adding the rest of the command
    commandBuilder+=" --mode ${values[1]} --rate ${values[2]} --rotation ${values[4]}"

    if [ "$CONVENIENT" = true ] && [ "${values[0]}" != "${farRight}" ]; then
      commandBuilder+=" --left-of"
    fi

    if [ "$DETAILED" = true ]; then
      # Using detailed positioning by defining position by pixel
      commandBuilder+=" --pos ${values[3]}"
    fi
    finalCommand+="$commandBuilder"
    commandBuilder=""
  fi
done


if [[ ! -z $finalCommand ]]; then
  create "latestcommand" "644" "leonch"
  xrandr $finalCommand
fi

