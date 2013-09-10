sudo ip route del 10.0.0.0/8 via 10.16.0.1
sudo ip addr add 10.16.3.251/22 dev enp3s0
sudo ip route add 10.0.0.0/8 via 10.16.0.1 dev enp3s0
