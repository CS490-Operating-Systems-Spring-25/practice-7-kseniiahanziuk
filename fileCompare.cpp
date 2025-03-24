#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

bool fileExists(const string& filename) {
    ifstream file(filename);
    return file.good();
}

int main() {
    string file1, file2;
    
    cout << "Enter the first filename: ";
    cin >> file1;
    
    if (!fileExists(file1)) {
        cerr << "Error: The file '" << file1 << "' does not exist." << endl;
        return 1;
    }
    
    cout << "Enter the second filename: ";
    cin >> file2;
    
    if (!fileExists(file2)) {
        cerr << "Error: The file '" << file2 << "' does not exist." << endl;
        return 1;
    }
    
    ifstream f1(file1);
    ifstream f2(file2);
    
    string line1, line2;
    int lineNumber = 0;
    bool filesDiffer = false;
    
    while (getline(f1, line1) && getline(f2, line2)) {
        lineNumber++;
        
        if (line1 != line2) {
            cout << "Files differ at line " << lineNumber << ":" << endl;
            cout << file1 << ": " << line1 << endl;
            cout << file2 << ": " << line2 << endl;
            filesDiffer = true;
            break;
        }
    }
    
    if (!filesDiffer) {
        if (getline(f1, line1)) {
            cout << "Files differ in length. " << file1 << " is longer." << endl;
            cout << "First extra line in " << file1 << ": " << line1 << endl;
            filesDiffer = true;
        } else if (getline(f2, line2)) {
            cout << "Files differ in length. " << file2 << " is longer." << endl;
            cout << "First extra line in " << file2 << ": " << line2 << endl;
            filesDiffer = true;
        }
    }
    
    if (!filesDiffer) {
        cout << "The files are identical." << endl;
    }
    
    return 0;
}