%% This code illustrates the use of 'StructuralNoiseCorrection.m'

%  Published: R.F. Brandão; L.R. Borges; R.F. Caron; A.D.A. Maidment; M.A.C. Vieira.
%  "Photo response non-uniformity correction for digital mammography system".
%
%  NOTE: This package contains pre-calculated noise parameters from GE
%  Pristina on FFDM mode. The parameters may differ from system to system
%  depending on the calibration aspects. For more information regarding
%  noise parameter estimation please refer to the publication mentioned 
%  above.

% THIS WORK SHOULD ONLY BE USED FOR NON-PROFIT PURPOSES!

%% Starting
clear all;
close all;
clc;

%% Initial settings according to GE Pristina system
RoiTauSize = 10; % mm
PixelSize = 0.1; % mm
RoiDistCW = 60; % mm
MeanValues = [200 600 1000 1400 2200 2800 3800 5500];

%% Load data
addpath('NoiseParameters')
load('Parameters_GE_FFDM_Quadratic.mat')
load('Rho_Structural.mat')


%% Noise insertion in different signal levels
PixelSizeROI = RoiTauSize / PixelSize;
PixelDistCW = RoiDistCW / PixelSize;
[M N] = size(Lambda_e);

for m = 1:length(MeanValues)
    y = ones(M, N) .* MeanValues(m);
    
    if m < length(MeanValues)
        z(:,:,m) = NoiseInsert(y, Rho, Lambda_e, Sigma_E);
    else
        for n = 1:21
            z_rho(:,:,n) = NoiseInsert(y, Rho, Lambda_e, Sigma_E);
        end
        z(:,:,m) = z_rho(:,:,end);
        z_rho(:,:,end) = [];
    end
end

%% Structural noise estimation and correction
[z_hat, Rho_est, Mean_C, Variance_C, Mean, Variance, P1, P2] = StructuralNoiseCorrection(z_rho,z,Rho,MeanValues);

%% Plot results
plotResults(Mean_C, Variance_C, Mean, Variance, P1, P2);

