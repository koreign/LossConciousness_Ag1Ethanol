# Shared / Overview Data (not tied to one figure)

`data/shared_overview/` holds cross-figure reference material that multiple figures/scripts draw on, or
that's raw experiment bookkeeping rather than figure-specific results:

- `Analysis XLS/` — the full "Analysis xls 20170411 drive" export: per-condition detection-stats and
  stim-incidence spreadsheets (`SOOptoStim-DetectionStats.xlsx`, `SOOptoStim-StimIncidence-*.xlsx` for
  spindles/ripples/slow-waves/coherent events), sleep architecture, false-positive rates. Useful
  cross-reference for the detection-accuracy question — see
  [`detection_events_summary.md`](detection_events_summary.md).
- `FC 20170407 Pvcre GFPCHR2 20Hz behavior/` — raw FC behavior data summary + experiment notes for the
  20 Hz GFP/ChR2 cohort (feeds Figure 6).
- `OIcreS behavior/` — raw freeze-frame CSVs (`freeze_FCcond.csv`, `freeze_FCcont.csv`,
  `freeze_FCtone*.csv`) and per-condition summary spreadsheets — the underlying per-trial behavioral data
  that `BehaviorFC_*.mat` files (Figures 1 & 6) were likely derived from.
- `BehaviorFCtg.xlsx`, `FCsummary_OIcre_20160914.xlsx` — top-level behavior/FC summary tables.
- `drive-download-20170411T015901Z-001/` — a Google-Drive export bundle (Results-CoherentEvts.pptx +
  matching coherent-events spreadsheets), duplicate/backup of material also under `Figure/` and
  `Analysis XLS/`.

No dedicated script list here — these feed multiple figures' scripts as raw/reference inputs rather than
being consumed by one specific `run_stat*.m` file.
