! R1 
enable
configure terminal
hostname NETFLIX-1
interface ethernet 0/0
no shutdown
ip address 192.168.10.1 255.255.255.252
exit
interface ethernet 0/1
no shutdown
ip address 172.16.0.1 255.255.255.252
exit
router ospf 1
router-id 172.16.0.1
network 192.168.10.0 0.0.0.3 area 0
exit
router bgp 65000
bgp router-id 172.16.0.1
network 54.237.226.0 mask 255.255.255.0
neighbor 172.16.0.2 remote-as 65001
exit
router ospf 1
redistribute bgp 65000
end
write memory

---------------------------------------------

! R2
enable
configure terminal
hostname NETFLIX-2
interface ethernet 0/0
no shutdown
ip address 192.168.20.1 255.255.255.252
exit
interface ethernet 0/1
no shutdown
ip address 192.168.10.2 255.255.255.252
exit
router ospf 1
router-id 192.168.20.1
network 192.168.10.0 0.0.0.3 area 0
network 192.168.20.0 0.0.0.3 area 0
exit
router bgp 65000
end
write memory

---------------------------------------------

! R3
enable
configure terminal
hostname NETFLIX-3
interface ethernet 0/0
no shutdown
ip address 54.237.226.1 255.255.255.0
exit
interface ethernet 0/1
no shutdown
ip address 192.168.20.2 255.255.255.252
exit
router ospf 1
router-id 54.237.226.1
network 54.237.226.0 0.0.0.255 area 0
network 192.168.20.0 0.0.0.3 area 0
exit
router bgp 65000
end
write memory

---------------------------------------------

! VPC7
set pcname NETFLIX-SRV
ip 54.237.226.2/24 54.237.226.1
save

---------------------------------------------

! R4
enable
configure terminal
hostname GOOGLE-1
interface ethernet 0/0
no shutdown
ip address 10.10.10.1 255.255.255.252
exit
interface ethernet 0/1
no shutdown
ip address 172.16.0.2 255.255.255.252
exit
router ospf 1
router-id 10.10.10.1
network 10.10.10.0 0.0.0.3 area 0
exit
router bgp 65001
bgp router-id 172.16.0.2
network 172.217.29.0 mask 255.255.255.0
neighbor 172.16.0.1 remote-as 65000
exit
router ospf 1
redistribute bgp 65001
end
write memory

---------------------------------------------

! R5
enable
configure terminal
hostname GOOGLE-2
interface ethernet 0/0
no shutdown
ip address 10.10.20.1 255.255.255.252
exit
interface ethernet 0/1
no shutdown
ip address 10.10.10.2 255.255.255.252
exit
router ospf 1
router-id 10.10.20.1
network 10.10.10.0 0.0.0.3 area 0
network 10.10.20.0 0.0.0.3 area 0
exit
router bgp 65001
end
write memory

---------------------------------------------

! R6
enable
configure terminal
hostname GOOGLE-3
interface ethernet 0/0
no shutdown
ip address 172.217.29.1 255.255.255.0
exit
interface ethernet 0/1
no shutdown
ip address 10.10.20.2 255.255.255.252
exit
router ospf 1
router-id 172.217.29.1
network 172.217.29.0 0.0.0.25	5 area 0
network 10.10.20.0 0.0.0.3 area 0
exit
router bgp 65001
end
write memory

---------------------------------------------

! VPC8
set pcname GOOGLE-SRV
ip 172.217.29.2/24 172.217.29.1
save

---------------------------------------------

