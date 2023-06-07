#include <iostream>
#include <fstream>
#include <string>
#include "rapidxml-1.13/rapidxml.hpp"
#include "obstacles.h"
#include "robot.h"
#include "parsing.h"
#include <vector>

int main()
 {
    std::vector<Obstacle*> obstacles;
    Robot robot = Robot();
    read_scene("example.xml", obstacles, robot);

    std::cout << obstacles.size()<< std::endl;

    for (const auto& obstacle : obstacles) {
        delete obstacle;
    }

    std::cout << std::endl;
    robot.PrintJointDetails();

    return 0;
}

