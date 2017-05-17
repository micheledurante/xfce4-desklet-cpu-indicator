CC = gcc
FILES = desklet-cpu-indicator.c
OUT_EXE = desklet-cpu-indicator
FLAGS = -Wall -g

build: $(FILES)
	$(CC) -o $(OUT_EXE) $(FLAGS) $(FILES)

clean:
	rm -f *.o core

rebuild: clean build
