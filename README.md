# IBS SW-Spindles — Organized Copy

Local reorganization of the external-drive folder `1 - Backup perso/1 - SW Spindles`
(source, as of 2026-08-25: `/Volumes/NRANCE_PTN2/1 - Backup perso/1 - SW Spindles`).

This is the Latchoumane et al. sleep-spindle / slow-oscillation (SO) / ripple TRN-optogenetic-stimulation
study: closed-loop TRN stimulation locked to detected cortical slow waves, analyzed across frontal (FRO),
parietal (PAR), and hippocampal CA1 channels, with fear-conditioning (FC) and object-place recognition (OPR)
behavioral readouts. Six main figures + associated supplementary figures.

## Folder layout

- `00_raw_full_copy/` — **untouched, complete copy** of the entire source folder (11 GB, 4084 files),
  exactly as it was on the drive. Nothing below is a move — everything else in this repo is a *copy*
  reorganized for clarity. If anything below looks wrong or incomplete, the ground truth is here.
- `code/figureN/` — MATLAB scripts (`.m`) used to generate each main figure's stats/plots.
- `data/figureN/` — the `.mat`/`.xlsx`/`.sav` data files each figure's scripts load.
- `data/detection_events/` — SPSS `.sav` files with spindle/SO/ripple detection accuracy and event
  characteristics (see [`summaries/detection_events_summary.md`](summaries/detection_events_summary.md)
  for the point-5 dataset identification).
- `data/shared_overview/` — cross-figure overview spreadsheets and raw behavioral exports (freeze-frame
  CSVs, mouse overview tables) not tied to one specific figure.
- `finished_figures/figureN/` — rendered outputs: Keynote/PowerPoint panels, PDFs, TIFFs, boxplots.
- `summaries/` — one summary file per figure (data type, how-to-reproduce, script used), plus the
  detection-dataset writeup.

## Source structure not yet reorganized (secondary, per your note)

Everything else from the original folder is preserved as-is inside `00_raw_full_copy/`, including:

- `Data Analysis Remake 201608/` — an earlier remake pass (predates the 201703 one used here).
- `Revision 20170123/`, `Revions resubmission 20170505/`, `Revision 20170601/` — manuscript revision
  rounds (docx drafts, reviewer responses, resubmission packages).
- `Manuscript FC/`, `Histology/`, `IEG study/`, `Patent/`, `PFCsingleunit/`, `Matlab Arduino Online/`,
  `Pvcre Data/`, `Spindle Conference/` — adjacent projects/materials, not part of the SW-spindle figure set.

You flagged these as secondary/possible-additional-data. They were **not** picked apart into
code/data/figures because `Data Analysis Remake 201703` is the folder you identified as containing the
important data, and that's what's fully reorganized above. Say the word if you want any of these
mined the same way.

## Figure map (main ↔ supplementary)

Derived from the clean naming in `00_raw_full_copy/Data Analysis Remake 201703/Figure Final/`:

| Main figure | Topic | Supplementary figures |
|---|---|---|
| Fig 1 | TRN stimulation, CA1 mapping, OPR/FC behavior | S1 (TRN–CA1 map), S2 (OPR) |
| Fig 2 | Stim-locked averages (FRO in/out), phase plots, representative traces | S3, S3new (rep traces), S4 (phase plots) |
| Fig 3 | Slow-wave/spindle stats by channel (FRO/PAR/CA1) | — |
| Fig 4 | Behavioral stats (FRO/PAR) | — |
| Fig 5 | Ripple-locked averages, spindle-trough–CA1-ripple coupling, EVPs, time-frequency | S5, S6, S7, S9 |
| Fig 6 | Coherent SO–spindle–ripple events, 20 Hz control stim, GFP/ChR2 behavior | S7, S8 |

## Caveat on file naming case-sensitivity

The original scripts were written on a case-insensitive Mac filesystem. At least one load call has a
casing mismatch with the actual file on disk (`run_stat_figPvcreGFPCHR2.m` calls
`load('Behavior_FCPVcreGFPCHR2.mat')` but the file is `Behavior_FCPvcreGFPCHR2.mat`). This repo's copy
(`data/figure6/`) has the **original** filename — fix the `load()` call or rename the file if you run
this script on a case-sensitive filesystem (Linux, or anything git-backed).
