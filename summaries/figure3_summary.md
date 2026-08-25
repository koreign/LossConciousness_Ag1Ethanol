# Figure 3 — Slow-Wave / Spindle Stats by Channel (FRO/PAR/CA1)

## Data type
MATLAB `.mat` files, each a summary struct across FRO (frontal), PAR (parietal), CA1 channels — broadband
vs. slow-oscillation-band spindle comparisons.

- `Fig3a_broad.mat`, `Fig3a_slow.mat` — panel 3a, broadband vs slow-band.
- `Fig3b_slow.mat`, `Fig3c_slow.mat`, `Fig3bc.mat` — panels 3b/3c, slow-band only (+ combined bc file).
- `SOOptoStim-StimLockedAvg_SpiTroughs-SlSpiEvts.mat` (+ `_old.mat`) — spindle-trough-locked averages
  specific to slow spindles, used in the Figure3-Hongi supplementary panel.

## How to reproduce
1. Working directory `data/figure3/`.
2. Run `run_stats_Behaviorfig3fig4fig5.m` — shared script covering Fig 3/4/5; the Fig-3 blocks load
   `Fig3a_slow.mat`, `Fig3b_slow.mat`, `Fig3c_slow.mat` (lines ~12–47 of the script) and produce the
   channel-comparison stats/plots.
3. For the spindle-trough supplementary panel: run
   `SOOptoStim_Plot_StimLockedAvg_SpiTroughs_SlSpiEvts.m`.

## Script used
`code/figure3/run_stats_Behaviorfig3fig4fig5.m` (shared with Fig 4 & 5),
`code/figure3/SOOptoStim_Plot_StimLockedAvg_SpiTroughs_SlSpiEvts.m`.

## Finished outputs
`finished_figures/figure3/` — `Figure3_2.pptx/.key` (main), per-channel PDFs (`CA1_*.pdf`, `FRO_*.pdf`,
`PAR_*.pdf`), boxplots (`boxplot_FCtg_FIg3*.tiff`).
