FLAGS = -O3 -I include # -mavx -pthread -Wl,-rpath,'$$ORIGIN'
LIBS = -lmujoco -lglfw
CXX = g++
OBJ = obj
SRC = src
INC = include
TARGET = simulator

SOURCES = $(OBJ)/utils.o $(OBJ)/joint_state.o $(OBJ)/planner.o $(OBJ)/astar.o $(OBJ)/solution.o $(OBJ)/light_mujoco.o
INCLUDES = $(INC)/utils.h $(INC)/joint_state.h $(INC)/planner.h $(INC)/astar.h $(INC)/solution.h $(INC)/light_mujoco.h $(INC)/global_defs.h

.PHONY: all clean testing simulator

all: $(TARGET) tests/tests

clean:
	rm -rf $(OBJ)
	rm -f $(TARGET)

testing: tests/tests

$(TARGET): $(SOURCES) $(OBJ)/main.o
	$(CXX) $(SOURCES) $(OBJ)/main.o $(LIBS) -o $(TARGET)

tests/tests: $(SOURCES) $(INC)/planner.h $(INC)/astar.h $(OBJ)/catch_amalgamated.o tests/main.cpp
	$(CXX) $(FLAGS) $(SOURCES) $(OBJ)/catch_amalgamated.o tests/main.cpp $(LIBS) -o tests/tests

# compile commands
$(OBJ)/main.o: $(SRC)/main.cpp $(INC)/planner.h $(INC)/joint_state.h $(INC)/global_defs.h
	mkdir -p $(OBJ)
	$(CXX) $(FLAGS) $(SRC)/main.cpp $(LIBS) -c -o $(OBJ)/main.o

$(OBJ)/joint_state.o: $(SRC)/joint_state.cpp $(INC)/joint_state.h $(INC)/global_defs.h
	mkdir -p $(OBJ)
	$(CXX) $(FLAGS) $(SRC)/joint_state.cpp $(LIBS) -c -o $(OBJ)/joint_state.o

$(OBJ)/planner.o: $(SRC)/planner.cpp $(INC)/planner.h $(INC)/joint_state.h $(INC)/light_mujoco.h $(INC)/global_defs.h
	mkdir -p $(OBJ)
	$(CXX) $(FLAGS) $(SRC)/planner.cpp $(LIBS) -c -o $(OBJ)/planner.o

$(OBJ)/astar.o: $(SRC)/astar.cpp $(INC)/astar.h $(INC)/utils.h $(INC)/global_defs.h
	mkdir -p $(OBJ)
	$(CXX) $(FLAGS) $(SRC)/astar.cpp $(LIBS) -c -o $(OBJ)/astar.o

$(OBJ)/solution.o: $(SRC)/solution.cpp $(INC)/solution.h $(INC)/utils.h $(INC)/global_defs.h
	mkdir -p $(OBJ)
	$(CXX) $(FLAGS) $(SRC)/solution.cpp $(LIBS) -c -o $(OBJ)/solution.o

$(OBJ)/utils.o: $(SRC)/utils.cpp $(INC)/utils.h
	mkdir -p $(OBJ)
	$(CXX) $(FLAGS) $(SRC)/utils.cpp $(LIBS) -c -o $(OBJ)/utils.o

$(OBJ)/light_mujoco.o: $(SRC)/light_mujoco.cpp $(INC)/light_mujoco.h
	mkdir -p $(OBJ)
	$(CXX) $(FLAGS) $(SRC)/light_mujoco.cpp $(LIBS) -c -o $(OBJ)/light_mujoco.o

# test "lib" catch2
$(OBJ)/catch_amalgamated.o: tests/catch2/catch_amalgamated.cpp include/catch2/catch_amalgamated.hpp
	mkdir -p $(OBJ)
	$(CXX) $(FLAGS) tests/catch2/catch_amalgamated.cpp -c -o $(OBJ)/catch_amalgamated.o
