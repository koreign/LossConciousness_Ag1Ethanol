# Figure 6 — Coherent SO–Spindle–Ripple Events, 20 Hz Control Stim, GFP/ChR2 Behavior

## Data type
MATLAB `.mat` structs (SO/spindle/ripple coherence & coupling per channel) + behavioral `.mat`/SPSS `.sav`
files for the optogenetic control condition (GFP vs ChR2, 20 Hz stim).

- `Fig6SO.mat`, `Fig6Srip_slow.mat`, `Fig6c_slow.mat`, `Fig6cc_slow.mat`, `Fig6ccc_slow.mat`, `Fig6rip.mat`
  — panel-specific FRO/PAR/CA1 summary structs (SO, ripple, and coupling variants).
- `FigCTR20Hz.mat` — 20 Hz control-stimulation condition summary.
- `Fig_cohInci.mat`, `Corr_OSFC_Coh.mat` — coherence incidence and OS-FC coherence correlation.
- `Behavior_FCPvcreGFPCHR2.mat`, `Behavior_FC_PvcreGFPCHR2_20Hz.mat` — GFP/ChR2 fear-conditioning behavior.
- `FCcreGFPCHR20_2groups.sav`, `FCcre_4groups.sav` — SPSS group-comparison stats for the same.

## How to reproduce
1. Working directory `data/figure6/`.
2. Behavior + SO/ripple panels: run `run_stats_Behaviorfig1fig6.m` (shared with Fig 1 — the Fig-6 blocks
   from line ~138 load `Behavior_FC_PvcreGFPCHR2_20Hz.mat`, `FigCTR20Hz.mat`, `Fig6c_slow.mat`,
   `Fig6cc_slow.mat`, `Fig6rip.mat`, `Fig6Srip_slow.mat`, `Fig6ccc_slow.mat`).
3. Coherent spindle-ripple stats: run `run_stats_coherentSpinRIp.m` (loads `Fig_cohInci.mat` and
   `Corr_OSFC_Coh.mat`).
4. GFP/ChR2 control behavior: `run_stat_figPvcreGFPCHR2.m` — **note:** this script calls
   `load('Behavior_FCPVcreGFPCHR2.mat')` but the actual file is `Behavior_FCPvcreGFPCHR2.mat` (case
   differs). Works fine on the original case-insensitive Mac filesystem; fix the call or rename the file
   if running on a case-sensitive filesystem.

## Script used
`code/figure6/run_stats_Behaviorfig1fig6.m`, `run_stats_coherentSpinRIp.m`, `run_stat_figPvcreGFPCHR2.m`.

## Finished outputs
`finished_figures/figure6/` — `Figure6_4.pptx/.key` (main), `FigureS7_F6_ControlStim20Hz.pptx`,
`FigureS8_F6_ControlStim20Hz.key`, extensive boxplot set (`boxplot_FCcreARCH_FIg6_*`,
`boxplot_FCcreGFPCHR20Hz_*`, `boxplot_FCcre_Fig6Behavior*`), plus the `Figure FC PvcreGFPCH/` panel
subfolder.
