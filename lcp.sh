#!/bin/sh

case $1 in
    234) if [ $2 ] ;then
            sshpass -p yunfan_123 scp -P 22051 -r $2 root@192.168.2.234:~/
        else
            sshpass -p yunfan_123 ssh -o StrictHostKeyChecking=no root@192.168.2.234 -p 22051
        fi
        ;;
    15) if [ $2 ] ;then
            sshpass -p qvod_123 scp -P 22051 -r $2 root@192.168.2.15:~/
        else
            sshpass -p qvod_123 ssh -o StrictHostKeyChecking=no root@192.168.2.15 -p 22051
        fi
        ;;
    82) if [ $2 ] ;then
            sshpass -p BSJifYeTDaQw49gPjMqmL scp -P 22051 -r $2 webaby@115.231.154.82~/
        else
            sshpass -p BSJifYeTDaQw49gPjMqmL ssh -o StrictHostKeyChecking=no webaby@115.231.154.82 -p 22051
        fi
        ;;
    js) if [ $2 ] ;then
            scp -r $2 hongliang@js.yfcdn.net:~/
        else
            ssh hongliang@js.yfcdn.net
        fi
        ;;
    202) if [ $2 ] ;then
             sshpass -p yunfan_123 scp -P 22051 -r $2 webaby@192.168.1.202:~/
         else
             sshpass -p yunfan_123 ssh -o StrictHostKeyChecking=no webaby@192.168.1.202 -p 22051
         fi
         ;;
    212) if [ $2 ] ;then
             sshpass -p qvod_123 scp -P 22051 -r $2 root@192.168.1.212:~/
         else
             sshpass -p qvod_123 ssh -o StrictHostKeyChecking=no root@192.168.1.212 -p 22051
         fi
         ;;
    120) if [ $2 ] ;then
             sshpass -p qvod_123 scp -P 22051 -r $2 root@192.168.3.120:~/
         else
             sshpass -p qvod_123 ssh -o StrictHostKeyChecking=no root@192.168.3.120 -p 22051
         fi
         ;;
      8) if [ $2 ] ;then
             sshpass -p zhongt201705 scp -P 22 -r $2 zhongt@47.88.172.8:~/
         else
             sshpass -p zhongt201705 ssh -o StrictHostKeyChecking=no zhongt@47.88.172.8 -p 22
         fi
         ;;
     *)  echo 'no server' $1 'to login'
         ;;
esac

