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
	double *A = new double[N];
	double *B = new double[N];
	double *C = new double[N];
	double *dev_A;
	double *dev_B;
	double *dev_C;
	cudaError_t err;
	int alloc_size = N*sizeof(double);

        err = cudaMalloc((void**)&dev_A, alloc_size);
        if (err != cudaSuccess) {
                printf("ERROR: unable to  allocate!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }

        err = cudaMalloc((void**)&dev_B, alloc_size);
        if (err != cudaSuccess) {
                printf("ERROR: unable to  allocate!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }

        err = cudaMalloc((void**)&dev_C, alloc_size);
        if (err != cudaSuccess) {
                printf("ERROR: unable to  allocate!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }

	for(int i = 0; i < N ; i++) {
		A[i] = i;
		B[i]= N*i;
	}
	
	err = cudaMemcpy(dev_A, A, alloc_size, cudaMemcpyHostToDevice);
        if (err != cudaSuccess) {
                printf("ERROR: unable to copy h2d!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }
	
	err = cudaMemcpy(dev_B, B, alloc_size, cudaMemcpyHostToDevice);
        if (err != cudaSuccess) {
                printf("ERROR: unable to copy h2d!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }
	
	vecAdd<<<N,1>>>(dev_C, dev_A, dev_B, N);
	err = cudaMemcpy(C, dev_C, alloc_size, cudaMemcpyDeviceToHost);
        if (err != cudaSuccess) {
                printf("ERROR: unable to copy h2d!\n");
                std::cerr << "Err is " << cudaGetErrorString(err) << std::endl;
        }
	
	for(int i =0;i<N;i++) {
		std::cout << A[i] << " + " << B[i] << " = " << C[i] <<std::endl;
	}
	cudaFree(dev_A);
	cudaFree(dev_B);
	cudaFree(dev_C);
}



int main () {
	add();
	return 0;
}

