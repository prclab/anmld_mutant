# ANMLD and Mutant Analysis

ANMLDcode.zip file contains scripts, functions, parameter and input files necessary to run ANM-LD simulations for the case studied in the manuscript submitted. 

Authors:
Burcu Aykac Fas, Burcin Acar

The contents of the ANMLDcode.zip file are;

Scripts and called functions:
- submitANMLD.sh: The batch script file that is submitted to start the ANM-LD run.
- matlab_newmethod.m: The main MATLAB script file that is called by the batch script file.
- anm_gnm_target_overlap.m: The function for ANM mode overlap calculations.
- pdb2mat.m, mat2pdb.m: The functions to convert between PDB files and MATLAB friendly data structures.

Parameter files:
- btucd_min_imp.in: AMBER parameter file used for the energy minimization steps.
- BtuCD_LD_simtgt_f0_matlab.in: AMBER parameter file used for the LD molecular simulation steps.

Input files:
- step.txt: The input file with the initial cycle number and the names of the initial and target PDB files. This file is updated at each cycle with the names of the created pdb files throughout the performed run .
- 1L7V3_min.pdb: All-atom coordinates of the energy minimized initial structure.
- 1L7V3C_min.pdb: Alpha carbon coordinates of the energy minimized initial structure.
- 4FI3C_min_aligned.pdb: Alpha carbon coordinates of the energy minimized target structure.
- 1l7v3_imp_min.rst: All-atom coordinates of the energy minimized initial structure in restart format. 

Major output files:
- {1l7v_imp_simtgt_cycle1.pdb, 1l7v_imp_simtgt_cycle2.pdb, 1l7v_imp_simtgt_cycle3.pdb,...,1l7v_imp_simtgt_cycleN.pdb}: Conformations of the generated trajectory of N cycles of ANM-LD.
- mode_ov: Contains selected ANM modes, collectivity and overlap values for each cycle.
- ANMmodeshapes_SEL: Contains mode shapes and eigenvalues of the selected ANM modes for each cycle.
- matlab.log: Detailed steps of the performed ANM-LD run is included in this log file.

Requirements of the OS and softwares used:
- Linux OS
- MATLAB
- AMBER 11 molecular simulations package

A sample command to submit a batch script to start an ANM-LD run (in the case of Slurm workload manager):
    
    sbatch submitANMLD.sh

   
# Mutant Analysis

Cumulative Absolute Angle Deviation MATLAB Script
Script for comparing virtual torsional angles of different ANM-LD trajectories (such as WT versus mutant trajectories). 

Author:
Burçin Acar

Prerequisite: 
CircStat toolbox should be downloaded (Reference: P. Berens, CircStat: A Matlab Toolbox for Circular Statistics, Journal of Statistical Software, Volume 31, Issue 10, 2009.) 

Main Script:
Following parameters should be inserted in the script. 

* Residue number: resno=1144; 
* Total frame number: fno=100; 
* Hinge residues forming the angles: ANM1hA=[11 12 78 79 80 81 82 83 207 208 211 228 ...
    232 233 267 269 270 271 272 273 275 313 314 315 316 317 318 319 ...
    320 321 323]; 

* Trajectory coordinate files given in following folders WT for reference trajectory and exp for deviated trajectory from this reference

fn2={'experimented/exp','experimented/WT'} 


If you use the code in this repository, please cite:
Acar, B., Rose, J., Fas, B. A., Ben-Tal, N., Lewinson, O., & Haliloglu, T. (2020). Distinct allosteric networks underlie mechanistic speciation of ABC transporters. Structure, 28(6), 651-663.
