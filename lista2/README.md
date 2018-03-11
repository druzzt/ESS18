# Embedded Security Systems - laboratory 2
 1. Download code available for this class. Read it carefully before running any ghdl instance! Go through both architectures of lfsr entity, sketch them out on paper.
2. Run code for the testbench a number of times, changing the IV of both UUT’s. Observe how (if) the changes you introduce change the output.
3. Modify the code so that the LFRS’s reflect those found in A5/1 (change the lengths and tap positions). Connect outputs of these LFSR’s to a three-input XOR to produce another signal, say RND. Using std.textio library from previous class print out to console the value of RND after each clock cycle.
4. Using any programming language write a tool to determine the randomness properties of the sequence of RND bits you produced. Choose 3-4 tests from [A Statistical Test Suite for Random and Pseudorandom Number Generators for Cryptographic Applications](https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-22r1a.pdf).
5. Using the tool, **try to find** such IV’s that result in poorest randomness for the analysed LFSR configuration.

### Intro
 The list is about using programs written in VHDL 
 
### [Sketch](assignment-1-2/LFSRs.pdf)
<object data="assignment-1-2/LFSRs.pdf" type="application/pdf" width="700px" height="700px">
    <embed src="assignment-1-2/LFSRs.pdf"/>
</object>

### Quick run

```sh
$ cd assignment-3-5
$ ./startTests.sh
> enjoy
```

| Statistical Test Name | Output [Average] |
| ------ | ------ |
| Monobit frequency | **0.5** |
| Frequency within a block | **0.82** |
| Random excursions variant | **[** 0.78, 0.54, **0.001**, 0.34, 0.12 **]** |
