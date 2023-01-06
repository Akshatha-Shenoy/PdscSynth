EXTRA_INCLUDE_FLAGS="-I /home/u1913883/z3/src/api -I /home/u1913883/z3/src/api/c++"
EXTRA_LINKER_FLAGS=-L/home/u1913883/z3/build
#TODO: remove above before shipping

g++ ${EXTRA_INCLUDE_FLAGS} -ggdb -o qe qe.cpp ${EXTRA_LINKER_FLAGS} -lz3
