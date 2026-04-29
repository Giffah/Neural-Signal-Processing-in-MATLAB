# Neural Signal Processing in MATLAB
### A 29-Day Hands-On Curriculum | Apr 29 – May 27, 2026

> A self-directed, project-based study of signal processing and computational neuroscience methods — built from scratch in MATLAB, grounded in neuromuscular biomechanics and neural dynamics research.

---

## About This Repository

This repo documents a 4-week intensive MATLAB curriculum spanning signal processing, source separation, neural signal analysis, and dynamical systems modelling. Every session is a standalone project with annotated code, generated figures, and notes connecting the method to real neuroscience applications.

The curriculum is designed around two research threads:
- **sEMG decomposition** — convolutive BSS, motor unit analysis, and muscle synergy extraction
- **EEG/neural dynamics** — Koopman operator frameworks, Wilson-Cowan E/I modelling, and brain connectivity

---

## Repository Structure

```
matlab-neural-signal-processing/
│
├── week1_signal_fundamentals/
│   ├── day01_signal_generation/
│   ├── day02_fir_iir_filters/
│   ├── day03_fft_psd/
│   ├── day04_stft/
│   ├── day05_wavelets/
│   ├── day06_hilbert_transform/
│   └── day07_capstone_emg_pipeline/
│
├── week2_decomposition_bss/
│   ├── day08_pca_from_scratch/
│   ├── day09_ica_fastica/
│   ├── day10_convolutive_bss/
│   ├── day11_nnmf_synergy/
│   ├── day12_motor_unit_simulation/
│   ├── day13_spike_detection/
│   └── day14_capstone_semg_decomposition/
│
├── week3_neural_eeg/
│   ├── day15_eeg_band_decomposition/
│   ├── day16_csp/
│   ├── day17_coherence_cmc/
│   ├── day18_granger_causality/
│   ├── day19_erp_analysis/
│   ├── day20_lfp_population_coding/
│   └── day21_capstone_eeg_connectivity/
│
├── week4_dynamical_systems/
│   ├── day22_kalman_filter/
│   ├── day23_koopman_edmd/
│   ├── day24_dmd/
│   ├── day25_wilson_cowan/
│   ├── day26_hmm_neural_states/
│   ├── day27_dimensionality_reduction/
│   ├── day28_point_processes_isi/
│   └── day29_capstone_koopman_eeg/
│
├── shared/
│   └── utils/          # Reusable helper functions built across the curriculum
│
└── README.md
```

Each day folder contains:
```
dayXX_topic/
├── main_dayXX.m        # Main annotated script
└── figures/            # Output plots (.png)
 
```

---

## Curriculum Overview

### Week 1 — Signal Fundamentals & Spectral Analysis
*Apr 29 – May 5*

| Day | Topic | Key Methods | MATLAB Functions |
|-----|-------|-------------|-----------------|
| 1 | Signal generation & noise models | Synthetic signals, white/pink/AR noise, SNR | `randn`, `filter`, `pwelch` |
| 2 | FIR & IIR filter design | Windowed FIR, Butterworth, zero-phase | `fir1`, `butter`, `filtfilt` |
| 3 | FFT & power spectral density | DFT, Welch PSD, periodogram | `fft`, `pwelch`, `periodogram` |
| 4 | Short-time Fourier transform | STFT, spectrogram, time-frequency resolution | `spectrogram`, `stft` |
| 5 | Wavelet transforms | CWT (Morlet), DWT (db4), multi-resolution | `cwt`, `wavedec`, `wcoherence` |
| 6 | Hilbert transform & analytic signal | Instantaneous amplitude/frequency, envelope | `hilbert`, `angle`, `unwrap` |
| 7 ⭐ | **Capstone: EMG preprocessing pipeline** | Full filter→rectify→envelope→onset pipeline | Full pipeline |

---

### Week 2 — Decomposition & Source Separation
*May 6 – May 12*

| Day | Topic | Key Methods | MATLAB Functions |
|-----|-------|-------------|-----------------|
| 8 | PCA from scratch | Covariance, eigendecomposition, scree plot | `cov`, `eig`, `cumsum` |
| 9 | ICA & FastICA | Negentropy, whitening, component ordering | `fastica`, JADE |
| 10 | Convolutive BSS | Convolutive mixture model, CKC | `conv`, `fft`, `pinv` |
| 11 | NNMF & muscle synergy analysis | ALS, VAF/ΔVAF criterion, synergy sorting | `nnmf`, custom ALS |
| 12 | Motor unit spike train simulation | Onion-skin model, Gaussian ISI, MUAP library | `randn`, `cumsum`, `conv` |
| 13 | Spike detection & template matching | Threshold crossing, PCA windows, subtraction | `findpeaks`, `kmeans`, `xcorr` |
| 14 ⭐ | **Capstone: sEMG decomposition pipeline** | Simulate HD-sEMG → BSS → validate (RoA) | Full pipeline |

