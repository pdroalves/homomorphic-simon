/*

Copyright or © or Copr. Tancrede Lepoint.

Tancrede.Lepoint@cryptoexperts.com

This software is a computer program whose purpose is to provide to the 
research community a proof-of-concept implementation of the homomorphic 
evaluation of the lightweight block cipher SIMON, describe in the paper
"A Comparison of the Homomorphic Encryption Schemes FV and YASHE", of
Tancrede Lepoint and Michael Naehrig, available at
http://eprint.iacr.org/2014.

This software is governed by the CeCILL license under French law and
abiding by the rules of distribution of free software.  You can  use, 
modify and/ or redistribute the software under the terms of the CeCILL
license as circulated by CEA, CNRS and INRIA at the following URL
"http://www.cecill.info". 

As a counterpart to the access to the source code and  rights to copy,
modify and redistribute granted by the license, users are provided only
with a limited warranty  and the software's author,  the holder of the
economic rights,  and the successive licensors  have only  limited
liability. 

In this respect, the user's attention is drawn to the risks associated
with loading,  using,  modifying and/or developing or reproducing the
software by the user in light of its specific status of free software,
that may mean  that it is complicated to manipulate,  and  that  also
therefore means  that it is reserved for developers  and  experienced
professionals having in-depth computer knowledge. Users are therefore
encouraged to load and test the software's suitability as regards their
requirements in conditions enabling the security of their systems and/or 
data to be ensured and,  more generally, to use and operate it in the 
same conditions as regards security. 

The fact that you are presently reading this means that you have had
knowledge of the CeCILL license and that you accept its terms.

*/

#ifndef __BENCHMARK_H
#define __BENCHMARK_H

/* 
* Uncomment either the TEST mode, or the homomorphic evaluation of SIMON
* possible values: SIMON=32 or SIMON=64
*/
//#define TEST
#define SIMON 32
//#define SIMON 64

/* Uncomment to verbose */
//#define VERBOSE

/* Main File */
#include <iostream>
#include <vector>
#include <iomanip>
#include <sstream>
#include <string>
#include "timing.h"

// If YASHE
#define BATCH 1
#include "YASHE/YASHEKey.h"

const struct YASHEParams params = {
	8192,1,8,

	// 127-bit prime
	fmpzxx("170141183460469231731687303715884105727"),

	// t
	fmpzxx("1024")
};
typedef YASHEKey KEY;

// #ifndef __BENCHMARK_H
#endif
