#include <iostream>
#include <fstream>
#include <chrono>
#include <ctime>
#include <thread>
#include <unistd.h>
using namespace std;

int main() {
    ofstream file("test.txt");
    
    if (!file.is_open()) {
        cerr << "Error: Could not open test.txt" << endl;
        return 1;
    }
    
    cout << "Process id: " << getpid() << endl;
    cout << "Starting to write 1000 lines to test.txt" << endl;
    
    for (int i = 0; i < 1000; ++i) {
        file << "Line " << i << " - " << time(nullptr) << endl << flush;
        cout << "Wrote line " << i << "\r" << flush;
        this_thread::sleep_for(chrono::seconds(1));
    }
    
    file.close();
    cout << "\nDone writing to test.txt" << endl;
    
    return 0;
}