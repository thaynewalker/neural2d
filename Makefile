# Makefile for neural2d.
#
# neural2d is the standalone console program for the neural net.
# neural2d-gui is the optional Python GUI for neural2d.
# qtui.py is a necessary part of the GUI, derived from qtui-neural-net2.ui.
#
# This Makefile has the following targets:
#
#    make all    # same as make neural2d qtui.py
#    make        # defaults to make all
#    make clean  # removes the neural2d objects, but leaves qtui.py.
#    make test   # execute neural2d on a test set of data


# Specify a compiler here that understands C++-11:
COMPILER=g++ -std=c++11 -fopenmp

# Warning: -O2 and -fopenmp do not work well together.
# It's ok to use -O1 and -fopenmp at the same time.
EXTRACFLAGS=-g -O1 -fopenmp -Wall -Wextra


all: neural2d qtui.py

# This rule makes the QT4 part of neural2d-gui.py. If the GUI
# is not needed, or if you know that your qtui.py is up-to-date,
# then this rule can be disabled:

qtui.py: qtui-neural-net2.ui
	pyuic4 qtui-neural-net2.ui > qtui.py

# The next rules make the neural2d program. It can be run standalone without
# a GUI, or spawned and managed by the GUI.

neural2d: neural2d.o neural2d-core.o Makefile
	$(COMPILER) $(EXTRACFLAGS) neural2d.o neural2d-core.o -o neural2d

neural2d.o: neural2d.cpp neural2d.h Makefile
	$(COMPILER) $(EXTRACFLAGS) -c neural2d.cpp -o neural2d.o

neural2d-core.o: neural2d-core.cpp neural2d.h Makefile
	$(COMPILER) $(EXTRACFLAGS) -c neural2d-core.cpp -o neural2d-core.o

clean:
	rm neural2d neural2d.o neural2d-core.o

# Run neural2d on a test set of images:

images/digits/test-1.bmp:
	@echo "Before running the test, you must extract the archive of images in images/digits/"
	@false

test: images/digits/test-1.bmp
	./neural2d topology.txt inputData.txt weights.txt

.PHONY: all clean test