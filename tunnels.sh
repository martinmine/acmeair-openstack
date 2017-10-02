#!/bin/bash

ssh -M -S web -fnNT -L 9000:172.16.1.130:80 martisny@skyhigh.hig.no &

ssh -M -S manager-host1 -fnNT -L 9001:172.16.1.130:8081 martisny@skyhigh.hig.no
ssh -M -S manager-host2 -fnNT -L 9002:172.16.1.54:8081 martisny@skyhigh.hig.no
ssh -M -S manager-host3 -fnNT -L 9003:172.16.1.139:8081 martisny@skyhigh.hig.no
ssh -M -S manager-host4 -fnNT -L 9004:172.16.1.110:8081 martisny@skyhigh.hig.no
ssh -M -S manager-host5 -fnNT -L 9005:172.16.1.137:8081 martisny@skyhigh.hig.no
ssh -M -S manager-host6 -fnNT -L 9006:172.16.1.3:8081 martisny@skyhigh.hig.no
ssh -M -S manager-host7 -fnNT -L 9007:172.16.1.145:8081 martisny@skyhigh.hig.no
