# Figure 5 — Ripple-Locked Averages, Spindle-Trough–CA1-Ripple Coupling, EVPs, Time-Frequency

## Data type
The largest and most heterogeneous data set in this project — event-locked grand averages, time-frequency
power, and per-mouse event-count summaries (see also
[`detection_events_summary.md`](detection_events_summary.md) — the closest thing to raw event data here
is still count/average level, not per-event timestamps).

- `Fig5c.mat`, `Fig5d_broad.mat`, `Fig5d_slow.mat`, `Fig5e_broad.mat`, `Fig5e_slow.mat`, `Fig5f.mat` —
  panel-specific FRO/PAR/CA1 summary structs (broadband vs slow-band variants).
- `SOOptoStim-RippleLockedAvg.mat` — ripple-locked grand-average waveforms.
- `SOOptoStim-OverallSlWaveSpiEvts-{BrdBdSpiEvts,SlSpiEvts}-scaleSDEnv2-35.mat` — per-mouse detected-event
  **counts** (broadband vs slow spindle detector), not timestamps.
- `SOOptoStim-StimLockedAvg_EEG.mat`, `_SlowWaveEvts.mat`, `_SpiTroughs-{BrdBdSpiEvts,SlSpiEvts}-*.mat` —
  MATLAB v7.3 (HDF5) files with grand-average stim-locked waveforms per channel/condition
  (`avg`, `time`, `grandavgMean`, `grandavgSEM`, `tScore`, `pVal`).
- `SOOptoStim-TF-SpiLockedRipplePwr-{BrdBdSpiEvts,SlSpiEvts}-*-750msPost.mat` — spindle-locked ripple-band
  time-frequency power.
- `SpiTrhough_CA1ripple.mat` — 34×4 numeric matrix per channel (FRO/PAR/CA1), unlabeled columns (likely
  mouse × condition summary).
- `SOOptoStim-SpiTrLocked-CA1Ripple-EvtCorr-SlSpiEvts.mat`/`.xlsx` — spindle-trough-to-CA1-ripple event
  correlation.

## How to reproduce
1. Working directory `data/figure5/`.
2. Core panels: `run_stats_Behaviorfig3fig4fig5.m` (Fig-5 blocks load `Fig5c/d/e/f.mat`, ~lines 71–110).
3. Ripple-locked average + time-frequency: `run_stat_EVPripples.m` (loads `SOOptoStim-RippleLockedAvg.mat`)
   and `PlotTimeFrequency.m` (loads the two `SOOptoStim-TF-SpiLockedRipplePwr-*.mat` files).
4. Spindle-trough–CA1-ripple coupling supplement: `run_stats_SpiTrhough_CA1ripple.m` (loads
   `SpiTrhough_CA1ripple.mat`) and `SOOptoStim_Plot_SpiTrLocked_CA1Ripple_EvtCorr_SlSpiEvts.m`.

## Script used
`code/figure5/run_stats_Behaviorfig3fig4fig5.m`, `run_stat_EVPripples.m`, `PlotTimeFrequency.m`,
`run_stats_SpiTrhough_CA1ripple.m`, `SOOptoStim_Plot_SpiTrLocked_CA1Ripple_EvtCorr_SlSpiEvts.m`.

## Finished outputs
`finished_figures/figure5/` — `Figure5_2.pptx/.key` (main), `FigureS5`–`FigureS9` supplements (spindle
trough, coherent SO-spindle-ripple, ripple-locked, phase plots), boxplots, plus the raw `Figure EVP/` and
`Figure Polar Plots/` panel subfolders (individual-channel TIFFs).
