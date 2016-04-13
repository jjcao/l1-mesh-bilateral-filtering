#include "mex.h"
#include <math.h>

void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double sigmaC, sigmaS, *centersFace, *normalsFace, *areasFace;   
    double sum, Wc, Ws, *neighbors, distCenters, distNormals, *K, *omega;
    mxArray *neighborsArray;
    mwSize nFaces, nzmax, nNeighbors;
    mwIndex i, j, x, y, pitch, k, *irs_omega, *jcs_omega;
   
    centersFace =  mxGetPr(prhs[0]);
    sigmaC = mxGetScalar(prhs[2]);
    normalsFace = mxGetPr(prhs[3]);
    sigmaS = mxGetScalar(prhs[4]);
    areasFace = mxGetPr(prhs[5]);
    nFaces = mxGetNumberOfElements(prhs[5]);
    pitch = nFaces;
    nzmax = (mwSize)(45*nFaces);
    
    plhs[0] = mxCreateDoubleMatrix(nFaces,1,mxREAL);
    K = mxGetPr(plhs[0]);
    plhs[1] = mxCreateSparse(nFaces,nFaces,nzmax,mxREAL);
    omega  = mxGetPr(plhs[1]);
    irs_omega = mxGetIr(plhs[1]);
    jcs_omega = mxGetJc(plhs[1]);

    k = 0;
    for (j = 0; j < nFaces; j++) 
    {
        jcs_omega[j] = k;
        sum = 0;
        neighborsArray = mxGetCell(prhs[1],j);
        nNeighbors = mxGetNumberOfElements(neighborsArray);
        neighbors = mxGetPr(neighborsArray);
        for (i = 0; i < nNeighbors; i++)
        {
            y = j;
            x = neighbors[i] - 1;
            distCenters = (centersFace[x] - centersFace[y]) * (centersFace[x] - centersFace[y])
                         + (centersFace[pitch+x] - centersFace[pitch+y]) * (centersFace[pitch+x] - centersFace[pitch+y])
                         + (centersFace[2*pitch+x] - centersFace[2*pitch+y]) * (centersFace[2*pitch+x] - centersFace[2*pitch+y]);
            distNormals = (normalsFace[x] - normalsFace[y]) * (normalsFace[x] - normalsFace[y])
                         + (normalsFace[pitch+x] - normalsFace[pitch+y]) * (normalsFace[pitch+x] - normalsFace[pitch+y])
                         + (normalsFace[2*pitch+x] - normalsFace[2*pitch+y]) * (normalsFace[2*pitch+x] - normalsFace[2*pitch+y]);
            Wc = exp( - distCenters / (2 * sigmaC * sigmaC));
            Ws = exp( - distNormals / (2 * sigmaS * sigmaS));
            omega[k] = areasFace[y] * Wc * Ws;
            sum = sum + areasFace[y] * Wc * Ws;
            irs_omega[k] = x;
            k++;
        }
        K[j] = 1 / sum;
    }
    jcs_omega[nFaces] = k;
}
