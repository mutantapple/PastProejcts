//
//  main.c
//  CSCI-2240-D-S15-A1
//
//  Created by David Quiring on 2/26/15.
//  Copyright (c) 2015 David Quiring. All rights reserved.
//

#include <stdio.h>
#include <string.h>

int checkUp(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gSize);
int checkDown(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gSize);
int checkRight(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gSize);
int checkLeft(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gSize);
int checkDDR(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gSize);
int checkDDL(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gSize);
int checkDUR(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gSize);
int checkDUL(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gSize);

// This program does a word search
// the program takes input form a file for the word shirt.
// the first part of the file contians the table of charachers on which to do the word search
// after that comes the list of words to find
// the words can be in any direction.

int main(int argc, const char * argv[]) {
    char grid[50][50];
    char solution[50][50];
    char words[200][50];
    int sizeOfGrid = 1;
    int wordsFound = 0;
    int totalWords = 0;
    
    int i;
    int j;
    
    //ini the grid and the words
    for (i = 0; i < 50; i++) {
        for (j = 0; j < 50; j++) {
            grid[i][j] = ' ';
        } //end for
    } //end for
    
    for (i = 0; i < 200; i++) {
        for (j = 0; j < 50; j++) {
            words[i][j] = ' ';
        } //end for
    } //end for
    
    // read in the grid
    char c;
    int x = 0;
    int y = 0;
    
//    printf("HI\n");
    
    while (y < sizeOfGrid) {
        c = getchar();
        
        if (c == '\n') { //go to the next line
            sizeOfGrid = x;
            x = 0;
            y++;
        } else if (c != ' ') { //put the data in the aray
            grid[y][x] = c;
            x++;
        } else if (c == ' '){
            //don't do a thing.
        }else { //do nothing if it's none of the above
            printf("You entered an invaled character: %c\n", c);
        } //end if
    }//end while
    
    // read in the words
    int l = 0;
    while (totalWords < 200) {
        
        c = getchar();
        
        if (c == '\n') { //end fo word
            totalWords++;
            l = 0;
        } else if (c != ' ') { //add char to word
            words[totalWords][l] = c;
            l++;
        } else { //user enere invalid char
            printf("You entered an invaled character.");
        } //end if
        
        if (feof(stdin)) { //eof
            break;
        } //end if
    }//end while
    
//    printf("\n....\n\n");
    
    //fill the solution gird with spaces
    for (i = 0; i < 50; i++) {
        for (j = 0; j < 50; j++) {
            solution[i][j] = ' ';
        } //end for
    } //end for
    
    //what words do we have
//    for (i = 0; i < sizeOfGrid; i++) {
//        for (j = 0; j < totalWords; j++) {
//            printf("%c", words[i][j]);
//        } //end for
//        printf("\n");
//    }
    
//    printf("Finding the words\n");
//    printf("The size is: %d\n", sizeOfGrid);
//    printf("Total Words: %d\n", totalWords);
//    printf("Words Found: %d\n\n", wordsFound);

    
    // fird the words in the grid
    // put the word in it's corisponding location in the solution grid
    while (wordsFound <= totalWords - 1) {
        
        int wordFound = 0;//this is to be used as a bool
        char word[sizeOfGrid + 1];
        int x = 0;
        int y = 0;
        
        //word = words[wordsFound];
        for (i = 0; i <= sizeOfGrid; i++) {
            if (words[wordsFound][i] != ' ') { //copy over the word
                word[i] = words[wordsFound][i];
            } else  if (words[wordsFound][i] == ' ') { //put in spaces
                word[i] = '-';
            }  else {
                break;
            }//end if
        } //end for
        
//        printf("The current word is: ");
//        for (i = 0; i < sizeof(word); i++) {
//            printf("%c", word[i]);
//        } //end for
//        
//        printf("\n");
        
        while (wordFound != 1) {
            
            //checkLeft
            wordFound = checkLeft(word, grid, solution, 0, x, y, sizeOfGrid);
            
            //checkRight
            wordFound = checkRight(word, grid, solution, 0, x, y, sizeOfGrid);
            
            //checkDown
            wordFound = checkDown(word, grid, solution, 0, x, y, sizeOfGrid);

            //checkUp
            wordFound = checkUp(word, grid, solution, 0, x, y, sizeOfGrid);

            //checkDDR
            wordFound = checkDDR(word, grid, solution, 0, x, y, sizeOfGrid);
            
            //checkDDL
            wordFound = checkDDL(word, grid, solution, 0, x, y, sizeOfGrid);
            
            //checkDUR
            wordFound = checkDUR(word, grid, solution, 0, x, y, sizeOfGrid);
            
            //checkDUL
            wordFound = checkDUL(word, grid, solution, 0, x, y, sizeOfGrid);
            
            x++;
            if (x == sizeOfGrid) {
                x = 0;
                y++;
            } //end if
            if (y == sizeOfGrid) {
                //printf("Word %s not found. Skiping\n", word);
                wordFound = 1;
                
            }
        } //end while
        
        if (wordFound == 1) {
            wordsFound++;
        } //end if
        
//        printf("Total Words: %d\n", totalWords);
//        printf("Words Found: %d\n\n", wordsFound);
    }//end while
    
    
    // print the solution
//    printf("-------------------\n");
    for (i = 0; i < sizeOfGrid; i++) {
        for (j = 0; j < sizeOfGrid; j++) {
            printf("%c ", solution[i][j]);
        } //end for
        printf("\n");
    } //end for
    
//    printf("-------------------\n");
    
    return 0;
}//end main

