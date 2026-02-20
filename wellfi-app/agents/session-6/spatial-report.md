# Spatial Validation Report — WellFi Session 6

**Date:** 2026-02-19
**Agent:** Spatial Validator
**Script:** `scripts/validate-wells-spatial.js`

---

## Summary Statistics

| Metric | Value |
|---|---|
| Total wells checked | 211 |
| Wells INSIDE a mineral-rights parcel | 152 (72.0%) |
| Wells OUTSIDE all parcels (orphaned) | 59 (28.0%) |
| Parcels tested | 852 MultiPolygon features |

### Distance Distribution of 59 Orphaned Wells

| Distance to nearest parcel centroid | Count |
|---|---|
| < 0.5 km | 1 |
| 0.5 -- 2.0 km | 42 |
| 2.0 -- 5.0 km | 8 |
| > 5.0 km | 8 |

### Orphaned Well Status Breakdown

| Status | Count |
|---|---|
| Pumping | 57 |
| Operating | 1 |
| Suspended | 1 |

---

## Analysis

### Category 1 — Near-miss orphans (< 2 km, 43 wells)

These 43 wells are very close to an existing parcel centroid. They are almost certainly located on land that Obsidian Energy holds mineral rights to, but the parcel geometry in the GeoJSON file does not cover the exact quarter-section where the surface location falls. This is the dominant pattern: the wells are clustered in groups that share the same nearest parcel.

**Likely cause:** The GeoJSON only contains a subset of Obsidian's total mineral-rights agreements. Many Alberta oil-sands leases cover multiple sections but the GeoJSON file may list only one section polygon per agreement. Horizontal (HZ) wells in particular may have surface locations in an adjacent section to the one encoded in the GeoJSON.

**Grouped by nearest parcel:**

| Nearest Agreement | Land IDs | Wells | Avg Dist (km) |
|---|---|---|---|
| 7403110008 | T084R19W5S24A | 8 | 1.17 |
| 7403110007 | T084R19W5S23A | 6 | 1.28 |
| 7403110006 | T084R19W5S22A | 5 | 1.11 |
| 7403110009 | T084R19W5S25A | 4 | 0.88 |
| 7401060030 | T083R18W5S32-34A | 6 | 1.66 |
| 7402080023 | T083R17W5S12-13A | 4 | 1.70 |
| 7401060028 | T083R18W5S19,30,31A | 2 | 1.08 |
| 7402080032 | T084R15W5S26,35A | 2 | 1.60 |
| 7402080033 | T084R15W5S27,28A | 1 | 1.19 |
| 0525070134 | T081R15W5S30SE | 2 | 0.98 |
| 7402080018 | T083R16W5S20-21,28-29A | 1 | 0.30 |

**Single closest orphan (0.30 km):** `102022008316W509` (OBE 102 HZ 2-20-83-16) is only 300 m from parcel `7402080018` centroid. This is almost certainly a GeoJSON boundary precision issue.

### Category 2 — Medium-distance orphans (2 -- 5 km, 8 wells)

| Well ID | Name | Lat | Lon | Nearest Parcel | Dist (km) |
|---|---|---|---|---|---|
| 100013208319W509 | OBE 100 HZ HARMONV 1-32-83-19 | 56.2483 | -116.9652 | 7406030684 | 2.57 |
| 100023208319W509 | OBE 100 HZ HARMONV 2-32-83-19 | 56.2483 | -116.9656 | 7406030684 | 2.56 |
| 100033208319W509 | OBE 100 HZ HARMONV 3-32-83-19 | 56.2483 | -116.9660 | 7406030684 | 2.55 |
| 100043208319W509 | OBE 100 HZ HARMONV 4-32-83-19 | 56.2483 | -116.9664 | 7406030684 | 2.53 |
| 100083108319W509 | OBE 100 HZ HARMONV 8-31-83-19 | 56.2421 | -117.0106 | 7406030684 | 2.13 |
| 100093108319W509 | OBE 100 HZ HARMONV 9-31-83-19 | 56.2423 | -117.0105 | 7406030684 | 2.13 |
| 100103108319W509 | OBE 102 HZ 10-31-83-19 | 56.2423 | -117.0108 | 7406030684 | 2.15 |
| 100120407815W502 | WOODCOTE OIL HZ PEAVINE 12-4-78-15 | 55.7331 | -116.2462 | 0523110129 | 3.19 |

