#include <iostream>
#include <fstream>
#include <chrono>
#include <thread>
#include <vector>
#include <string>
#include <unistd.h>
using namespace std;

int main() {
    vector<ofstream> files;
    
    cout << "Process id: " << getpid() << endl;
    cout << "Opening files..." << endl;
    
    int count = 0;
    
    while (true) {
        string filename = "fdFile" + to_string(count) + ".txt";
        files.emplace_back(filename);
        
        if (!files.back().is_open()) {
            cerr << "Failed to open file: " << filename << endl;
            files.pop_back();
            break;
        }
        
        files.back() << "This is file " << count << endl << flush;
        
        if (count % 100 == 0) {
            cout << "Opened " << count << " files" << endl;
        }
        
        count++;
        
        this_thread::sleep_for(chrono::milliseconds(10));
    }
    
    cout << "Maximum number of files opened: " << count << endl;
    cout << "Press Enter to close all files and exit." << endl;
    cin.get();
    
    return 0;
}