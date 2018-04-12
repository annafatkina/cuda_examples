echo "GPU"
nvcc -std=c++11 imgload.cpp cuProc.cu -lpng -o cuimg
./cuimg ~/neutron.png ooo.png "$1"
./cuimg ~/neutron.png ooo.png "$1"
./cuimg ~/neutron.png ooo.png "$1"
./cuimg ~/neutron.png ooo.png "$1"
./cuimg ~/neutron.png ooo.png "$1"
echo "CPU"
g++ -std=c++11 imgload2.cpp -lpng -o cpuimg
./cpuimg ~/neutron.png ooo.png "$1"
./cpuimg ~/neutron.png ooo.png "$1"
./cpuimg ~/neutron.png ooo.png "$1"
./cpuimg ~/neutron.png ooo.png "$1"
./cpuimg ~/neutron.png ooo.png "$1"
