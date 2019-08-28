# ANMLD and Mutant Analysis
ANMLDcode.zip file contains scripts, functions, parameter and input files necessary to run ANM-LD simulations for the case studied in the manuscript submitted. 

The contents of the ANMLDcode.zip file:

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
- MATLAB R2010a
- AMBER 11 molecular simulations package

A sample command to submit a batch script to start an ANM-LD run (in the case of Slurm workload manager):
    
    sbatch submitANMLD.sh
   
# Mutant Analysis
cumulative_angle_deviation.m: In order to to compare virtual torsional angle changes between WT and mutant simulations, we calculate torsional angles of four consecutive residue CAs residing in each conformation of the ANM-LD trajectory for WT and mutants. Then we calculate the cumulative angle deviation from WT for mutants. 
                                                                   
