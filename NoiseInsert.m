%% This function inserts noise in digital mammography images
% 
%  Inputs:    y - Noisy-free image
%             Rho  - PRNU (structural noise) map
%             Lambda - Gain of the quantum noise
%             Sigma_E - Standard deviation of the electronic noise
%
%  THIS WORK SHOULD ONLY BE USED FOR NON-PROFIT PURPOSES!

function [z] = NoiseInsert(y,Rho,Lambda,Sigma_E)

z = y;

% Add Structural Noise
z = z.*Rho;

% Add Quantum Noise
PoissonNoise =sqrt(Lambda.*z).*randn(size(z));

%Add Eletronic Noise
EletronicNoise = sqrt(Sigma_E^2).*randn(size(z));

noiseMap = PoissonNoise + EletronicNoise;

z = z + noiseMap;

end

