#include <iostream>
#include <cstdlib>
#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>


__global__ void vecAdd(double* res, double* inA, double* inB, size_t n) {
        int x = blockDim.x * blockIdx.x + threadIdx.x;
        if (x >= n) return;
        res[x] = inA[x] + inB[x];
}



int main () {
	int* minGridSize = (int*)malloc(sizeof(int));
	int* blockSize = (int*)malloc(sizeof(int));
	cudaError_t err = cudaOccupancyMaxPotentialBlockSize(minGridSize, blockSize, 
								vecAdd);
	std::cout << "Occupancy minGridSize = " << *minGridSize << ", blockSize = " << *blockSize << std::endl;

	return 0;
}

