# Introduction

This repository contains the part of the code I am using for the development of my end of degree project, which aims to apply O-information metrics to understand higher-order neural interdependencies in rodents with epilepsy over an 8-month period. 

To this end, a database acquired by Neuralynx (https://neuralynx.com/) is being pre-processed. It contains different recordings, specifically, 16 recordings of sniffing rats and 4 sleeping rats, for the moment all of them are pre-epileptic. In the future, if we receive data from after epilepsy, we will be able to make an analysis between these two different situations. Each of the recordings has theoretically collected information via 15 channels located in different parts of the rats' brains.

Each channel represents the activity of a temporal lobe (TL) brain structures recorded with 50-micron diameter-tungsten microelectrodes, during natural behaviours and cognitive processes, in health (before TLE model induction) and disease (TLE model: post-Status epilepticus). All these recordings have been taken with a sampling rate of 32556 Hz, and every channel has many epochs, each one made of 512 samples, as you will figure out seen the description of the code. 

Currently I am working in the preprocessing part and working to get conclusions using HOI toolbox to retrieve high-order information multiplets from data using the **O-information** (shorthand for “information about Organizational structure, https://github.com/danielemarinazzo/HOI) [1-2]. This toolbox uses the gaussian copula estimator (https://github.com/robince/gcmi).

# Work done so far

Although there are a large number of recordings that have been obtained correctly, the reality is that there are also a large number that need to be deleted, pre-processed, or modified for various reasons. In addition, the company recommended down sampling to less than 1000 Hz because the sampling rate was too high (32556 Hz as mentioned). Therefore, two types of pre-processing are being carried out: for the validation of the channel files and epochs, and on the other hand to improve the quality of the data obtained for later analysis.Knowing this, these are the functions and features of the code:

#### Loading data (loaddata.m and folderselection.m)
The code is able to load all the folders of the database and read the data of each of the channels of the recordings. This function also detects the channels without valid data. 

#### Concatenation and calculation of necessary epochs (create_epoch_tables.m)
The code calculates how many epochs we need to downsample up to 4 seconds, which was the recommended time in the beggining. It concatenates all of them in a single column. 

#### Downsampling (downsampling.m)
The frequency is downsampled after the concatenation of all the epochs, from 32556Hz to 900Hz (which was the recommended value). 

#### Plotting (plotting.m)
In case you want to plot all the channels and have an overview of the work done you can paste this part of the code in the main code (main.m)

#### Implementation of all the code fuctions (main.m)
This file implements all the functions, and has some internal functions which helps us to preprocess and omit some invalid channels. The main part of the validation of the files is developed in this file.



Knowing this, the explanations of each function or file can also be found in each file of the repository.

# Currently developing

Currently working to complete information that is not valid in the different channels using different strategies. This is being done in the mean_values function, to be finished by mid-February.

In parallel, the relationship between different channels and their interdependencies is being explored. This has not yet been implemented in the repository code.

# To do list in the future

- Continue to analyze the connections between channels and get conclusions
- Connection between different epoch folders and consequently between channels and get conclusions
- See how the effect of the multiplets size affect to redundancy and synergy and get conclusions


# References 

[1]  Rosas, F. E., Mediano, P. A., Gastpar, M., & Jensen, H. J. (2019). Quantifying high-order interdependencies via multivariate extensions of the mutual information. Physical Review E, 100(3), 032305. https://journals.aps.org/pre/abstract/10.1103/PhysRevE.100.032305

[2]  Stramaglia, S., Scagliarini, T., Daniels, B. C., & Marinazzo, D. (2021). Quantifying dynamical high-order interdependencies from the o-information: an application to neural spiking dynamics. Frontiers in Physiology, 11, 1784. https://www.frontiersin.org/articles/10.3389/fphys.2020.595736/full
