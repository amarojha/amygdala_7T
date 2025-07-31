#!/usr/bin/env bash

# note: model doesn't include any interactions anymore

set -euo pipefail

3dLMEr -prefix "bn_conn_3dlmer_simpler" \
    -mask '/opt/ni_tools/standard/mni_icbm152_nlin_asym_09c/mni_icbm152_gm_tal_nlin_asym_09c_2mm.nii<.2..1>' \
    -model "scan_age+sex+hemi+visit+(1|Subj)" \
    -qVars "scan_age" \
    -qVarCenters "20" \
    -SS_type 3 \
    -gltCode "Age_slope" 'scan_age :' \
    -gltCode "Male_vs_Female" 'sex : 1*M -1*F' \
    -gltCode "Left_vs_Right" 'hemi : 1*lh -1*rh' \
    -gltCode "Age10" 'scan_age : -10' \
    -gltCode "Age11" 'scan_age : -9' \
    -gltCode "Age12" 'scan_age : -8' \
    -gltCode "Age13" 'scan_age : -7' \
    -gltCode "Age14" 'scan_age : -6' \
    -gltCode "Age15" 'scan_age : -5' \
    -gltCode "Age16" 'scan_age : -4' \
    -gltCode "Age17" 'scan_age : -3' \
    -gltCode "Age18" 'scan_age : -2' \
    -gltCode "Age19" 'scan_age : -1' \
    -gltCode "Age20" 'scan_age : 0' \
    -gltCode "Age21" 'scan_age : 1' \
    -gltCode "Age22" 'scan_age : 2' \
    -gltCode "Age23" 'scan_age : 3' \
    -gltCode "Age24" 'scan_age : 4' \
    -gltCode "Age25" 'scan_age : 5' \
    -gltCode "Age26" 'scan_age : 6' \
    -gltCode "Age27" 'scan_age : 7' \
    -gltCode "Age28" 'scan_age : 8' \
    -gltCode "Age29" 'scan_age : 9' \
    -gltCode "Age30" 'scan_age : 10' \
    -gltCode "Age31" 'scan_age : 11' \
    -gltCode "Age32" 'scan_age : 12' \
    -dataTable @datatable_all_ids_bn.txt
