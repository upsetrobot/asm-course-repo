
/**
 * *****************************************************************************
 * DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS. 
 * *****************************************************************************
 * 
 * Application Test Source Code
 * 
 * This file is NOT module specific (the same copy is in all modules). 
 * 
 * This file is standardized to allow placement in multiple modules without 
 * editing. Any customizations other than test cases should be noted here.
 *  
 * Instructors will have a copy of test cases.
 * 
 * @file        lab_tester.c
 * @author      upsetrobot
 * @brief       Tests assembly functions from application lab.
 * @version     1.0.1
 * @date        11 Feb 2024
 * 
 * @copyright   Copyright (c) 2024
 * 
 * @note        Not written for Windows. Maybe a future feature.
 * 
 * *****************************************************************************
 */

// Includes.
#ifdef __unix__
    #include <stdlib.h>
    #include <string.h>
    #include <errno.h>
    #include <sys/ioctl.h>
    #include <stdio.h>
    #include <unistd.h>

#elif defined(_WIN32) || defined(WIN32)
    #include <windows.h>

#endif

#include <stdio.h>


// Macros.
#define RESET   "\x1b[0m"
#define LT_RED  "\x1b[38;2;255;80;80m"
#define RED     "\x1b[91m"
#define GREEN   "\x1b[38;2;0;223;80m"

#define FUNC_FAILURE    -1
#define FUNC_SUCCESS    0

#define PASSED      1
#define FAILED      0

#define DATA_FILE   "test_data.dat"
#define FILE_SIG    0x7e57da7a7e57da7a

#define SWAP_UINT32(x) ( \
    ((x) >> 24) \
    | (((x) & 0x00FF0000) >> 8) \
    | (((x) & 0x0000FF00) << 8) \
    | ((x) << 24) \
)

#define SWAP_UINT64(x)( \
    ((x) >> 56) \
    | (((x) & 0x00FF000000000000) >> 40) \
    | (((x) & 0x0000FF0000000000) >> 24) \
    | (((x) & 0x000000FF00000000) >> 8) \
    | (((x) & 0x00000000FF000000) << 8) \
    | (((x) & 0x0000000000FF0000) << 24) \
    | (((x) & 0x000000000000FF00) << 40) \
    | ((x) << 56) \
)


// Types.
typedef unsigned long long  uint_64;
typedef signed long long  int_64;
typedef unsigned int uint;


// Structs and enums.
typedef enum Type {
    INT32,
    UINT32,
    INT64,
    UINT64,
    FLOAT32,
    FLOAT64,
    STR,
    HEX

} Type;

typedef struct Param {
    uint_64 val;
    Type type;

} Param;

typedef struct TestCase {
    uint func_id;        // Associated with studentFunction number.
    Param ret_val;
    uint args_len;
    Param args[10];

} TestCase;


// External Functions.
extern uint_64 studentFunction1();
extern uint_64 studentFunction2();
extern uint_64 studentFunction3();
extern uint_64 studentFunction4();
extern uint_64 studentFunction5();
extern uint_64 studentFunction6();
extern uint_64 studentFunction7();
extern uint_64 studentFunction8();
extern uint_64 studentFunction9();
extern uint_64 studentFunction10();


// Function Declarations.
int openTestData(char* filename, TestCase** case_arr, uint* case_arr_len);
void printParam(Param param, char* str);


// Globals.
char* functionNames[] = {
    "studentFunction1",
    "studentFunction2",
    "studentFunction3",
    "studentFunction4",
    "studentFunction5",
    "studentFunction6",
    "studentFunction7",
    "studentFunction8",
    "studentFunction9",
    "studentFunction10",
};

void* functionArray[] = {
    studentFunction1,
    studentFunction2,
    studentFunction3,
    studentFunction4,
    studentFunction5,
    studentFunction6,
    studentFunction7,
    studentFunction8,
    studentFunction9,
    studentFunction10
};


/**
 * @brief   Main function that runs tests on student assembly functions.
 * 
 * @return  int     Program status code.
 */
