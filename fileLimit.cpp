#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <thread>
#include <chrono>
#include <unistd.h>
using namespace std;

int main() {
    vector<ofstream> files;
    const int total_files = 100000;
    const int batch_size = 1000;
    
    cout << "Process id: " << getpid() << endl;
    cout << "Attempting to open " << total_files << " files in batches of " << batch_size << endl;
    
    int opened_files = 0;
    bool reached_limit = false;
    
    for (int batch = 0; batch < total_files / batch_size && !reached_limit; ++batch) {
        cout << "Opening batch " << batch << " (Files " << batch * batch_size << " - " 
                  << (batch + 1) * batch_size - 1 << ")..." << endl;
        
        for (int i = 0; i < batch_size && !reached_limit; ++i) {
            string filename = "limitFile" + to_string(opened_files) + ".txt";
            files.emplace_back(filename);
            
            if (!files.back().is_open()) {
                cerr << "Failed to open file: " << filename << " after " << opened_files << " files" << endl;
                files.pop_back();
                reached_limit = true;
                break;
            }
            
            files.back() << "File " << opened_files << endl;
            opened_files++;
            
            if (opened_files % 100 == 0) {
                cout << "Opened " << opened_files << " files\r" << flush;
            }
        }
        
        if (!reached_limit) {
            cout << "Completed batch " << batch << ". Sleeping for 1 second..." << endl;
            this_thread::sleep_for(chrono::seconds(1));
        }
    }
    
    cout << "\nMaximum number of files opened: " << opened_files << endl;
    cin.get();
    
    return 0;
}