The first 7 wells are all OBE HARMONV wells in T083R19W5. They cluster tightly around the same area and their nearest parcel is agreement `7406030684` (sections 19, 30, 31, 32 of T083R19W5). The parcel geometry likely covers only those specific sections, while the wells sit in adjacent sections 31-32 of T083R19W5 that may be part of a separate agreement not included in the GeoJSON.

The Woodcote Peavine well at T078R15 is geographically south of the main Obsidian operating area and nearest only to a small quarter-section parcel.

### Category 3 — Far orphans (> 5 km, 8 wells)

These are the most significant outliers:

| Well ID | Name | Lat | Lon | Nearest Parcel | Dist (km) | Status |
|---|---|---|---|---|---|---|
| 100040908012W500 | WOODCOTE OIL HZ SEAL 4-9-80-12 | 55.9115 | -115.7991 | 7423120100 | 18.57 | Pumping |
| 100101508013W500 | WOODCOTE OIL HZ SEAL 10-15-80-13 | 55.9541 | -115.9424 | 7423120101 | 15.89 | Pumping |
| 100040908013W500 | WOODCOTE OIL HZ GIFT 4-9-80-13 | 55.8971 | -115.9818 | 0586060246 | 15.24 | Pumping |
| 100010608013W502 | WOODCOTE OIL HZ DAWSON 1-6-80-13 | 55.8971 | -115.9821 | 0586060246 | 15.23 | Pumping |
| 100081808013W500 | WOODCOTE OIL HZ SEAL 8-18-80-13 | 55.9352 | -115.9793 | 0586060246 | 11.74 | **Suspended** |
| 100121507815W500 | WOODCOTE OIL HZ PEAVINE 12-15-78-15 | 55.7627 | -116.2185 | 0523110128 | 6.39 | Pumping |
| 100160808218W509 | OBE 100 HZ HARMONV 16-8-82-18 | 56.0991 | -116.7459 | 7404041016 | 5.12 | Pumping |
| 100161008218W509 | OBE 100 HZ HARMONV 16-10-82-18 | 56.0991 | -116.7456 | 7404041016 | 5.12 | Pumping |

**Key observations:**

1. **WOODCOTE OIL wells (5 wells, 6.39 -- 18.57 km):** All branded "WOODCOTE OIL" rather than Penn West or OBE. Woodcote Oil was a predecessor/partner company. These wells are located in T078-T080 ranges (south of the main Peace River cluster). The mineral-rights GeoJSON has no parcels covering these townships, suggesting these wells operate under agreements that were not included in the GeoJSON export, or they were acquired/inherited assets with separate tenure documentation.

2. **OBE HARMONV pair (2 wells, 5.12 km):** Wells `100160808218W509` and `100161008218W509` in T082R18W5 section 8/10. The nearest parcel covers sections 27-28, 33-34 of T082R18 -- about 5 km north. These are likely covered by a separate agreement for the southern part of T082R18W5 that is missing from the GeoJSON.

---

## Full List of 59 Orphaned Wells

