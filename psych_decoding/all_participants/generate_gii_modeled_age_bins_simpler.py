import os
import nibabel as nib
from neuromaps import transforms
import tempfile
import re

# Define input and output paths
inputpath = '/Users/amarojha/Desktop/science/papers/revise/frontoamygdala/revision_analyses/cog_domain_decoding/my_attempt/revised_models/3dLMEr/simpler/outputs'
outputpath = inputpath  # can be changed if you want output elsewhere

# Compile regex pattern to extract label and bin from filename
pattern = re.compile(r'(?P<label>\w+)_conn_Age(?P<bin>\d+)_beta\.nii\.gz')

# Loop through all .nii.gz files in inputpath
for fname in os.listdir(inputpath):
    if not fname.endswith('.nii.gz'):
        continue

    match = pattern.match(fname)
    if not match:
        print(f"Skipping unrecognized file: {fname}")
        continue

    label = match.group('label')
    bin_num = match.group('bin')
    input_path = os.path.join(inputpath, fname)

    try:
        # Load the MNI152 volume
        vol = nib.load(input_path)

        # Save to a temporary file for transformation
        with tempfile.NamedTemporaryFile(suffix='.nii.gz') as temp:
            nib.save(vol, temp.name)
            vol_fslr = transforms.mni152_to_fslr(temp.name, '32k')

        # Unpack left and right hemisphere data
        vol_fslr_lh, vol_fslr_rh = vol_fslr
        vol_fslr_lh.meta['AnatomicalStructurePrimary'] = 'CortexLeft'
        vol_fslr_rh.meta['AnatomicalStructurePrimary'] = 'CortexRight'

        # Define output filenames
        fname_lh = f"source-Liu2019_desc-{label}{bin_num}_map_space-fslr_den-32k_hemi-L.func.gii"
        fname_rh = f"source-Liu2019_desc-{label}{bin_num}_map_space-fslr_den-32k_hemi-R.func.gii"

        # Save output files
        nib.save(vol_fslr_lh, os.path.join(outputpath, fname_lh))
        nib.save(vol_fslr_rh, os.path.join(outputpath, fname_rh))

        print(f"✅ Saved: {fname_lh} & {fname_rh}")

    except FileNotFoundError:
        print(f"❌ File not found: {input_path}")
    except Exception as e:
        print(f"⚠️ Error processing {fname}: {e}")
        import traceback
        traceback.print_exc()

