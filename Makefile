#
# Copyright or © or Copr. Tancrede Lepoint.

# Tancrede.Lepoint@cryptoexperts.com

# This software is a computer program whose purpose is to provide to the 
# research community a proof-of-concept implementation of the homomorphic 
# evaluation of the lightweight block cipher SIMON, describe in the paper
# "A Comparison of the Homomorphic Encryption Schemes FV and YASHE", of
# Tancrede Lepoint and Michael Naehrig, available at
# http://eprint.iacr.org/2014.

# This software is governed by the CeCILL license under French law and
# abiding by the rules of distribution of free software.  You can  use, 
# modify and/ or redistribute the software under the terms of the CeCILL
# license as circulated by CEA, CNRS and INRIA at the following URL
# "http://www.cecill.info". 

# As a counterpart to the access to the source code and  rights to copy,
# modify and redistribute granted by the license, users are provided only
# with a limited warranty  and the software's author,  the holder of the
# economic rights,  and the successive licensors  have only  limited
# liability. 

# In this respect, the user's attention is drawn to the risks associated
# with loading,  using,  modifying and/or developing or reproducing the
# software by the user in light of its specific status of free software,
# that may mean  that it is complicated to manipulate,  and  that  also
# therefore means  that it is reserved for developers  and  experienced
# professionals having in-depth computer knowledge. Users are therefore
# encouraged to load and test the software's suitability as regards their
# requirements in conditions enabling the security of their systems and/or 
# data to be ensured and,  more generally, to use and operate it in the 
# same conditions as regards security. 

# The fact that you are presently reading this means that you have had
# knowledge of the CeCILL license and that you accept its terms.
#




# Choose the underlying leveled homomorphic encryption scheme
# 	YASHE = 1, 	FV = 2
SCHEME 		= 	1

CXX			= 	g++
CXXFLAGS 	= 	-I/usr/local/include -I/opt/local/include -O3 -fopenmp
CXXFLAGS 	+= 	-Wall -pedantic
LDFLAGS 	= 	-L/opt/local/lib -lgmp -lgmpxx -lcrypto -lm -lmpfr -lflint

SOURCES 	= 	$(filter-out benchmark.cpp, $(wildcard *.cpp))
HEADERS 	= 	$(wildcard *.h)
OBJECTS 	= 	$(SOURCES:.cpp=.o)
EXEC		= 	Simon

ifeq ($(SCHEME), 1)
	SOURCES_SCHEME = $(wildcard YASHE/*.cpp)
	HEADERS_SCHEME = $(wildcard YASHE/*.h)
	OBJECTS_SCHEME = $(SOURCES_SCHEME:.cpp=.o)
	CXXFLAGS += -DYASHE -g
endif

ifeq ($(SCHEME), 2)
	SOURCES_SCHEME = $(wildcard FV/*.cpp)
	HEADERS_SCHEME = $(wildcard FV/*.h)
	OBJECTS_SCHEME = $(SOURCES_SCHEME:.cpp=.o)
	CXXFLAGS += -DFV
endif

all: $(SOURCES) $(SOURCES_SCHEME) $(EXEC) benchmark

$(EXEC): $(OBJECTS) $(OBJECTS_SCHEME)
	$(CXX) $(CXXFLAGS) -o $(EXEC) $(OBJECTS) $(OBJECTS_SCHEME) $(LDFLAGS)

benchmark: benchmark.o $(OBJECTS) $(OBJECTS_SCHEME)
	g++ -I/usr/local/include -I/opt/local/include -O3 -fopenmp -Wall -pedantic -DYASHE -o benchmark benchmark.o Simon.o timing.o YASHE/BitVector.o YASHE/Ciphertext.o YASHE/Entropy.o YASHE/Sampler.o YASHE/YASHEKey.o -L/opt/local/lib -lgmp -lgmpxx -lcrypto -lm -lmpfr -lflint

benchmark.o:
	g++ -I/usr/local/include -I/opt/local/include -O3 -fopenmp -Wall -pedantic -DYASHE  -g -c -o benchmark.o benchmark.cpp

$(OBJECTS): Makefile $(HEADERS) 

$(OBJECTS_SCHEME): Makefile $(HEADERS_SCHEME)

.PHONY: clean
clean:
	rm -f $(OBJECTS) $(OBJECTS_SCHEME) $(EXEC)
