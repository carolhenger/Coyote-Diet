# Coyote-Diet

Obitools Work Flow

1) Download all sequences of the target taxa from EMBL (ftp://ftp.ebi.ac.uk/pub/databases/embl/release/)  - this may take up to a week

2) Download NCBI taxonomy (ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz) - only takes a few minutes

3) Install Obitools: Use a mac to install xcode (from Apple App store), Python 2.7 (must use this version), and pip.  Use pip to install virtualenv, sphinx, and cython using the instructions at metabarcoding.org/obitools/doc/welcome.html

Activate Obitools by changing directory to the obitools folder and then typing the command ‘source bin/activate’
You will know that obitools is activated by the parenthesis around obitools

Alternatively, you can download obitools by right clicking get-obitools.py at the website listed above and activate obitools by using the command ./obitools

4) Download the ecoPCR program from https://git.metabarcoding.org/obitools/ecopcr/wikis/home

5) With Obitools activated, use obiconvert to convert sequences from EMBL to .sdk files to be used in the ecoPCR program: 
obiconvert --embl –t ./TAXO --ecopcrdb-output=embl_last ./EMBL/*.dat

Definition of terms:
--embl: specifies that the sequences are from the EMBL database
TAXO: name of the NCBI taxonomy database downloaded in #2.
--ecopcrdb-output: Specifies the name that you want to assign to the sequences to be converted. 
./EMBL: name of the database containing the sequences from the target taxa
*.dat: applies the command to all of the .dat files in the folder

The obiconvert command will take about a day to complete.

6) Activate ecoPCR by changing the directory to the src folder within the ecoPCR directory and then typing ./ecoPCR

7) Move the converted files (.sdx) and the .adx, .ndx, .tdx., .rdx files from obiconvert to the src folder.

8) Run the ecoPCR command on the converted files to make the ecopcr database using the command: ./ecoPCR –d ./EMBL –e 3 –l 50 –L 500 sequence 1 sequence 2 > mysequences.ecopcr


Definitions:
./EMBL: folder with sequences of target taxa
-e maximum number of error allowed per primer
-l minimum sequence length
-L maximum sequence length

This command will take a few hours

9) Filter the ecopcr database that you created by following steps 1-4 at the bottom of the wolf tutorial: https://pythonhosted.org/OBITools/wolves.html

After the database is created, use these steps below to analyze your sequences:

10)  Align the Left and Right sequences of all of the samples by using the script vertScript_pairedend.sh.  Open the script in a text editor (such as text wrangler or notepad++) and use the replace function to specify your sample names and directories.
Run the script by typing “./vertScript_pairedend.sh” (without quotes).  The ./ means that the script that you are running is in the same directory that you are currently in.  Alternatively, you can specify the entire path name.
 If you are denied permission, open up a new shell window (don’t activate obitools on it, but keep the other obitools window open) and type “chmod 777 ./vertScript_pairedend.sh” (without quotes).  This gives everyone permission to run the script.  You can also change who gets permission to run the program by changing the number associated with the chmod command.  You can find out more about it here:  https://www.maketecheasier.com/file-permissions-what-does-chmod-777-means/  

11) Run the trim.sh script to use cutadapt program to trim primers from sequences. 

12) Use the script vertScript_ann.sh to add the sample name to each file using the obiannotate command. This command individually labels each sample so that they can be distinguished after combining all of the samples into one file.  It also saves them into a separate folder called vertCat.  Changing the names of the files and/or directories each step allows you to redo the previous step if you make a mistake. Before running the script, edit the file so that it reflects your sample names and directories. 

13) In the non-obitools Terminal window, change the directory to the folder that contains the aligned files (for my samples it is vertCat).  Do not activate OBITools in this window.  Combine all of the aligned sequences into one file with the concatenate command: cat *.fastq > vert.fastq
This command will combine all fastq files in that directory into one fastq file called vert.fastq.

14) The script called script.vertSteps.sh lists most of the commands used in obitools for all of the vertebrate sequences.  The only command that is not listed is the ngsfilter.  I didn’t use this command because the adapters and barcodes were already removed when I received the data.
Run the script by typing “./script.vertSteps.sh” (don’t type the quotations) in the obitools shell window.  

15) Once the script is done running (should take 1-2 hours), you should have a txt file called vertCatAnn2.txt (or whatever name you decided to call the file).
