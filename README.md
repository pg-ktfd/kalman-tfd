# kalman-tfd
INSTANTANEOUS Power Spectrum – a powerful tool for ML
Short-term Fourier Transform and its magnitude-squared, “Spectrogram”, are well known tools in signal processing. This article re-introduces an important variation - “Instantaneous” Fourier Transform and Kalman Time Frequency Distribution (“KTFD”); KTFD is an estimate of the power spectrum at an instant of time! This may raise some conceptual concerns which I will address below. In any case, some recent work I was doing in digital twins showed me (again) the amazing power of KTFD and how it could be a very valuable tool in Machine Learning.

I see two major uses for KTFD in ML.
1. Feature Engineering: Instead of working with the time series itself or the traditional power spectrum (as in figure3), if you preprocess your IoT time series data channel with KTFD, the kind of features that can be detected and then used in ML will be highly information bearing which enhances the chance of faster learning, higher accuracy and more robustness over time.
2. Deep Learning: KTFD output can be projected down to the time-frequency plane to get a “matrix’ 2-D view. Also, one can use a 2-D image of the 3-D output from a fixed point of view as input to deep learning (DL) systems. DL will then be able to learn more subtle features from the image than the eye can see (or from pre-processing).

To facilitate ML applications by anyone, I have placed KTFD Matlab function on GitHub including the original research article for those who want to go deeper into the theory.
1. KTFD.m
2. PG Madhavan & WJ Williams, Kalman Filtering and Time Frequency Distribution of Random Signals, SPIE Proceedings, SPIE Vol. 2846, pp. 164-173, 1996.


Dr. PG Madhavan
https://www.linkedin.com/in/pgmad/

#Kalman #powerspectrum #ktfd #ML #timeseries #signalprocessing #iot
