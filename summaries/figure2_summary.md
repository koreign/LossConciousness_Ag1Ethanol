# Figure 2 — Stim-Locked Averages, Phase Plots, Representative Traces

## Data type
MATLAB `.mat` files with stimulus-locked grand-average waveforms (EEG/LFP, frontal channel, IN/OUT/
NoStim conditions) plus phase-analysis results and raw representative single-trial traces.

- `SOOptoStim-StimLockedAvg_EEG_1.mat`, `_EEG_2.mat` — stim-locked EEG averages (two variants/passes).
- `SOOptoStim-StimLockedAvg.mat`, `_2.mat`, `.rtf` — averaged stim-locked amplitude (`resStimAvg`) and
  phase (`resStimPhase`) results, per condition; `.rtf` is a plain-text notes file alongside it.
- `SOOptoStim-RepTraces.mat`, `RepTraces2.mat`, `PlotRepTraces3.mat` — representative single-trial traces
  (spindle/ripple/slow-wave examples used for the rep-trace supplementary panels).

## How to reproduce
1. Working directory `data/figure2/`.
2. Main stim-locked average plot: run one of
   `SOOptoStim_Plot_StimLockedAvg.m` / `_charles.m` / `_sample.m` (three variants of the same plot,
   likely iterative edits — `_charles.m` is probably the final one used).
3. Phase plot (compass/polar plots of stim phase by condition): run `run_stat_phasefig.m` (loads
   `SOOptoStim-StimLockedAvg.mat`).
4. Evoked-potential panel: `run_stat_EVP.m` (loads `SOOptoStim-StimLockedAvg_2.mat`).
5. Representative traces: `SOOptoStim_PlotRepTraces.m` and `_PlotRepTraces2.m`.

## Script used
`code/figure2/SOOptoStim_Plot_StimLockedAvg_charles.m` (primary), `run_stat_phasefig.m`, `run_stat_EVP.m`,
`SOOptoStim_PlotRepTraces.m`, `SOOptoStim_PlotRepTraces2.m`.

## Finished outputs
`finished_figures/figure2/` — `Figure2.pptx/.key` (main), `FigureS3_F2_RepTraceSpin.*`,
`FigureS3new_F2_RepTraceSpin.key`, `FigureS4_F2_PhasePlots2.*`, plus rendered TIFs
(`SOOptoStim-StimLockedAvg-FROInOut*.tif`) and phase-plot PDFs.
