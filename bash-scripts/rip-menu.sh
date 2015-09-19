#!/bin/bash

# rip-menu

IPTVDIR="$HOME/Documents/iptv" 

EXT='.txt' # file extension
fileList=$(find $IPTVDIR -maxdepth 1 -type f -name "*.txt" -exec basename -s $EXT {} \;)

function which_play {
    local PS3="Enter a number next to a video, or press '1' to quit: "

    select fileName in quit $fileList; do
        case $fileName in
	quit ) 
	break ;;
	$fileName ) rip-ffplay.sh ${IPTVDIR}/${fileName}$EXT ;;
	* ) echo “Invalid Selection, enter a number” ;;
        esac
    done
}

function which_record {
    local PS3="Enter a number next to a video, or press '1' to quit: "

    select fileName in quit $fileList; do
        case $fileName in
	quit ) 
	break ;;
	$fileName ) rip-ffmpeg.sh ${IPTVDIR}/${fileName}$EXT ;;
	* ) echo “Invalid Selection, enter a number” ;;
        esac
    done
}

function which_stream {
    local PS3="Enter a number next to a video, or press '1' to quit: "

    select fileName in quit $fileList; do
        case $fileName in
	quit ) 
	break ;;
	$fileName ) rip-ffmpeg-stream.sh ${IPTVDIR}/${fileName}$EXT ;;
	* ) echo “Invalid Selection, enter a number” ;;
        esac
    done
}

ACTIONS=("quit" "play" "record" "stream")
PS3="Make a selection, or press '1' to quit: "

select action in "${ACTIONS[@]}"
do
    case $action in
        "quit") 
	break ;;
        "play") which_play 
	break ;;
        "record") which_record 
	break ;;
        "stream") which_record 
	break ;;
    esac
done