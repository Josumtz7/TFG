# Introduction

This repository contains the part of the code I have used for the development of my end of degree project, which aimed to apply O-information metrics to understand higher-order neural interdependencies in rodents with epilepsy over an 8-month period. A better explanation has been done all along the document of the project.

To this end, two databases acquired by Neuralynx (https://neuralynx.com/) has being pre-processed. On the one hand there is a database thatcontains different recordings, specifically, 16 recordings of sniffing rats and 4 sleeping rats in control situation. The other database is much larger and more comprehensive and contains recordings of the same behaviours before injection and after 4, 7 and 10 days. Each of the recordings has theoretically collected information via 15 channels located in different parts of the rats' brains.

Each channel represents the activity of a temporal lobe (TL) brain structures recorded with 50-micron diameter-tungsten microelectrodes, during natural behaviours and cognitive processes, in health (before TLE model induction) and disease (TLE model: post-Status epilepticus). All these recordings have been taken with a sampling rate of 32556 Hz, and every channel has many epochs, each one made of 512 samples, as you will figure out seen the description of the code. 

I have worked in the preprocessing part and used HOI toolbox to retrieve high-order information multiplets from data using the **O-information** (shorthand for “information about Organizational structure, https://github.com/danielemarinazzo/HOI) [1-2]. This toolbox uses the gaussian copula estimator (https://github.com/robince/gcmi).

# Preparing to use the code and how to use it:
In this section it will eplained the preparation for the use of the code.
## General information
1. Download the [MATLAB Support for MinGW-w64 C/C++ Compiler](https://es.mathworks.com/matlabcentral/fileexchange/52848-matlab-support-for-mingw-w64-c-c-compiler) to speed up the complication process, in case you do not have it downloaded.
2. Download [MATLAB Import/Export MEX Files](https://neuralynx.com/software/category/matlab-netcom-utilities) to import and export Neuralynx files to and from MATLAB variables with MATLAB MEX files.
## First database
1. First download [this folder](https://www.dropbox.com/sh/0kpgp9la6by8m9p/AABM2vldJEclnunSIl8IzvKHa?dl=0) with all the epoch folders of Neuralynx **except the folder called "epoch sn13"**.
2. Delete "CSC11_169806023_223259735.ncs" from the epoch sn1 folder
3. Add all the epoch folder to the path (select all of them, right click and add to path)!! Important, if not it will not work.
4. I have developed two main codes to have a global view of the dataset or just of one epoch folder:<br/><br/>
4.1. In case you want to work with only *one epoch folder*:<br/>
           - Use onlyoneepoch.m function<br/>
           - Go inside the epoch folder you want<br/>
           - Run the code<br/><br/>
4.2. In case you want to have a *general view of the dataset*<br/>
           - Use main.m function<br/>
           - Go to the general folder<br/>
           - Run the code<br/>
4.3. In case you want to analyse only *one channel recording*<br/>
           - Use onlyfile.m function
           - Go inside the epoch folder you want
           - Introduce the name of the channel<br/>
           - Run the code<br/>
## Second database
To gain access to this repository it is necessary to request and acquire access from the Donders Repository to the database called TLE Dataset. The operation is the same as in the 1st database and the validation process and the epoch folders and channels to be deleted are detailed in the final EDP document.

# Validation and functions.

Although there are a large number of recordings that have been obtained correctly, the reality is that there are also a large number that need to be deleted, pre-processed, or modified for various reasons. In addition, the company recommended down sampling to less than 1000 Hz because the sampling rate was too high (32556 Hz as mentioned). Therefore, two types of pre-processing are being carried out: for the validation of the channel files and epochs, and on the other hand to improve the quality of the data obtained for later analysis. Knowing this, these are the functions and features of the code:

#### Loading data (loaddata.m and folderselection.m)
The code is able to load all the folders of the database and read the data of each of the channels of the recordings. This function also detects the channels without valid data. 

#### Concatenation and calculation of necessary epochs (create_epoch_tables.m)
The code calculates how many epochs we need to downsample up to 4 seconds, which was the recommended time in the beggining. It concatenates all of them in a single column. 

#### Downsampling (downsampling.m)
The frequency is downsampled after the concatenation of all the epochs, from 32556Hz to 200Hz. 

#### Plotting (plotting.m)
In case you want to plot all the channels and have an overview of the work done you can paste this part of the code in the main code (main.m)

#### Implementation of all the code fuctions (main.m)
This file implements all the functions, and has some internal functions which helps us to preprocess and omit some invalid channels. The main part of the validation of the files is developed in this file.

#### Work with only one epoch (onlyoneepoch.m)
In case we want to analyse only one epoch,  which is sometimes convenient to do test in some analysis we can use this file. It is important to be inside the epoch folder (p.e. epoch sn7), if not the code doesn't detect the files and causes errors. 

#### Work with only one file (onlyfile.m)
This script could be a file to start and understand the basics of the code. It takes the information of only one channel recording. Change the name of the file you want.

#### Changing the values of the real channels (real_channel.m)
This file will help us to detect the index values of the real channels. If not with the missing data and without making use of the aproximation and mean values (in short, without completing the missing data) we couldn't see the real interdependencies between neural channels.

#### First aggroupation doing the average between different regions (first_aggroupation.m)
 This function does the first aggroupation to lose the less possible interactions. This is why average between channels of the same region of the brain has been done. 

#### Reducing the aggroupation to 4 regions of the brain (groups_classification.m)
This function is used to classify definetly the four diferent groups according to the needs detected. After having done the average between the first classification 
groups in the first_aggroupation.m In this last version 4 different regions of the rats brain have been separated according to the location.

#### Final aggoupation depending of the parts of the brain (pca_regions.m)
This function is used to reduce each aggroupation to the first principal component of each group by Principal Component Analysis. The final matrix is composed by the data of final 4 regions selected. It can be changed depending on the aggrupation you want to do. 


It should be noted that for each time-based database a separate document of the following functions has been created:

     - main.m
     - folderselection.m
     - onlyoneepoch.m

The functions have been modified to comply with the grammatical patterns that each database had. Knowing this, the explanations of each function or file can also be found in each file of the repository.

# References 

[1]  Rosas, F. E., Mediano, P. A., Gastpar, M., & Jensen, H. J. (2019). Quantifying high-order interdependencies via multivariate extensions of the mutual information. Physical Review E, 100(3), 032305. https://journals.aps.org/pre/abstract/10.1103/PhysRevE.100.032305

[2]  Stramaglia, S., Scagliarini, T., Daniels, B. C., & Marinazzo, D. (2021). Quantifying dynamical high-order interdependencies from the o-information: an application to neural spiking dynamics. Frontiers in Physiology, 11, 1784. https://www.frontiersin.org/articles/10.3389/fphys.2020.595736/full
