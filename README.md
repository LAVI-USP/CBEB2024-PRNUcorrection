# Photo Response Non-Uniformity (PRNU) Correction for Digital Mammography Systems

This repository contains the MATLAB implementation of the structural noise correction framework proposed in the paper:

> **Photo Response Non-Uniformity Correction for Digital Mammography Systems**  
> Renann F. Brandão, Arthur C. Costa, Lucas E. Soares, Alessandro F. Frangi, Marcelo A. Vieira, and Wellington P. Santos  
> Brazilian Congress on Biomedical Engineering (CBEB 2024)

The proposed method estimates the Photo Response Non-Uniformity (PRNU) map from flat-field mammography images and applies a correction step prior to denoising. The objective is to reduce the influence of structural noise, improving the balance between noise suppression and signal preservation in indirect-conversion digital mammography systems.

---

## Repository contents

The repository includes MATLAB scripts for:

- Estimation of the PRNU map from multiple flat-field images;
- Structural noise correction;
- Estimation of the quadratic noise model parameters;
- Quantitative evaluation of the denoising performance;
- Reproduction of the figures and results presented in the publication.

---

## Requirements

The code was developed and tested using:

- MATLAB R2025b

Required toolboxes:

- Image Processing Toolbox
- Statistics and Machine Learning Toolbox

---

## Method overview

The implemented framework follows the workflow below:

1. Acquire multiple flat-field mammography images;
2. Estimate the detector PRNU map;
3. Apply the PRNU correction to the mammography image;
4. Estimate the noise model parameters;
5. Perform image denoising;
6. Evaluate restoration quality using quantitative metrics.

---

## Citation

If you use this code in your research, please cite the following publication:

> Brandão, R. F., Costa, A. C., Soares, L. E., Frangi, A. F., Vieira, M. A., & Santos, W. P.  
> **Photo Response Non-Uniformity Correction for Digital Mammography Systems.**  
> Brazilian Congress on Biomedical Engineering (CBEB), 2024.

BibTeX:

```bibtex
@inproceedings{brandao2024photo,
  title={Photo Response Non-Uniformity Correction for Digital Mammography Systems},
  author={Brand{\~a}o, Renann F and Borges, Lucas R and Caron, Renato F and Maidment, Andrew DA and Vieira, Marcelo AC},
  booktitle={Brazilian Congress on Biomedical Engineering},
  pages={253--263},
  year={2024},
  organization={Springer}
}
```

---

## License

This repository is intended for academic and research purposes.

---

## Contact

**Renann F. Brandão**

Ph.D. Candidate — University of São Paulo (USP)

LAVI (Laboratory for Advanced Vision and Imaging)

📧 renann.brandao@usp.br

🌐 https://github.com/LAVI-USP