| # | Well ID | Name | Lat | Lon | Status | Nearest Agreement | Dist (km) |
|---|---|---|---|---|---|---|---|
| 1 | 100152408419W500 | PENN WEST PEACE RIVER 15-24-84-19 | 56.2887 | -116.8523 | Pumping | 7403110008 | 1.18 |
| 2 | 100162408419W500 | PENN WEST PEACE RIVER 16-24-84-19 | 56.2887 | -116.8519 | Operating | 7403110008 | 1.19 |
| 3 | 104152408419W500 | PENN WEST 103 PEACE RIV 15-24-84-19 | 56.2887 | -116.8522 | Pumping | 7403110008 | 1.18 |
| 4 | 100142408419W500 | PENN WEST PEACE RIVER 14-24-84-19 | 56.2887 | -116.8628 | Pumping | 7403110008 | 1.16 |
| 5 | 102142408419W500 | PENN WEST 102 PEACE RIV 6-24-84-19 | 56.2887 | -116.8629 | Pumping | 7403110008 | 1.16 |
| 6 | 103142408419W500 | PENN WEST 103 PEACE RIV 14-24-84-19 | 56.2887 | -116.8631 | Pumping | 7403110008 | 1.16 |
| 7 | 1W0132408419W500 | PENN WEST 103 PEACE RIV 13-24-84-19 | 56.2887 | -116.8726 | Pumping | 7403110007 | 1.34 |
| 8 | 100162608415W500 | PENN WEST SLAVE 16-26-84-15 | 56.3033 | -116.2455 | Pumping | 7402080032 | 1.61 |
| 9 | 100092608415W507 | PENN WEST 102 SLAVE 9-26-84-15 | 56.3033 | -116.2457 | Pumping | 7402080032 | 1.60 |
| 10 | 100132708415W508 | PENN WEST HZ SLAVE 13-27-84-15 | 56.3028 | -116.2806 | Pumping | 7402080033 | 1.19 |
| 11 | 104162408419W508 | PENN WEST 104 HZ PEACE R 16-24-84-19 | 56.2890 | -116.8514 | Pumping | 7403110008 | 1.17 |
| 12 | 104052508419W509 | PENN WEST 103 HZ PEACE R 5-25-84-19 | 56.3126 | -116.8449 | Pumping | 7403110009 | 0.82 |
| 13 | 106132508419W508 | PENN WEST 105 HZ PEACE R 13-25-84-19 | 56.3127 | -116.8449 | Pumping | 7403110009 | 0.82 |
| 14 | 105132408419W509 | PENN WEST 104 HZ PEACE R 13-24-84-19 | 56.2887 | -116.8713 | Pumping | 7403110007 | 1.38 |
| 15 | 104162308419W508 | PENN WEST 104 PEACE RIVE 16-23-84-19 | 56.2887 | -116.8715 | Pumping | 7403110007 | 1.38 |
| 16 | 105142408419W509 | PENN WEST 105 HZ PEACE R 14-24-84-19 | 56.2887 | -116.8621 | Pumping | 7403110008 | 1.15 |
| 17 | 106042508419W508 | PENN WEST 106 PEACE RIVER 4-25-84-19 | 56.3071 | -116.8449 | Pumping | 7403110009 | 1.08 |
| 18 | 104132308419W509 | PENN WEST HZ PEACE RVR 13-23-84-19 | 56.2891 | -116.8946 | Pumping | 7403110007 | 1.24 |
| 19 | 104152308419W509 | PENN WEST 102 HZ PEACE R 15-23-84-19 | 56.2883 | -116.8837 | Pumping | 7403110007 | 1.16 |
| 20 | 102032308419W509 | PENN WEST HZ PEACE RVR 3-23-84-19 | 56.2883 | -116.8838 | Pumping | 7403110007 | 1.16 |
| 21 | 105132508419W509 | PENN WEST HZ PEACE RVR 13-25-84-19 | 56.3138 | -116.8449 | Pumping | 7403110009 | 0.82 |
| 22 | 100162208419W509 | PENN WEST 102 HZ PEACE R 16-22-84-19 | 56.2887 | -116.9077 | Pumping | 7403110006 | 0.82 |
| 23 | 102163008318W509 | PENN WEST 102 HZ 16-30-83-18 | 56.2178 | -116.8210 | Pumping | 7401060028 | 1.09 |
| 24 | 100043008318W509 | PENN WEST HZ PEACE R 4-30-83-18 | 56.2178 | -116.8211 | Pumping | 7401060028 | 1.08 |
| 25 | 100142208419W509 | PENN WEST HZ PEACE R 14-22-84-19 | 56.2876 | -116.9082 | Pumping | 7403110006 | 0.93 |
| 26 | 100162908318W509 | PENN WEST PEACE RIVER 16-29-83-18 | 56.2292 | -116.7673 | Pumping | 7401060030 | 1.49 |
| 27 | 103133408318W509 | PENN WEST PEACE RIVER 13-34-83-18 | 56.2292 | -116.7669 | Pumping | 7401060030 | 1.51 |
| 28 | 100092908318W509 | PENN WEST PEACE RIVER 9-29-83-18 | 56.2292 | -116.7665 | Pumping | 7401060030 | 1.52 |
| 29 | 100163408318W509 | OBE HZ PEACE RIVER 16-34-83-18 | 56.2295 | -116.7595 | Pumping | 7401060030 | 1.84 |
| 30 | 103143408318W509 | OBE 102 HZ PEACE R 14-34-83-18 | 56.2295 | -116.7603 | Pumping | 7401060030 | 1.80 |
| 31 | 102143408318W509 | PENN WEST 102 HZ PEACE R 14-34-83-18 | 56.2295 | -116.7599 | Pumping | 7401060030 | 1.82 |
| 32 | 100013208319W509 | OBE 100 HZ HARMONV 1-32-83-19 | 56.2483 | -116.9652 | Pumping | 7406030684 | 2.57 |
| 33 | 100023208319W509 | OBE 100 HZ HARMONV 2-32-83-19 | 56.2483 | -116.9656 | Pumping | 7406030684 | 2.56 |
| 34 | 100033208319W509 | OBE 100 HZ HARMONV 3-32-83-19 | 56.2483 | -116.9660 | Pumping | 7406030684 | 2.55 |
| 35 | 100043208319W509 | OBE 100 HZ HARMONV 4-32-83-19 | 56.2483 | -116.9664 | Pumping | 7406030684 | 2.53 |
| 36 | 100010608013W502 | WOODCOTE OIL HZ DAWSON 1-6-80-13 | 55.8971 | -115.9821 | Pumping | 0586060246 | 15.23 |
| 37 | 103162908115W506 | OBE 103 HZ DAWSON 16-29-81-15 | 56.0555 | -116.3275 | Pumping | 0525070134 | 1.00 |
| 38 | 104092908115W506 | OBE 104 HZ DAWSON 9-29-81-15 | 56.0552 | -116.3274 | Pumping | 0525070134 | 0.97 |
| 39 | 100040908013W500 | WOODCOTE OIL HZ GIFT 4-9-80-13 | 55.8971 | -115.9818 | Pumping | 0586060246 | 15.24 |
| 40 | 100120407815W502 | WOODCOTE OIL HZ PEAVINE 12-4-78-15 | 55.7331 | -116.2462 | Pumping | 0523110129 | 3.19 |
| 41 | 100121507815W500 | WOODCOTE OIL HZ PEAVINE 12-15-78-15 | 55.7627 | -116.2185 | Pumping | 0523110128 | 6.39 |
| 42 | 102022008316W509 | OBE 102 HZ 2-20-83-16 | 56.2174 | -116.4849 | Pumping | 7402080018 | 0.30 |
| 43 | 100101508013W500 | WOODCOTE OIL HZ SEAL 10-15-80-13 | 55.9541 | -115.9424 | Pumping | 7423120101 | 15.89 |
| 44 | 100081808013W500 | WOODCOTE OIL HZ SEAL 8-18-80-13 | 55.9352 | -115.9793 | Suspended | 0586060246 | 11.74 |
| 45 | 100040908012W500 | WOODCOTE OIL HZ SEAL 4-9-80-12 | 55.9115 | -115.7991 | Pumping | 7423120100 | 18.57 |
| 46 | 102132208419W509 | OBE 102 HZ 13-22-84-19 | 56.2868 | -116.9230 | Pumping | 7403110006 | 1.27 |
| 47 | 103132208419W509 | OBE 103 HZ 13-22-84-19 | 56.2870 | -116.9230 | Pumping | 7403110006 | 1.25 |
| 48 | 102162108419W509 | OBE 102 HZ 16-21-84-19 | 56.2868 | -116.9234 | Pumping | 7403110006 | 1.28 |
| 49 | 100161208317W509 | OBE 100 HZ 16-12-83-17 | 56.1717 | -116.5380 | Pumping | 7402080023 | 1.70 |
| 50 | 100151208317W509 | OBE 100 HZ 15-12-83-17 | 56.1718 | -116.5382 | Pumping | 7402080023 | 1.69 |
| 51 | 100160608316W509 | OBE 100 HZ 16-6-83-16 | 56.1716 | -116.5381 | Pumping | 7402080023 | 1.72 |
| 52 | 100090608316W509 | OBE 100 HZ 9-6-83-16 | 56.1717 | -116.5384 | Pumping | 7402080023 | 1.70 |
| 53 | 100083108319W509 | OBE 100 HZ HARMONV 8-31-83-19 | 56.2421 | -117.0106 | Pumping | 7406030684 | 2.13 |
| 54 | 100093108319W509 | OBE 100 HZ HARMONV 9-31-83-19 | 56.2423 | -117.0105 | Pumping | 7406030684 | 2.13 |
| 55 | 100103108319W509 | OBE 102 HZ 10-31-83-19 | 56.2423 | -117.0108 | Pumping | 7406030684 | 2.15 |
| 56 | 102041108114W509 | OBE 102 HZ DAWSON 4-11-81-14 | 56.0161 | -116.0874 | Pumping | 0586060246 | 0.53 |
| 57 | 100011608114W509 | OBE 100 HZ DAWSON 1-16-81-14 | 56.0159 | -116.0875 | Pumping | 0586060246 | 0.53 |
| 58 | 100160808218W509 | OBE 100 HZ HARMONV 16-8-82-18 | 56.0991 | -116.7459 | Pumping | 7404041016 | 5.12 |
| 59 | 100161008218W509 | OBE 100 HZ HARMONV 16-10-82-18 | 56.0991 | -116.7456 | Pumping | 7404041016 | 5.12 |

