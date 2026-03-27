# Clearwater / Bluesky Operator Inventory

## Snapshot
- Source rows: 11764
- Active rows kept: 11764
- Unique operators: 71
- Oil-target operators: 29

## Province Coverage
- AB: 11764

## Top Operators
| Operator | Total Wells | Oil Wells | Clearwater | Bluesky | Segment |
| --- | ---: | ---: | ---: | ---: | --- |
| Imperial Oil Resources Limited | 4109 | 4031 | 4109 | 0 | oil-target |
| Canadian Natural Resources Limited | 1777 | 1094 | 981 | 796 | oil-target |
| Spur Petroleum Ltd. | 937 | 742 | 937 | 0 | oil-target |
| Tamarack Valley Energy Ltd. | 750 | 665 | 750 | 0 | oil-target |
| Baytex Energy Ltd. | 516 | 484 | 4 | 512 | oil-target |
| Headwater Exploration Inc. | 400 | 294 | 396 | 4 | oil-target |
| Obsidian Energy Ltd. | 216 | 204 | 6 | 210 | oil-target |
| Strathcona Resources Ltd. | 384 | 191 | 384 | 0 | oil-target |
| Rubellite Energy Inc. | 124 | 122 | 123 | 1 | oil-target |
| IPC Canada Ltd. | 80 | 47 | 9 | 71 | oil-target |
| Clear North Energy Corp. | 42 | 31 | 42 | 0 | oil-target |
| Woodcote Inc. | 14 | 14 | 14 | 0 | oil-target |
| ROK Resources Inc. | 16 | 13 | 0 | 16 | oil-target |
| Cardinal Energy Ltd. | 15 | 13 | 13 | 2 | oil-target |
| Saturn Oil & Gas Inc. | 15 | 13 | 0 | 15 | oil-target |
| Barrel Oil Corp. | 40 | 8 | 0 | 40 | oil-target |
| ISH Energy Ltd. | 11 | 8 | 8 | 3 | oil-target |
| Cenovus Energy Inc. | 299 | 7 | 81 | 218 | oil-target |
| Spoke Resources Ltd. | 13 | 7 | 0 | 13 | oil-target |
| Suncor Energy Inc. | 20 | 5 | 20 | 0 | oil-target |

## Recommended Pilot Candidates
| Operator | Total Wells | Oil Wells | Suggested |
| --- | ---: | ---: | --- |
| Rubellite Energy Inc. | 124 | 122 | yes |
| IPC Canada Ltd. | 80 | 47 | yes |
| Clear North Energy Corp. | 42 | 31 | yes |
| Woodcote Inc. | 14 | 14 | yes |
| ROK Resources Inc. | 16 | 13 | yes |
| Cardinal Energy Ltd. | 15 | 13 | yes |
| Saturn Oil & Gas Inc. | 15 | 13 | yes |
| Barrel Oil Corp. | 40 | 8 | yes |
| ISH Energy Ltd. | 11 | 8 | yes |
| Spoke Resources Ltd. | 13 | 7 | yes |

## Operator Aliases
- **Canadian Natural Upgrading Limited** is the same entity as **Canadian Natural Resources Limited**. Wells listed under either name should be merged under `canadian-natural-resources-limited`. The "Upgrading" subsidiary appears in PetroNinja licensee history but operates Clearwater/Bluesky wells under the parent company.
- **Harvest Operations Corp.** — appears in licensee history on 18 rows but is not a current operator in the CSV. Wells formerly held by Harvest have been transferred to other operators. Verify against fresh source data before import.

## Notes
- Machine outputs are regenerated from `Data/active_bluesky_clearwater_wells_AB_SK.csv`.
- `Data/operator_rollout_manifest_clearwater_bluesky.csv` is the editable onboarding file; manual status fields are preserved across reruns.
- `oil-target` means the operator has at least one oil or bitumen well in the source file.
- `gas-only-review` means the operator appears in the basin file but currently looks gas-weighted and should be reviewed before outreach.
