# Spindle / SO / Ripple Detection & Timing — Dataset Identification

Dug into `Data Analysis Remake 201703`, `Data Analysis Remake 201608`, and the top-level `1 - SW Spindles`
folder (all inside `00_raw_full_copy/`, untouched). Inspected `.mat` files with Python
(`scipy.io`/`h5py`) and `.xlsx` files with `openpyxl` rather than trusting filenames alone.

## Bottom line

**No file in this backup contains a literal per-event onset/offset timestamp list** (e.g. "spindle #1 at
t=142.35s, offset 142.61s"). That raw data was either never saved to disk in this form or wasn't backed
up here. But three tiers of increasingly-close-to-raw detection/timing data **do** exist, and one of them
directly satisfies "relative position of detected events":

### 1. Best match — peri-stimulus time histograms of event position (relative timing)
**`TriggerEvtCorrOnset.xlsx`** and **`TriggerEvtCorrPeaks.xlsx`** (top level of `1 - SW Spindles`, copied
to `data/detection_events/`). Each has sheets `Spi`/`Spindles`, `Ripples`, `Sweeps`:
- Column 1 = time axis in seconds, **-0.5 to +~2.5s in 50ms bins**, relative to the stimulation trigger.
- Remaining columns = spindle/ripple occurrence counts in each time bin, split by condition
  (`In`, `InAlt`, `Out`) and channel (PFC/CA1).
- `Sweeps` sheet = number of trials per condition (e.g. 705, 985, 1025...) used to build each histogram.

This is a genuine **relative-position-of-detected-events** dataset — cross-correlation histograms of
spindle/ripple timing around the closed-loop stimulation trigger. `Onset` and `Peaks` are two alignment
variants (aligned to event onset vs. event peak). No `.m` script in the backup references these filenames
directly, so they were likely built by a script not retained here, or generated interactively — but the
output itself is intact.

### 2. Per-mouse detection statistics (count, density, frequency, power — no timestamps)
`data/shared_overview/Analysis XLS/Analysis xls 20170411 drive/`:
- **`SOOptoStim-DetectionStats.xlsx`** — one row per mouse × condition, columns = Count, Length(s),
  Density(per min), Frequency, Power, separately for slow spindles, broadband spindles, ripples, and slow
  waves, per channel (PFC/PAR/CA1). This is the real "how many events, how dense, how strong" table.
- **`SOOptoStim-FalsePosEvts.xlsx`**, **`SOOptoStim-Overall-CoherentEvts.xlsx`**,
  **`SOOptoStim-StimIncidence-*.xlsx`** — false-positive rates and cross-channel coherent-event counts,
  same per-mouse row structure.
- MATLAB equivalents in `00_raw_full_copy/Data Analysis Remake 201608/`: **`StimFalsePositiveRate.mat`**
  / **`StimFalsePositiveRate2.mat`** (`IN`, `OUT`, `INARC`, etc. — per-mouse arrays with columns
  `AbsALL, AbsNREM, AbsCorrected, PercALL, PercNREM, PercCorrected`) and **`SoSpi.mat`** (SO-spindle
  coupling rates per group). SPSS equivalents: `DetectionAccuracy_SpindleRipple.sav`,
  `SOSPINRIP_characteristics.sav`, `OSOI_cohFROPARCA1_spindleripple.sav` (row-level content not inspected
  — no SPSS reader available in this session; open with `pandas.read_spss()` via `pyreadstat`, or PSPP).

### 3. The actual detection algorithm (no data, but explains how events were timed)
**`00_raw_full_copy/Data Analysis Remake 201608/SWdetection_arduino4Blue.m`** — the real-time closed-loop
detection code (Dr. Latchoumane, "Online SW detection"). It runs on an Arduino reading analog EEG/EMG,
does downward-threshold-crossing detection of the slow oscillation, and on detection fires a TTL pulse
(`digitalWrite`) straight into the Neuralynx recording system (pins `TTLMS8`/`TTLNLX`) plus a status LED.
**This confirms why no local per-event timestamp file exists**: the "timestamp" of each detection was a
TTL pulse embedded live into the raw Neuralynx electrophysiology recording (as an event/marker channel),
not something the online script wrote to a MATLAB file. The only local trace it keeps is a session-total
detection count (`total_count.mat`, per-run, not per-event).

## Where the actual raw timestamps most likely live (not in this backup)

The true per-event timestamps are almost certainly embedded as event/marker channels inside the raw
Neuralynx recording files (`.ncs`/`.nev`) for each session — which live in a separate raw-recordings
backup, not under `1 - SW Spindles` (this folder is the downstream *analysis* backup). If you have access
to the raw Neuralynx session folders elsewhere on your drives, that's where to look; I don't have a path
to them from what's been shared so far.

## Recommendation

For your immediate purposes (paper figures, detection validity, event density/rate comparisons across
conditions), **`data/detection_events/`** (now includes `TriggerEvtCorrOnset.xlsx`,
`TriggerEvtCorrPeaks.xlsx`, plus the `.sav` files) and
`data/shared_overview/Analysis XLS/.../SOOptoStim-DetectionStats.xlsx` are the right files to use. If you
specifically need raw per-event timestamps (e.g. to redo detection or re-align differently), those would
need to come from the raw Neuralynx recordings, not this analysis backup.