int main() {

    // Variables.
    int ret = EXIT_SUCCESS;
    int passed = PASSED;
    int case_num = 0;
    uint func_num = 0;
    uint case_arr_len = 0;
    Param test_ret_val = {};
    TestCase* case_arr = NULL;

    // Adjusting for terminal size.
    int cols = 0;
    char* welcome = " Welcome to the Application Tester! ";
    uint welcome_len = strlen(welcome);
    uint num_l_bar = 0;
    uint num_r_bar = 0;
    char left_bar[256] = { 0 };
    char right_bar[256] = { 0 };
    char bar[256] = { 0 };

    memset(left_bar, '=', 255);
    memset(right_bar, '=', 255);
    memset(bar, '=', 255);

    #ifdef __unix__
        struct winsize w;

        if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &w) < 0) 
            cols = 80;
            
        else
            cols = (int) w.ws_col;

        if (cols > 255)
            cols = 255;
        

    #elif defined(_WIN32) || defined(WIN32)
        CONSOLE_SCREEN_BUFFER_INFO csbi;
  
        GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi);
        cols = csbi.srWindow.Right - csbi.srWindow.Left + 1;

    #endif

    num_l_bar = (cols - welcome_len) / 2;
    num_r_bar = num_l_bar;

    if ((cols - welcome_len) % 2 == 1)
        num_r_bar++;

    left_bar[num_l_bar] = 0;
    right_bar[num_r_bar] = 0;
    bar[cols] = 0;

    // Open and parse test cases file.
    if (openTestData(DATA_FILE, &case_arr, &case_arr_len) != 0) {
        perror("Parsing failure.");

        ret = EXIT_FAILURE;
        goto err;
    }

    // Print message.
    printf("%s%s%s%s%s\n\n", LT_RED, left_bar, welcome, right_bar, RESET);
    printf("Please only use instructions covered up until this point.\n");
    printf("Testing functions...\n\n");

    // Conduct tests.
    for (uint i = 0; i < case_arr_len; i++) {
        if (func_num != case_arr[i].func_id) {
            case_num = 0;
            func_num = case_arr[i].func_id;
            printf("\n");
        }
        case_num++;    
        test_ret_val.val = ((uint_64 (*)()) functionArray[case_arr[i].func_id - 1])(
            case_arr[i].args[0].val,
            case_arr[i].args[1].val,
            case_arr[i].args[2].val,
            case_arr[i].args[3].val,
            case_arr[i].args[4].val,
            case_arr[i].args[5].val,
            case_arr[i].args[6].val,
            case_arr[i].args[7].val,
            case_arr[i].args[8].val,
            case_arr[i].args[9].val
        );

        // Check type.
        switch (case_arr[i].ret_val.type) {
            case INT32:
                test_ret_val.type = INT32;
                if ((int) test_ret_val.val != (int) case_arr[i].ret_val.val)
                    passed = FAILED;
                break;

            case UINT32:
                test_ret_val.type = UINT32;
                if ((uint) test_ret_val.val != (uint) case_arr[i].ret_val.val)
                    passed = FAILED;
                break;

            case INT64:
                test_ret_val.type = INT64;
                if ((int_64) test_ret_val.val != (int_64) case_arr[i].ret_val.val)
                    passed = FAILED;
                break;

            case UINT64:
                test_ret_val.type = UINT64;
                if (test_ret_val.val != case_arr[i].ret_val.val)
                    passed = FAILED;
                break;

            case FLOAT32:
                test_ret_val.type = FLOAT32;
                if ((float) test_ret_val.val != (float) case_arr[i].ret_val.val)
                    passed = FAILED;
                break;

            case FLOAT64:
                test_ret_val.type = FLOAT64;
                if ((double) test_ret_val.val != (double) case_arr[i].ret_val.val)
                    passed = FAILED;
                break;

            case STR:
                test_ret_val.type = STR;
                if (strcmp(
                        (char*) test_ret_val.val, 
                        (char*) case_arr[i].ret_val.val
                    ))
                    passed = FAILED;
                break;
                
            default:
                test_ret_val.type = HEX;
                if (test_ret_val.val != case_arr[i].ret_val.val)
                    passed = FAILED;

        } // End switch.

        if (passed) {
            printf(
                "\tCase %d   \t%s \t%sPASSED%s\n", 
                case_num,
                functionNames[case_arr[i].func_id - 1], 
                GREEN, 
                RESET
            );

        } else {
            printf(
                "\tCase %d   \t%s \t%sFAILED%s\n",
                case_num,
                functionNames[case_arr[i].func_id - 1], 
                RED, 
                RESET
            );
            printf("\nTest failed.\n");
            printf("Parameters:  ");

            for (uint j = 0; j < case_arr[i].args_len; j++) {
                if (j == case_arr[i].args_len - 1)
                    printParam(case_arr[i].args[j], "");

                else
                    printParam(case_arr[i].args[j], ", ");

            } // End for.

            printf("\nExpected:    ");
            printParam(case_arr[i].ret_val, "\nGot:         ");
            printParam(test_ret_val, "\n");
            passed = FAILED;
            break;

        } // End if.

    } // End for.

    // Print summary message.
    printf("\nApplication test complete.\n\n");

    if (passed)
        printf("%sCONGRATULATIONS! ALL TESTS PASSED!\n\n", GREEN);

    else
        printf("%sSorry, the test did not pass. Please try again.\n\n", RED);

    printf("%s%s%s\n", LT_RED, bar, RESET);

    err:

    // Free cases.
    if (case_arr) {
        for (uint i = 0; i < case_arr_len; i++) {
            if (case_arr[i].ret_val.type == STR && case_arr[i].ret_val.val)
                free((void*) case_arr[i].ret_val.val);

            for (uint j = 0; j < case_arr[i].args_len; j++)
                if (case_arr[i].args[j].type == STR && case_arr[i].args[j].val)
                    free((void*) case_arr[i].args[j].val);
        }
        free(case_arr);
    }

    return ret;

} // End main.