---

## Recommendations

### 1. Obtain missing parcel geometries (resolves ~43 wells)

The majority (43 of 59) of orphaned wells are less than 2 km from a known parcel centroid. These are almost certainly covered by mineral-rights agreements that are simply missing from the current GeoJSON file. The specific agreements to request from PetroNinja or the Alberta government are:

- **T084R19W5 sections 22-25** — 23 wells near agreements 7403110006 through 7403110009
- **T083R18W5 sections 29-34** — 8 wells near agreements 7401060028 and 7401060030
- **T083R17W5 sections 6, 12-13** — 4 wells near agreement 7402080023
- **T083R16W5 section 20** — 1 well near agreement 7402080018
- **T084R15W5 sections 26-28** — 3 wells near agreements 7402080032/33
- **T081R15W5 section 29-30** — 2 wells near agreement 0525070134
- **T081R14W5 section 11, 15-16** — 2 wells near agreement 0586060246

### 2. Investigate Woodcote Oil wells (7 wells)

These 7 wells branded "WOODCOTE OIL" are located in T078-T080, significantly south of the main Peace River operating area. They are 3-19 km from any known parcel. Options:

- **Confirm ownership:** Verify that these wells are currently operated by Obsidian Energy and not divested assets.
- **If still OBE-operated:** Obtain the mineral-rights data for T078R15, T080R12, T080R13 from PetroNinja.
- **Note:** One Woodcote well (`100081808013W500`, SEAL 8-18-80-13) is the only **Suspended** orphan. If the well is permanently suspended, its missing parcel may be a lower priority.

