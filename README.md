Test Generator
==============

What it is:

* playground

What it is not:

* finished

Idea:

Usually a system under test has multiple states and receives multiple, various input values/data.
A SUT state, becomes an input for the testcase along with the input data creating the environment for the test.
Restrictions can be enforced for each input (e.g. the system cannot be configured with parameter_1=value_1 and parameter_2=value_2 )
The script parses the json generating all combinations for each input and excluding the restrictions.
Finally it generates all combinations from all input combinations thus generating all system states (testcases) as defined in the json file.
The file output.txt contains each combination per row.


ToDo:
* web interface for managing the json file
* generating expected results based on input combinations (as much as possible to describe)
* sanitize output for Cucumber use

To run:
* ruby test_gen.rb

Sample output:

  For input input_1 - found 27 combinations - after applying restrictions: 23
  For input input_2 - found 81 combinations - after applying restrictions: 60
  Found 1380 tests
	