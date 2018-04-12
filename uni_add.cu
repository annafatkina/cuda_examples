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


void add() {
	size_t N = 1000;
	double *A;
	double *B;
	double *C;
	cudaError_t err;
	int alloc_size = N*sizeof(double);

        err = cudaMallocManaged(&A, alloc_size);
        if (err != cudaSuccess) {
                printf("ERROR: unable to  allocate!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }

        err = cudaMallocManaged(&B, alloc_size);
        if (err != cudaSuccess) {
                printf("ERROR: unable to  allocate!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }

        err = cudaMallocManaged(&C, alloc_size);
        if (err != cudaSuccess) {
                printf("ERROR: unable to  allocate!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }

	for(int i = 0; i < N ; i++) {
		A[i] = i;
		B[i]= N*i;
	}
	
	vecAdd<<<N,1>>>(C, A, B, N);
	cudaDeviceSynchronize();
	
	for(int i =0;i<N;i++) {
		std::cout << A[i] << " + " << B[i] << " = " << C[i] <<std::endl;
	}
}



int main () {
	add();
	return 0;
}

