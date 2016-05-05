EvoNN
============

Evolutionary Neural Networks (EvoNN)<sup>[1](Noisy Blast Furnace.) </sup> implemented in MATLAB(R).

#### Configuration:

* Install ImageMagick (portable) from here<sup>[2](http://www.imagemagick.org/script/binary-releases.php) </sup> and keep the in same folder as the code. An empty folder is included in repo.
* More coming...

Download the code and run in MATLAB&trade;

### What is Evolutionary Neural Network (EvoNN)?

######  For beginners. If you are not a beginner, you may skip this section.
Read basics of ANN [here](https://en.wikipedia.org/wiki/Artificial_neural_network). and Genetic Algorithms [here](https://en.wikipedia.org/wiki/Genetic_algorithm).
A good book for learning Evolutionary Computation is first reference.


###### For Pro:




### How to run this code?
* Importing the data
  * from excel -> `importdata` from MATLAB as `NumericMatrix`
  * Once the variable is present in the `Workspace`, `saveas` `[_desired_filename].mat`


* Trainig of the Neural Net
  * start with `PP_NNGA_subsets.m`. Configure the parameters and the Folder and filenames and then go to `PP_NNGA_automate.m`
  * set `in_index` and `out_index`(=corresponding to objectives)
  * run (press F5).


### Issues?
We'd love to hear them [here](https://github.com/TwistingTwists/EvoNN/issues).

For authors see, authors.md

References:
---------------
* Deb, K.,”Multi-Objective Optimization Using Evolutionary Algorithms,”Chichester. UK, Wiley, (2002).
* *__K-optimality__* : M. Farina and P. Amato. On the Optimal Solution Definition for Manycriteria Optimization Problems. In Proceedings of the NAFIPS-FLINT International Conference’2002, pages 233–238, Piscataway, New Jersey, June 2002. IEEE Service Center
* *__EvoNN__* : F. Pettersson, N. Chakraborti and H. Saxen, “A genetic Algorithm based multi-objective neural net applied to noisy blast furnance data”, Appl. Soft Compu. 7(2007), pp. 387-397
*
