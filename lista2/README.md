# Embedded Security Systems - laboratory 2

## VHDL + LFSR + A5/1
 
### TASK 1

>Download code available for this class. Read it carefully before running any ghdl instance! Go through both architectures of lfsr entity, sketch them out on paper.

[Task's 1. LFSRs direct browser render](https://render.githubusercontent.com/view/pdf?commit=238ae31fd982d6329c7b560481ddcf2849ead335&enc_url=68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f6472757a7a742f696d67732f323338616533316664393832643633323963376235363034383164646366323834396561643333352f4c465352732e706466&nwo=druzzt%2Fimgs&path=LFSRs.pdf&repository_id=124795703&repository_type=Repository#972fb936-3e18-44cc-ade7-8c387c8b82c1)

### TASK 2

>Run code for the testbench a number of times, changing the IV of both UUT’s. Observe how (if) the changes you introduce change the output.

Changing the IV (*q1* and *q2* input vectors) does introduce changes to the output. All of it depends on the 'random' (static in this case) movement of the fields in the vector.

### TASK 3

>Modify the code so that the LFRS’s reflect those found in A5/1 (change the lengths and tap positions). Connect outputs of these LFSR’s to a three-input XOR to produce another signal, say RND. Using std.textio library from previous class print out to console the value of RND after each clock cycle.

[A5/1 scheme](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/A5-1_GSM_cipher.svg/800px-A5-1_GSM_cipher.svg.png)
To change the LFSR from the TASKS 1-2 i had to create three distinct entities of LFSR1, LFSR2 and LFSR3. With following input vector sizes: [19, 22, 23]. I also had to change the output function for each of them as given on the [*scheme*](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/A5-1_GSM_cipher.svg/800px-A5-1_GSM_cipher.svg.png). The most important step was to adjust the test_bench file so it could gather data from three LFSRs at once and XOR their outputs. Next of the important steps was to adjust size of initial vectors (*q1, q2, q3*).

### TASK 4

>Using any programming language write a tool to determine the randomness properties of the sequence of RND bits you produced. Choose 3-4 tests from [A Statistical Test Suite for Random and Pseudorandom Number Generators for Cryptographic Applications](https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-22r1a.pdf).

Beforehand writing a set of tools to determine the randomness properties of the sequence of RND bits, i had to add two methods writing out the result to the standard output, so i could pass it to a file for further processing. 
I have chosen a python as a programming language of the tools and selected 3 tests from [A Statistical Test Suite for Random and Pseudorandom Number Generators for Cryptographic Applications](https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-22r1a.pdf):
- Frequency monobit test
>The focus of the test is the proportion of zeroes and ones for the entire sequence. The purpose of this test is to determine whether the number of ones and zeros in a sequence are approximately the same as would be expected for a truly random sequence. The test assesses the closeness of the fraction of ones to 1⁄2, that is, the number of ones and zeroes in a sequence should be about the same. All subsequent tests depend on the passing of this test.
- Frequency test within a block
>The focus of the test is the proportion of ones within M-bit blocks. The purpose of this test is to determine whether the frequency of ones in an M-bit block is approximately M/2, as would be expected under an assumption of randomness. For block size M=1, this test degenerates to test 1, the Frequency (Monobit) test.
- Random excursions variant
>The focus of this test is the total number of times that a particular state is visited (i.e., occurs) in a cumulative sum random walk. The purpose of this test is to detect deviations from the expected number of visits to various states in the random walk. This test is actually a series of eighteen tests (and conclusions), one test and conclusion for each of the states: -9, -8, ..., -1 and +1, +2, ..., +9.

Implementation of those tests were straightforward as they were well explained in the [document](https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-22r1a.pdf).

### TASK 5

>Using the tool, **try to find** such IV’s that result in poorest randomness **for the analysed LFSR** configuration.

In search for the poorest randomnes i had to look for P-values of higher than 0.01. In below tables i used bold font for distinguishing random as it was easier to show smaller set.

| Statistical Test Name | Output [P-value] | q1 | q2 | q3
| ------ | ------ | -------- | ----------| ------|
| Monobit frequency | 1.32694827927e-218 | 1111111111111111111 | 1111111111111111111111 | 11111111111111111111111
| Frequency within a block | 1.0 |1111111111111111111 | 1111111111111111111111 | 11111111111111111111111
| Random excursions variant | **[** 0.8083651559145103, 0.79625341473763922, 0.7815112949987133, 0.76302460055299504, 0.73888268036352722, 0.70545698611127339, 0.65472084601857694, 0.5637028616507731, 0.61707507745197387, 0.61707507745197387, 0.77282999268444752, 0.82306327375812149, 0.85010673913852586, 0.86763233477819268, 0.88016845490672546, 0.88970693553310121, 0.897278961260083, 0.90347891371922961 **]** |1111111111111111111 | 1111111111111111111111 | 11111111111111111111111

This shows that monobit frequency test has the smallest P-value. (P-val < 0.01)

| Statistical Test Name | Output [P-value] | q1 | q2 | q3
| ------ | ------ | -------- | ----------| ------|
| Monobit frequency | 0.751829634046 | 0101010101010101011 | 0101010101010101010101 | 01010101010101010101010
| Frequency within a block | 1.20625420531e-15 |0101010101010101011 | 0101010101010101010101 | 01010101010101010101010
| Random excursions variant | **[** 0.065196419078130077, 0.043308142810791976, **0.0091946839117596872**, **0.00035256536354662**, **0.00025995833275431056**, **0.0068408584358289753**, 0.07186063822585162, 0.052807511416113631, 0.013906296895346081, 0.50233495436050224, 0.51860501642872558, 0.61707507745197387, 0.67260381744151665, 0.55098498758509362, 0.50018425707079439, 0.53514345239775052, 0.5637028616507731, 0.58759384795565772 **]** |0101010101010101011 | 0101010101010101010101 | 01010101010101010101010

For above input vectors i had the smallest P-val for Frequency within a block test and some of variant excursions (**bold font**).

| Statistical Test Name | Output [P-value] | q1 | q2 | q3
| ------ | ------ | -------- | ----------| ------|
| Monobit frequency | 0.569213649474 | 0000000000000000000 | 0000000000000000000000 | 00000000000000000000000
| Frequency within a block | 0.0171083130351 |0000000000000000000 | 0000000000000000000000 | 00000000000000000000000
| Random excursions variant | **[** 0.60690542721795082, 0.62635436103408759, 0.55629846127473481, 0.3555541235292704, 0.15729920705028516, 0.24681015326181155, 0.20590321073206841, 0.34080324688608477, 1.0, 0.47950012218695348, 0.68309139830960874, 0.52708925686553809, 0.42267807417063552, 0.47950012218695348, 0.52243128496156443, 0.55629846127473481, 0.58388242077036523, 0.60690542721795082 **]** |0000000000000000000 | 0000000000000000000000 | 00000000000000000000000

For set of zeroes the randomnes was very low. In fact the output was very predictable.


### Quick run

```sh
$ cd lista2/assignment-3-5
$ ./startTestsA51.sh
> enjoy the A5/1
$ cd ../assignment-1-2
$ ./startTestsLFSR.sh
> enjoy the simple LFSRs
```
