# StatWhy v.1.3.0

StatWhy is a software tool for automatically verifying the correctness of statistical hypothesis testing programs. In this file, we present the structure of this repository, the resource requirements for the tool, and show how to verify the programs that implement the hypothesis testing examples addressed in our paper.

## Structure of the repository

```
root/
├ README.md                        this file
├ install.sh                       installation script
├ cameleer                         source code of *cameleer*
│ └ statwhy                        source code of *statwhy*
│   ├ lib                          core library of statwhy, including the specification
│   │                              of many hypothesis testing methods
│   └ ...
├ doc
│ └ Statwhy_User_Documentation.pdf user documentation of statwhy
├ examples                         codes for replicating the results
│ └ mlw                            examples not explained in this file
└ ...
```

## Resource requirements

StatWhy has been tested on the following environments:

1. MacBook Pro -- M2 Max CPU, 96 GB RAM, macOS 15.3.2
2. DELL Precision 5490 -- Intel Core Ultra 9 185H, 64 GB RAM, Windows 11 (via WSL)

## Correctness of StatWhy

We have tested the tool StatWhy by (i) checking that StatWhy can correctly verify various major hypothesis testing methods in a short time in a way that is consistent with standard textbooks on statistics and (ii) proving various lemmas on the properties of epistemic logic (statELHT.mlw) and on those of hypothesis tests and belief Hoare logic (statBHL.mlw).


## Installing StatWhy

### Auto Installation using Bash Script (Ubuntu 24.04)

On Ubuntu 24.04, StatWhy can be installed by running the following commands:

``` bash
$ chmod +x install.sh
$ ./install.sh
```

During installation, you will be prompted to enter `y` or `n` multiple times.
Press `y` when prompted.

After installation, restart the machine or log in again to apply the changes made to `~/.profile`.

### Manual Installation

1. Install opam

On Ubuntu:

``` bash
$ sudo apt-get update
$ sudo apt-get install opam
```

On macOS, install opam with Homebrew:

``` bash
$ brew install opam
```

Alternatively, if you use MacPorts:

``` bash
$ port install opam
```

2. Install OCaml 5.0.0

To install OCaml 5.0.0, execute the following command:

``` bash
$ opam switch create 5.0.0
$ eval $(opam env)
```

3. Install StatWhy and Cameleer

Download the source code of StatWhy, including an extension of Cameleer.
Install \StatWhy{} and \Cameleer{} by running:

``` bash
$ unzip statwhy-1.3.0.zip
$ cd cameleer
$ opam pin add .
```

This will install Cameleer, StatWhy (included in `cameleer/src/statwhy`), and their dependencies.
In the installation of Cameleer, the Why3 platform is automatically installed.

4. Install CVC5

On Ubuntu 24.04 LTS, you can install CVC5 by:

``` bash
$ sudo apt install cvc5
```

Alternatively, you can directly download a binary from the GitHub repository:

``` bash
$ wget https://github.com/cvc5/cvc5/releases/download/cvc5-1.2.0/cvc5-Linux-x86_64-static.zip
$ unzip cvc5-Linux-x86_64-static.zip
$ sudo cp ./cvc5-Linux-x86_64-static/bin/cvc5 /usr/local/bin
```

On macOS, a Homebrew Tap for CVC5 is also available:

``` bash
$ brew tap cvc5/homebrew-cvc5
$ brew install cvc5
```

After installing the solver, run the following command to let Why3 detect it:

``` bash
$ why3 config detect
```

As an initial test, try running the one-sample t-test program by following the instructions in [Example 1](### Example 1: One-sample t-test (Section 3.1 in our paper)) below.

## Usage

You can verify an OCaml code via Cameleer by running the following:

``` bash
$ statwhy <file-to-be-verified>.ml
```

If you want to verify a WhyML code:

``` bash
$ statwhy <file-to-be-verified>.mlw
```

Note that in both cases, you need our extension of Cameleer to load StatWhy.

## Example: One-sample t-test

We demonstrate how to verify a program that conducts a one-sample t-test, which is used to compare a population mean with a specified value.
To verify the OCaml program `examples/example1.ml`, run the following command:

``` bash
statwhy example1.ml
``` 

This will launch the Why3 IDE as follows:

![](./screenshots/example1-why3-ide.png?raw=true "The Why3 IDE screen.")

There are two verification conditions (VCs) to be discharged: example_1'vc (the VC for `example1`) and example1''vc (the VC for `example1'`).
Right-click on the first goal and select 'StatWhy' (**Not 'CVC5' or the other items**), or press '4' after selecting the goal to make StatWhy try to discharge the goal.
If the prover successfully verifies the goal, a check mark will appear as follows.

![](./screenshots/example1-successful.png?raw=true "The Why3 IDE screen successfully discharged example1'vc.")

The second goal, example1''vc, is similar to the first except that the expression `sampled d t_n` is missing from the requires-clause, i.e., the specification does not describe the requirement that the data set `d` is sampled from a normally distributed population.
If this requirement is not satisfied, it is not appropriate for us to use the t-test.

By running StatWhy, you can automatically detect that this requirement is missing in the annnotation of the program.
In fact, if you press '4' on example_1samp_t_test_fail'vc, **StatWhy will fail to discharge the goal**, as shown below.
At this point, StatWhy generates sub-goals by applying transformations and attempts to prove them.
By examining the results of the sub-goals, you can see which conditions are missing in the annotation of the program.

![](./screenshots/example1-timed-out.png?raw=true "The Why3 IDE screen showing a goal that StatWhy could not discharge.")

**We emphasize that the above screenshot is the intended result**, in which several verification conditions are not discharged due to the lack of the precondition.
In the above screenshot, the condition `sampled d (NormalD ...)` fails to discharge, which is equivalent to the missing precondition `sampled d t_n`.

- Approximate execution time: 1.5 min

## Other examples on various hypothesis testing methods

We have implemented various hypothesis testing methods not presented in the paper.
For details, see the User Documentation.