---

### Week 3 — Neural Signal Processing & EEG
*May 13 – May 19*

| Day | Topic | Key Methods | MATLAB Functions |
|-----|-------|-------------|-----------------|
| 15 | EEG band decomposition | δ/θ/α/β/γ bandpass, band power, topomaps | `butter`, `filtfilt`, `topoplot` |
| 16 | Common spatial patterns (CSP) | Generalized eigenvalue, spatial filters | `eig`, custom CSP |
| 17 | Coherence & corticomuscular coherence | MSC, cross-spectral density, partial coherence | `mscohere`, `cpsd` |
| 18 | Granger causality | Bivariate VAR, F-test, spectral Granger | `varm`, custom MVGC |
| 19 | Event-related potentials (ERPs) | Epoch extraction, baseline, bootstrapping | `mean`, `bootci`, `errorbar` |
| 20 | LFP & population rate coding | LIF simulation, population rate, power law | `ode45`, `histcounts` |
| 21 ⭐ | **Capstone: EEG connectivity pipeline** | Band power → coherence → Granger → graph | Full pipeline |

---

### Week 4 — Dynamical Systems & Advanced Methods
*May 20 – May 27*

| Day | Topic | Key Methods | MATLAB Functions |
|-----|-------|-------------|-----------------|
| 22 | Kalman filter | State-space model, predict-update, RTS smoother | Control Toolbox, custom loop |
| 23 | Koopman operator & EDMD | Observable lifting, EDMD, eigenfunction viz | Custom EDMD, `eig`, `kron` |
| 24 | Dynamic mode decomposition (DMD) | SVD-based DMD, eigenvalues, exact vs. optimized | `svd`, `eig`, custom DMD |
| 25 | Wilson-Cowan model simulation | Coupled E/I ODEs, phase-plane, bifurcation | `ode45`, `fsolve` |
| 26 | Hidden Markov models | Forward-backward, Baum-Welch EM, Viterbi | `hmmtrain`, `hmmviterbi` |
| 27 | Dimensionality reduction survey | t-SNE, diffusion maps, geodesic distance | `tsne`, `cmdscale` |
| 28 | Point processes & ISI analysis | ISI histogram, CV, Fano factor, cross-correlogram | `histcounts`, `xcorr` |
| 29 ⭐ | **FINAL CAPSTONE: Koopman EDMD on simulated EEG** | W-C simulation → EDMD → reconstruct E/I trajectories | Full research pipeline |

---

## Prerequisites

- MATLAB R2021b or later (R2023b recommended)
- Toolboxes used across the curriculum:
  - Signal Processing Toolbox
  - Wavelet Toolbox
  - Statistics and Machine Learning Toolbox
  - Control System Toolbox (Day 22)
  - [EEGLAB](https://sccn.ucsd.edu/eeglab/) — for `topoplot` and `fastica` (Days 9, 15)

No datasets required — all signals are synthetically generated, which means every project is fully reproducible.

---

## How to Use This Repo

Each script is self-contained and heavily annotated. The recommended workflow:

1. Navigate to the day folder
2. Open `main_dayXX.m` in MATLAB
3. Read the header comment block — it explains the concept before any code runs
4. Run section by section using `Ctrl+Enter` (Cell Mode)
5. Read the inline comments as you go — they explain *why*, not just *what*
6. Check `notes.md` for key takeaways and experiment prompts

Some days explicitly save a `.mat` file (e.g., `day01_signals.mat`) that is loaded by the next session — these dependencies are noted at the top of each script.

---

## Background & Motivation

This curriculum was built during a research internship in the **Human Motion Analysis Lab** at the University of Ghana, where ongoing work involves:

- Convolutive blind source separation applied to high-density sEMG from quadriceps and calf muscles during single-leg decline squats
- Koopman operator frameworks for reconstructing latent excitatory/inhibitory population dynamics from EEG

The project selection directly reflects methods relevant to computational neuroscience, motor control, and neural engineering.

---

## Progress

| Week | Sessions | Capstone |
|------|----------|----------|
| Week 1 — Signal Fundamentals | ⬜⬜⬜⬜⬜⬜ | ⬜ |
| Week 2 — Decomposition & BSS | ⬜⬜⬜⬜⬜⬜ | ⬜ |
| Week 3 — Neural Signals & EEG | ⬜⬜⬜⬜⬜⬜ | ⬜ |
| Week 4 — Dynamical Systems | ⬜⬜⬜⬜⬜⬜⬜ | ⬜ |

*(Update checkboxes to ✅ as sessions are completed)*

---

## License

MIT License — code is free to use, adapt, and build on.

---

*Built one session at a time. Apr 29 – May 27, 2026.*
