# repeat for all amygdala nuclei 

import nibabel as nib
import pandas as pd
from neuromaps import transforms

abn = nib.load("/Users/amarojha/Desktop/science/papers/revise/frontoamygdala/amyg7T/cognitive_mapping/full_adult_sample/3dmean_amyg_maps/not_thresholded_good_align/abn_adult_mean_aligned.nii.gz") #load in MNI space amygdala nuclei connectivity map
abn_fslr = transforms.mni152_to_fslr("/Users/amarojha/Desktop/science/papers/revise/frontoamygdala/amyg7T/cognitive_mapping/full_adult_sample/3dmean_amyg_maps/not_thresholded_good_align/abn_adult_mean_aligned.nii.gz", '32k') #project the map to the fslr surface
abn_fslr_lh, abn_fslr_rh = abn_fslr #access left and right hemisphere giftis
abn_fslr_lh.meta['AnatomicalStructurePrimary'] = 'CortexLeft' #add anatomical structure lh
abn_fslr_rh.meta['AnatomicalStructurePrimary'] = 'CortexRight' #add anatomical structure rh
outputpath = '/Users/amarojha/Desktop/science/papers/revise/frontoamygdala/amyg7T/cognitive_mapping/full_adult_sample/3dmean_amyg_maps/not_thresholded_good_align' #outputs go here
fname_lh = 'source-Liu2019_desc-abn_map_space-fslr_den-32k_hemi-L.func.gii' #output filename lh
fname_rh = 'source-Liu2019_desc-abn_map_space-fslr_den-32k_hemi-R.func.gii' #output filename rh
nib.save(abn_fslr_lh, outputpath + "/" + fname_lh) #save lh abn gifti
nib.save(abn_fslr_rh, outputpath + "/" + fname_rh) #save rh abn gifti