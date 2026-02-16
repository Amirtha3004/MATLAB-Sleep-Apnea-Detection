# MATLAB Modeling of Respiratory Rate Variability for Sleep Apnea Detection
To simulate respiratory signals and detect sleep apnea using respiratory rate variability analysis in MATLAB.
## Methodology
- Simulated respiratory signal (0.25 Hz sinusoidal)
- Added random noise
- Introduced apnea event (30s–45s)
- Applied Butterworth bandpass filter (0.1–0.5 Hz)
- Detected breathing peaks using `findpeaks()`
- Calculated respiratory rate
- Apnea detected if breathing interval ≥ 10 seconds
## Cases
### Normal Case
- Continuous breathing
- Maximum interval < 10 seconds
- Result: **Normal Breathing Pattern**
### Abnormal Case
- Breathing pause introduced
- Maximum interval ≥ 10 seconds
- Result: **Sleep Apnea Detected**
## Output Files
- `sleep_apnea_detection.m`
- `Normal_Case.png`
- `Abnormal_Case.png`
- `Sleep_Apnea_Results.png`
## Tools Used
MATLAB | Signal Processing Toolbox