/**
 * @brief   Opens a test data file with the given filepath and attempts to 
 *          parse it. File must conform to test data file specification. 
 *          Updates `case_arr` with malloc'ed cases array and updates 
 *          `case_arr_len` with number of cases if parsing is successful.
 * 
 *          File specification:
 *              uint64  file signature 0x7e57da7a7e57da7a
 *              size_t  num_cases
 *              cases
 *                  uint_32     func_id
 *                  uint_32     num_args
 *                  uint_32     ret_val_type
 *                      If ret_val is string:
 *                          uint_32 ret_val_strlen
 *                          char[ret_val_strlen] ret_val_str
 *                      else:
 *                          uint_64 ret_val (may be int_64 or double as well)
 *                  args
 *                      uint_32     arg_type
 *                      If arg is string:
 *                          uint_32 arg_strlen
 *                          char[arg_strlen] arg_str
 *                      else:
 *                          uint_64 arg_val (may be int_64 or double as well)      
 * 
 * @param   filename        Name of file to parse.
 * @param   case_arr        Location to store pointer to cases array.
 * @param   case_arr_len    Location to store number of cases.
 * @return  int             FUNC_SUCCESS if successful or FUNC_FAILURE on 
 *                          errors (such as file not able to be parsed).
 */
int openTestData(char* filename, TestCase** case_arr, uint* case_arr_len) {

    // Variables.
    uint_64 file_sig = 0;
    uint num_cases = 0;    
    uint str_len = 0;
    size_t byte_count = 0;
    FILE* fp = NULL;
    TestCase* cases = NULL;    
    
    // Open file.
    fp = fopen(filename, "rb");
    if (fp == NULL) {
        perror("Error opening test data file.");
        goto err;
    }

    // Validate file signature.
    byte_count = fread(&file_sig, sizeof(uint_64), 1, fp);
    if (byte_count == 0) {
        perror("There was a file reading error.");
        goto errClose;
    }

    if (SWAP_UINT64(file_sig) != FILE_SIG) {
        perror("This doesn't look like my type of file.");
        goto errClose;
    }

    // Parse number of test cases.
    byte_count = fread(&num_cases, sizeof(int), 1, fp);
    if (byte_count == 0) {
        perror("There was a file reading error.");
        goto errClose;
    }

    // Allocate cases.
    cases = calloc((size_t) num_cases, sizeof(TestCase));
    if (cases == NULL) {
        perror("There was a memory allocation error.");
        goto errClose;
    }

    // Parse cases.
    for (uint i = 0; i < num_cases; i++) {

        byte_count = fread(&cases[i].func_id, sizeof(int), 1, fp);
        if (byte_count == 0)
            goto errRead;

        byte_count = fread(&cases[i].args_len, sizeof(int), 1, fp);
        if (byte_count == 0)
            goto errRead;

        byte_count = fread(&cases[i].ret_val.type, sizeof(int), 1, fp);
        if (byte_count == 0)
            goto errRead;

        if (cases[i].ret_val.type == STR) {
            byte_count = fread(&str_len, sizeof(int), 1, fp);

            cases[i].ret_val.val = (uint_64) calloc(str_len + 1, 1);
            if ((void*) cases[i].ret_val.val == NULL) {
                perror("There was a memory allocation error.");
                goto errFree;
            }

            byte_count = fread((char*) cases[i].ret_val.val, 1, str_len, fp);

        } else {
            byte_count = fread(&cases[i].ret_val.val, sizeof(uint_64), 1, fp);
            if (byte_count == 0)
                goto errRead;

        } // End if.

        // Read args.
        for (uint j = 0; j < cases[i].args_len; j++) {
            byte_count = fread(&cases[i].args[j].type, sizeof(int), 1, fp);
            if (byte_count == 0)
                goto errRead;

            if (cases[i].args[j].type == STR) {
                byte_count = fread(&str_len, sizeof(int), 1, fp);

                cases[i].args[j].val = (uint_64) calloc(str_len + 1, 1);
                if ((void*) cases[i].args[j].val == NULL) {
                    perror("There was a memory allocation error.");
                    goto errFree;
                }

                byte_count = fread((char*) cases[i].args[j].val, 1, str_len, fp);

            } else {
                byte_count = fread(&cases[i].args[j].val, sizeof(uint_64), 1, fp);
                if (byte_count == 0)
                    goto errRead;

            } // End if.

        } // End for.

    } // End for.

    *case_arr = cases;
    *case_arr_len = num_cases;
    fclose(fp);

    return FUNC_SUCCESS;

    errRead:
        perror("There was a file reading error.");

    errFree:
        if (cases) {
            for (uint i = 0; i < num_cases; i++) {
                if (cases[i].ret_val.type == STR && cases[i].ret_val.val)
                    free((void*) cases[i].ret_val.val);

                for (uint j = 0; j < cases[i].args_len; j++)
                    if (cases[i].args[j].type == STR && cases[i].args[j].val)
                        free((void*) cases[i].args[j].val);
            }
            free(cases);
        }

    errClose:
        fclose(fp);

    err:
        return FUNC_FAILURE;

} // End openTestData.



/**
 * @brief   Prints the given paramter formatted based on type followed by 
 *          optional follow-on string.
 * 
 * @param   param   Parameter with a type and value.
 * @param   str     Follow-on string to print.
 */
void printParam(Param param, char* str) {

    switch (param.type) {
        case INT32:
            printf("%d%s", (int) param.val, str);
            break;

        case UINT32:
            printf("%u%s", (uint) param.val, str);
            break;

        case INT64:
            printf("%lld%s", (long long) param.val, str);
            break;

        case UINT64:
            printf("%llu%s", param.val, str);
            break;

        case FLOAT32:
            printf("%f%s", (float) param.val, str);
            break;

        case FLOAT64:
             printf("%lf%s", (double) param.val, str);
            break;

        case STR:
            printf("%s%s", (char*) param.val, str);
            break;
            
        default:
             printf("0x%016llx%s", param.val, str);

    } // End switch.

} // End printParam.


// End of file.
