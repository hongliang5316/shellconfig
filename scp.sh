#!/bin/sh

case $1 in
    1)
        ssh hongliang@js.yfcdn.net "y --scp $2 121.199.30.61:/tmp/"
        ;;
    2)
        ssh hongliang@js.yfcdn.net "y --scp $2 114.55.116.52:/tmp/"
        ;;
esac