### 3. Investigate OBE HARMONV pair at T082R18W5S08/10 (2 wells)

Wells `100160808218W509` and `100161008218W509` are 5.12 km from the nearest parcel. They are in sections 8 and 10 of T082R18W5, while the nearest parcels cover sections 27-28, 33-34. This is a full township-width gap. Request the mineral-rights agreement for southern T082R18W5.

### 4. Investigate T083R19W5 HARMONV cluster (7 wells, 2.1 -- 2.6 km)

Seven OBE HARMONV wells in sections 31-32 of T083R19W5 are 2-2.6 km from agreement 7406030684 (which covers sections 19, 30-32). The parcel geometry may be incomplete (perhaps only covering the northern portion of these sections). Request updated geometry for this agreement.

### 5. No wells are Abandoned

All 59 orphaned wells are either Pumping (57), Operating (1), or Suspended (1). None are Abandoned. This means every orphan is an active or semi-active well that should have a valid mineral-rights backing. This reinforces the conclusion that the GeoJSON is incomplete rather than the wells being illegitimate.

---

## Lessons Learned

1. **GeoJSON coverage is incomplete.** The 852 parcels cover 72% of wells. The remaining 28% are not "wrong" — they simply fall on land parcels not present in the current GeoJSON export.

2. **Centroid distance is approximate.** The "nearest parcel" metric uses centroid-to-point distance, not edge-to-edge distance. A well 1.18 km from a parcel centroid may only be 200 m from the parcel boundary. True edge distance would require computing point-to-polygon-edge distance, which was not implemented in this pass.

3. **Horizontal wells straddle sections.** Many wells have "HZ" in their name (horizontal). Their surface location may be in a different legal subdivision than where their wellbore bottom-hole is. The mineral rights may be registered to the bottom-hole section, not the surface section.

4. **Woodcote wells are a distinct population.** They are geographically separate, carry a different operator name, and should be treated as a separate validation group. If Obsidian inherited these through acquisition, their mineral-rights data may reside in a different database or system.

5. **The ray-casting algorithm works well for Alberta DLS parcels.** These are typically rectangular quarter-section polygons. No edge cases with holes or complex geometries were observed.

---

## Files Created

| File | Purpose |
|---|---|
| `scripts/validate-wells-spatial.js` | ESM validation script (zero dependencies) |
| `scripts/spatial-validation-results.json` | Machine-readable JSON output (inside + outside wells) |
| `agents/session-6/spatial-report.md` | This report |
