%% This function estimates and applies the PRNU correction in digital mammography images
% 
%  Inputs:    z_hat - Image after the PRNU correction
%             z  - Noisy image
%             Rho - PRNU (structural noise) map
%             MeanValues - Uniform signal levels
%
%  THIS WORK SHOULD ONLY BE USED FOR NON-PROFIT PURPOSES!

function [z_hat, Rho_est, Mean_C, Variance_C, Mean, Variance, P1, P2] = StructuralNoiseCorrection(z_hat,z,Rho,MeanValues)
    %% Averaging uniform images
    PixelDistCW = 600;
    PixelSizeROI = 100;
    ROI = z_hat(floor(size(z,1)/2)-(PixelSizeROI/2)+1:floor(size(z,1)/2)+(PixelSizeROI/2), end-PixelDistCW-PixelSizeROI+1:end-PixelDistCW, :);
    ExpVal = mean2(mean(ROI, 3));

    %% PRNU map estimation
    Rho_est = mean(z_hat, 3) ./ ExpVal;
    
    %% PRNU map correction
    z_hat = (z) ./ repmat(Rho, [1, 1, size(MeanValues, 2)]);

    %% Noise parameters estimation
    Mean_C = zeros(length(MeanValues), 1);
    Variance_C = zeros(length(MeanValues), 1);
    Mean = zeros(length(MeanValues), 1);
    Variance = zeros(length(MeanValues), 1);

    for i = 1:length(MeanValues)
        [Mean_C(i), Variance_C(i)] = calculateMetrics(z_hat(:,:,i), PixelSizeROI, PixelDistCW, Rho, 'dct');
        [Mean(i), Variance(i)] = calculateMetrics(z(:,:,i), PixelSizeROI, PixelDistCW, Rho, 'dct');
    end

    P2 = polyfit(Mean_C, Variance_C, 2);
    P1 = polyfit(Mean, Variance, 2);
end

function [meanVal, varVal] = calculateMetrics(z_hat, PixelSizeROI, PixelDistCW, Rho, method)
    z_rls = z_hat(floor(size(Rho,1)/2)-(PixelSizeROI/2)+1:floor(size(Rho,1)/2)+(PixelSizeROI/2), end-PixelDistCW-PixelSizeROI+1:end-PixelDistCW);
    meanVal = mean2(z_rls);
    if strcmp(method, 'dct')
        Detrend = dct2(z_hat);
        N = 10;
        Nmask = [0:N] + [0:N]' > N;
        Detrend(1:N+1, 1:N+1) = Detrend(1:N+1, 1:N+1) .* Nmask;
        Detrend = idct2(Detrend);
        ROI = Detrend(floor(size(Rho,1)/2)-(PixelSizeROI/2)+1:floor(size(Rho,1)/2)+(PixelSizeROI/2), end-PixelDistCW-PixelSizeROI+1:end-PixelDistCW);
        varVal = std2(ROI)^2;
    else
        varVal = std2(z_rls)^2;
    end
end