// check up
int checkUp(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gS) {
    //printf("L: %c\n Y: %d X: %d\n", w[l], y, x);
    if (w[l] == g[y][x]) { //does the current letter match
        if (w[l+1] != '-' ) { //have we found the whole word?
            if(x >= 0) { //don't go out of bounds.
                if (checkUp(w, g, s, l + 1, x, y - 1, gS) == 1) { //check the next letter
                    s[y][x] = w[l]; //mark the solution
                    return 1;
                } else {
                    return 0;
                }//end if
            } else {
                return 0;
            }//end if
        } else {
            s[y][x] = w[l]; //mark the solution
            return 1;
        } // end if
    } else {
        return 0;
    }//end if
    return 1;
} //end checkUp

//check down
int checkDown(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gS) {
    //printf("L: %c\n Y: %d X: %d\n", w[l], y, x);
    if (w[l] == g[y][x]) { //does the current letter match
        if (w[l+1] != '-' ) { //have we found the whole word?
            if(x <= gS) { //don't go out of bounds.
                if (checkDown(w, g, s, l + 1, x, y + 1, gS) == 1) { //check the next letter
                    s[y][x] = w[l]; //mark the solution
                    return 1;
                } else {
                    return 0;
                }//end if
            } else {
                return 0;
            }//end if
        } else {
            s[y][x] = w[l]; //mark the solution
            return 1;
        } // end if
    } else {
        return 0;
    }//end if
    return 1;
} //end checkDown

//check to the right
int checkRight(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gS) {
    if (w[l] == g[y][x]) { //does the current letter match
        if (w[l+1] != '-' ) { //have we found the whole word?
            if(x <= gS) { //don't go out of bounds.
                if (checkRight(w, g, s, l + 1, x + 1, y, gS) == 1) { //check the next letter
                    s[y][x] = w[l]; //mark the solution
                    return 1;
                } else {
                    return 0;
                }//end if
            } else {
                return 0;
            }//end if
        } else {
            s[y][x] = w[l]; //mark the solution
            return 1;
        } // end if
    } else {
        return 0;
    }//end if
    return 1;
} //end checkRight

//check left
int checkLeft(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gS) {
//    printf("L: %c\n Y: %d X: %d\n", w[l], y, x);
    if (w[l] == g[y][x]) { //does the current letter match
        if (w[l+1] != '-' ) { //have we found the whole word?
            if(x >= 0) { //don't go out of bounds.
                if (checkLeft(w, g, s, l + 1, x - 1, y, gS) == 1) { //check the next letter
                    s[y][x] = w[l]; //mark the solution
                    return 1;
                } else {
                    return 0;
                }//end if
            } else {
                return 0;
            }//end if
        } else {
            s[y][x] = w[l]; //mark the solution
            return 1;
        } // end if
    } else {
        return 0;
    }//end if
    return 1;
} //end checkLeft

// checkddr ++
int checkDDR(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gS) {
    //printf("L: %c\n Y: %d X: %d\n", w[l], y, x);
    if (w[l] == g[y][x]) { //does the current letter match
        if (w[l+1] != '-' ) { //have we found the whole word?
            if(x <= gS && y <= gS) { //don't go out of bounds.
                if (checkDDR(w, g, s, l + 1, x + 1, y + 1, gS) == 1) { //check the next letter
                    s[y][x] = w[l]; //mark the solution
                    return 1;
                } else {
                    return 0;
                }//end if
            } else {
                return 0;
            }//end if
        } else {
            s[y][x] = w[l]; //mark the solution
            return 1;
        } // end if
    } else {
        return 0;
    }//end if
    return 1;
} //end checkDDR

// checkddl +-
int checkDDL(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gS) {
    //printf("L: %c\n Y: %d X: %d\n", w[l], y, x);
    if (w[l] == g[y][x]) { //does the current letter match
        if (w[l+1] != '-' ) { //have we found the whole word?
            if(x >= 0 && y <= gS) { //don't go out of bounds.
                if (checkDDL(w, g, s, l + 1, x - 1, y + 1, gS) == 1) { //check the next letter
                    s[y][x] = w[l]; //mark the solution
                    return 1;
                } else {
                    return 0;
                }//end if
            } else {
                return 0;
            }//end if
        } else {
            s[y][x] = w[l]; //mark the solution
            return 1;
        } // end if
    } else {
        return 0;
    }//end if
    return 1;
} //end checkDDL

// checkdur -+
int checkDUR(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gS) {
    //printf("L: %c\n Y: %d X: %d\n", w[l], y, x);
    if (w[l] == g[y][x]) { //does the current letter match
        if (w[l+1] != '-' ) { //have we found the whole word?
            if(x <= gS && y >= 0) { //don't go out of bounds.
                if (checkDUR(w, g, s, l + 1, x + 1, y - 1, gS) == 1) { //check the next letter
                    s[y][x] = w[l]; //mark the solution
                    return 1;
                } else {
                    return 0;
                }//end if
            } else {
                return 0;
            }//end if
        } else {
            s[y][x] = w[l]; //mark the solution
            return 1;
        } // end if
    } else {
        return 0;
    }//end if
    return 1;
} //end checkDUR

// checkdul --
int checkDUL(char* w, char g[50][50], char s[50][50], int l, int x, int y, int gS) {
    //printf("L: %c\n Y: %d X: %d\n", w[l], y, x);
    if (w[l] == g[y][x]) { //does the current letter match
        if (w[l+1] != '-' ) { //have we found the whole word?
            if(x >= 0 && y >= 0) { //don't go out of bounds.
                if (checkDUL(w, g, s, l + 1, x - 1, y - 1, gS) == 1) { //check the next letter
                    s[y][x] = w[l]; //mark the solution
                    return 1;
                } else {
                    return 0;
                }//end if
            } else {
                return 0;
            }//end if
        } else {
            s[y][x] = w[l]; //mark the solution
            return 1;
        } // end if
    } else {
        return 0;
    }//end if
    return 1;
} //end checkDUL