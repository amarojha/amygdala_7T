#!/usr/bin/env sh

forceWrite=0

while read roiname maskfile maskidx; do
        for f in /Volumes/Hera/Amar/amyg_7T/data/1*_2*/Wbgrndkm_func.nii.gz; do

                rsdir=$(dirname $f)
                subj=$(echo $rsdir | cut -d "/" -f7)
                fname=$(basename $f)

                mkdir -p $rsdir/seeds_amyg

		# check if output file exists
                outfile="${rsdir}/seeds_amyg/$subj-$roiname.1d"
                [ -r $outfile -a $forceWrite -eq 0 ] && echo "  Outfile exists for $subj-$roiname, SKIPPING" && continue

		# check if mask exists
		maskdir=${rsdir}/ 
		[ ! -r ${maskdir}/$maskfile ] && echo "  Could not find $maskfile for $subj, SKIPPING" && continue

                echo 3dmaskave -quiet -mask "${maskdir}/${maskfile}<$maskidx>" $f
                3dmaskave -quiet -mask "${maskdir}/${maskfile}<$maskidx>" $f > $outfile
#                3dmaskave -quiet -mask "${maskdir}/${maskfile}<$maskidx>" $f

        done
done <<EOF
lh.ln pfc_amyg_whole2.nii.gz 700
lh.bn pfc_amyg_whole2.nii.gz 710
lh.cen pfc_amyg_whole2.nii.gz 720
lh.mn pfc_amyg_whole2.nii.gz 730
lh.con pfc_amyg_whole2.nii.gz 740
lh.abn pfc_amyg_whole2.nii.gz 750
lh.cat pfc_amyg_whole2.nii.gz 760
lh.aaa pfc_amyg_whole2.nii.gz 770
lh.pl pfc_amyg_whole2.nii.gz 780

rh.ln pfc_amyg_whole2.nii.gz 800
rh.bn pfc_amyg_whole2.nii.gz 810
rh.cen pfc_amyg_whole2.nii.gz 820
rh.mn pfc_amyg_whole2.nii.gz 830
rh.con pfc_amyg_whole2.nii.gz 840
rh.abn pfc_amyg_whole2.nii.gz 850
rh.cat pfc_amyg_whole2.nii.gz 860
rh.aaa pfc_amyg_whole2.nii.gz 870
rh.pl pfc_amyg_whole2.nii.gz 880
EOF


