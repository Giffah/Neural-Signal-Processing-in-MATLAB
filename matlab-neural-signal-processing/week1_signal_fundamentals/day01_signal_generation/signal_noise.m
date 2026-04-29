%% ---------------------------------------
% DAY 1: Signal Generation & Noise Models

% Author: Alexander Giffah
% Human Motion Analysis Lab

clear; clc; close all;

%-----------------------------------------
%% --- SECTION 1: Basic parameters
fs   = 2000;          % Sampling frequency 
T    = 2;             % Duration in seconds
t    = 0:1/fs:T-1/fs; % Time vector
N    = length(t);     % Total number of samples

fprintf(' Signal: %.1f s, fs = %d Hz, N = %d samples\n',T, fs, N);

%% ------SECTION 2: Deterministic signals---

% 2a. single sinusoid 
f1 = 10;   %Hz
A1 = 1.0;  % Amplitude
phi1 = 0;  % Phase offset

s_alpha = A1*sin(2*pi*f1*t + phi1);

%2b. Mutli-component signal

f_beta = 20;  % Hz
f_gamma = 40; % Hz

s_eeg = 1.0*sin(2*pi*f1*t) + ...   % alpha (8-12 Hz)
    0.5*sin(2*pi*f_beta*t) + ...   % beta  (13-30 Hz)
    0.2*sin(2*pi*f_gamma*t);       % gamma (30-80 Hz)


% 2c. Synthetic EMG burst
% Real EMG = bandlimited noise (20-500 Hz) shaped by a contraction envelope
% Step 1: create a smooth amplitude envelope (Gaussian bell curve)
t_center = T/2;    % Burst centered at 1 second
t_width = 0.3;     % Width of burst( standard deviation in seconds)
envelope = exp(-((t-t_center).^2)/ (2*t_width.^2));

% Step 2 : Multiply the envelope by bandlimited noise
rng(42);
raw_emg = randn(1,N);    % white noise as the "carrier"
s_emg=envelope.*raw_emg; 

%% --- SECTION 3: Noise models ---

% 3a. White noise — flat spectrum, all frequencies equal power
sigma = 0.3;             % Standard deviation controls noise amplitude
n_white = sigma * randn(1, N);

% 3b. Pink (1/f) noise via spectral shaping
    % Method: generate white noise in frequency domain, scaled by 1/sqrt(f)

f_axis = (0:N-1)*(fs/N);   % frequency axis
f_axis(1) = 1;
pink_fft = randn(1,N) +1i*randn(1,N);  % complex white noise spectrum
pink_fft = pink_fft ./ sqrt(f_axis);  % shape: divide the amplitude by sqrt(f)
n_pink = real(ifft(pink_fft));          % back to time domain
n_pink = n_pink / std(n_pink) * sigma;    % normalize to same std

% 3c. AR(2) noise — resonant noise with a spectral peak
%     AR coefficients shape the spectrum: x[n] = a1*x[n-1] + a2*x[n-2] + e[n]
%     These coefficients create a resonance at ~15 Hz (beta-like)
a_ar = [1, -1.5, 0.8];   % AR polynomial: 1 - 1.5z^-1 + 0.8z^-2
e    = sigma * randn(1, N);
n_ar = filter(1, a_ar, e);  % filter(b, a, x): b=1 (no MA part), a=AR coefficients
n_ar = n_ar / std(n_ar) * sigma;


%% --- SECTION 4: Mix signal + noise at a target SNR ---

% Function to add noise at a specific SNR (dB)
% P_signal / P_noise = 10^(SNR_dB/10)
target_snr_dB = 10;   % 10 dB SNR — fairly noisy, realistic for sEMG

P_signal = mean(s_eeg.^2);                        % Signal power
P_noise  = P_signal / 10^(target_snr_dB/10);      % Required noise power
noise_scaled = n_white * sqrt(P_noise / mean(n_white.^2));

x_noisy = s_eeg + noise_scaled;

% Verify actual SNR
actual_snr = 10*log10(mean(s_eeg.^2) / mean(noise_scaled.^2));
fprintf('Target SNR: %.1f dB | Actual SNR: %.1f dB\n', target_snr_dB, actual_snr);

%% --- SECTION 5: Visualize everything ---

figure('Position', [100 100 1200 900], 'Color', 'w');

% Row 1: Deterministic signals
subplot(3,3,1)
plot(t, s_alpha, 'b', 'LineWidth', 1);
xlabel('Time (s)'); ylabel('Amplitude'); title('Alpha oscillation (10 Hz)');
xlim([0 0.5])  % Zoom to see cycles

subplot(3,3,2)
plot(t, s_eeg, 'b', 'LineWidth', 1);
xlabel('Time (s)'); title('Multi-component EEG signal');
xlim([0 0.5])

subplot(3,3,3)
plot(t, s_emg, 'r', 'LineWidth', 1); hold on;
plot(t, envelope, 'k--', 'LineWidth', 2);
xlabel('Time (s)'); title('Synthetic EMG burst + envelope');
legend('EMG', 'Envelope');

% Row 2: Noise models
subplot(3,3,4)
plot(t(1:500), n_white(1:500), 'Color', [0.4 0.4 0.4]);
xlabel('Time (s)'); title('White noise'); ylabel('Amplitude');

subplot(3,3,5)
plot(t(1:500), n_pink(1:500), 'Color', [0.6 0.2 0.6]);
xlabel('Time (s)'); title('Pink (1/f) noise');

subplot(3,3,6)
plot(t(1:500), n_ar(1:500), 'Color', [0.2 0.5 0.2]);
xlabel('Time (s)'); title('AR(2) noise (resonant ~15 Hz)');

% Row 3: Power spectral density of each noise type
f_welch = 0:1:fs/2;  % We'll plot up to Nyquist

subplot(3,3,7)
[pxx, f] = pwelch(n_white, 256, 128, 512, fs);
plot(f, 10*log10(pxx), 'Color', [0.4 0.4 0.4], 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('Power (dB)'); title('PSD: White (flat)');
xlim([0 200]);

subplot(3,3,8)
[pxx, f] = pwelch(n_pink, 256, 128, 512, fs);
plot(f, 10*log10(pxx), 'Color', [0.6 0.2 0.6], 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); title('PSD: Pink (1/f slope)');
xlim([0 200]);

subplot(3,3,9)
[pxx, f] = pwelch(n_ar, 256, 128, 512, fs);
plot(f, 10*log10(pxx), 'Color', [0.2 0.5 0.2], 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); title('PSD: AR(2) (spectral peak)');
xlim([0 200]);

sgtitle('Day 1: Signal Generation & Noise Models', 'FontSize', 14, 'FontWeight', 'bold');

%% --- SECTION 6: Save your signals for use tomorrow ---
save('day1_signals.mat', 's_eeg', 's_emg', 'envelope', ...
     'n_white', 'n_pink', 'n_ar', 'x_noisy', 'fs', 't', 'N', 'T');
fprintf('\nSignals saved to day1_signals.mat — load these in Day 2!\n');





