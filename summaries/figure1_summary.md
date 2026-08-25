# Figure 1 — TRN Stimulation / CA1 Mapping / OPR & FC Behavior

## Data type
MATLAB `.mat` files (behavioral scoring, struct arrays) + `.xlsx` overview tables. No raw traces —
these are per-mouse/per-condition summary behavior scores (freezing %, object exploration preference).

- `BehaviorFC_PVtg.mat`, `BehaviorFC_PVcre.mat` — fear-conditioning freezing scores, PVtg vs PVcre lines.
- `BehaviorOPR_PVtg.mat` — object-place recognition preference scores.
- `OverviewMice201703Hongi.xlsx`, `OverviewMice20170415Hongi.xlsx`, `DataOverview_RecBehavior_Hongi_Charles201703.xlsx`
  — per-animal recording/behavior overview tables (which mouse, which condition, which session).

## How to reproduce
1. Open MATLAB with working directory set to `data/figure1/`.
2. Run `run_stats_Behaviorfig1fig6.m` (shared with Figure 6 — it contains both figures' behavior blocks;
   run the full script, Fig 1's blocks are the `BehaviorFC_PVtg`/`BehaviorOPR_PVtg`/`BehaviorFC_PVcre`
   sections near the top).
3. Script loads each `.mat`, computes group stats, and plots into MATLAB figure windows (`figure(h2)`).

## Script used
`code/figure1/run_stats_Behaviorfig1fig6.m`

## Finished outputs
`finished_figures/figure1/` — `Figure1.pptx/.key/.pdf` (main), `FigureS1_F1_TRNCA1map.*` (TRN–CA1
mapping supplement), `FigureS2_F1_OPR.*` (OPR supplement), `FigureCA1Mapping.key`.
