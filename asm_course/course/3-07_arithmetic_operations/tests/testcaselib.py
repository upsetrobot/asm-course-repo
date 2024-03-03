
"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

Test Case Generator Library for use by `test_case_generator.py`. 

This file is NOT module specific (the same copy is in all modules).

File:       testcaselib.py
Author:     upsetrobot
Brief:      Provides test case classes and functionality for translating 
            test case info into a data file that is to be parsed by the 
            `application_test.c` program.
Version:    1.0.1
Date:       11 Feb 2024

Copyright:  Copyright (c) 2024


TODO:   Fix bytes versus str with .encode.
TODO:   Fix being able to take empty string. Decide on termination.

"""

## Standard libraries.
import struct
import pathlib as pl

## Other libraries.
# None.

## Local libraries.
# None.

## Global constants.
INT32 = 0
UINT32 = 1
INT64 = 2
UINT64 = 3
FLOAT32 = 4
FLOAT64 = 5
STR = 6
HEX = 7

## Global variables.
# None.

## Classes.
# Error classes.
class CaseArgTypeError(TypeError):
    """Error when argument type is not `str`, `bytes`, `int`, or `float`.
    """


# Other classes.
class CaseArg:
    """Class for allowing type discovery of arguments and return value.
    """

    ## Constructors.
    def __init__(self, value, value_type=None):


        self.value_type = value_type
        self.value = value


    ## Getters and Setters.
    @property
    def value_type(self) -> int | None:

        return self._value_type

    @value_type.setter
    def value_type(self, value_type):

        if value_type is not None and not isinstance(value_type, int):
            raise TypeError(
                "Value type must have type `int`; had type "
                f"`{type(value_type)}`.\n"
                "Value type may be: \n"
                "    `0`: INT32\n"
                "    `1`: UINT32\n"
                "    `2`: INT64\n"
                "    `3`: UINT64\n"
                "    `4`: FLOAT32\n"
                "    `5`: FLOAT64\n"
                "    `6`: STR\n"
                "    `7`: HEX"
            )

        self._value_type = value_type


    @property
    def value(self) -> int | float | str | bytes:

        return self._value

    @value.setter
    def value(self, value):

        # Attempt to determine type by type defined.
        if self.value_type is not None:
            if self.value_type == INT32 \
                    or self.value_type == INT64 \
                    or self.value_type == UINT32 \
                    or self.value_type == UINT64 \
                    or self.value_type == HEX:
                if not isinstance(value, int):
                    raise CaseArgTypeError(
                        "Type is not compatible with assigned value type. "
                        "Type required is `int`. Type given was "
                        f"`{type(value)}`."
                    )
                
                if (self.value_type == UINT32 or self.value_type == UINT64) \
                        and value < 0:
                    raise CaseArgTypeError(
                        "Value is not compatible with assigned value type. "
                        "UINT32 and UINT64 types cannot assign negative "
                        f"values. Value given was `{value}`."
                    )

            elif self.value_type == FLOAT32 or self.value_type == FLOAT64:
                if not isinstance(value, float):
                    raise CaseArgTypeError(
                        "Type is not compatible with assigned value type. "
                        "Type required is `float`; type given was "
                        f"`{type(value)}`."
                    )

            elif self.value_type == STR:
                if not (isinstance(value, str) or isinstance(value, bytes)):
                    raise CaseArgTypeError(
                        "Type is not compatible with assigned value type. "
                        "Type required is `str`. Type given was "
                        f"`{type(value)}`."
                    )

            else:
                pass

        # Assign type based on given value.
        else:
            if isinstance(value, int):
                if value < 0:
                    self._value_type = INT64

                else:
                    self._value_type = UINT64

            elif isinstance(value, float):
                self._value_type = FLOAT64

            elif isinstance(value, str) or isinstance(value, bytes):
                self._value_type = STR

            else:
                raise CaseArgTypeError(
                    "Type is not compatible with assigned value type. "
                    "Type required is `str`, `int`, or `float`. Type given "
                    f"was `{type(value)}`."
                )

        self._value = value


    ## Strings methods.
    def __str__(self) -> str:
        """Returns string representation of test case list.

        Returns:
            str: String representation of test case list.
        """

        return self.__repr__()


    def __repr__(self) -> str:
        """Returns string representation of test case list.

        Returns:
            str: String representation of test case list.
        """

        return str(vars(self))


    ## Dict methods.
    # None.


    ## Methods.
    # None. 


class Case:
    """Test case class.
    """

    ## Constructors.
    def __init__(
            self, 
            func_id: int, 
            ret_val: CaseArg | int | float | str | bytes,
            ret_val_type: int | None = None,
            args: tuple | None = None
        ):
        """Constructor for test case.

        Args:
            ret_val:    Expected return value for function.
            args:       Arguments to pass to function.
        """

        self.func_id = func_id
        
        if isinstance(ret_val, CaseArg) and ret_val_type is not None:
            raise ValueError(
                "If `ret_val` has `CaseArg` type, `ret_val_type` must be "
                "`None` as type is defined in `CaseArg`."
            )

        if not isinstance(ret_val, CaseArg):
            ret_val = CaseArg(ret_val, ret_val_type)

        self.ret_val = ret_val
        self.args = args


    ## Getters and setters.
    @property
    def func_id(self):

        return self._func_id

    @func_id.setter
    def func_id(self, func_id: int):

        if not isinstance(func_id, int):
            raise TypeError(
                f"`func_id` must have `int` type; had {type(func_id)} type."
            )

        if func_id < 1 or func_id > 10:
            raise ValueError("`func_id` must be in the range from 1 to 10.")

        self._func_id = func_id


    @property
    def ret_val(self) -> CaseArg:

        return self._ret_val

    @ret_val.setter
    def ret_val(self, ret_val: str | int | float):

        if not (isinstance(ret_val, int) \
                or isinstance(ret_val, float) \
                or isinstance(ret_val, str) \
                or isinstance(ret_val, bytes) \
                or isinstance(ret_val, CaseArg)):
            raise TypeError(
                "`ret_val` must have `int`, `float`, `str`, `bytes`, or "
                f"`CaseArg` type; had `{type(ret_val)}` type."
            )

        if not isinstance(ret_val, CaseArg):
            ret_val = CaseArg(ret_val, self.ret_val.value_type)

        self._ret_val = ret_val


    @property
    def args(self) -> tuple:

        return self._args

    @args.setter
    def args(self, args: tuple):

        if args is None:
            args = ()

        if not isinstance(args, tuple):
            args = tuple(args)

        args_copy = []

        for i in args:
            if not isinstance(i, CaseArg):
                args_copy.append(CaseArg(i))

            else:
                args_copy.append(i)

        self._args = tuple(args_copy)


    ## Strings methods.
    def __str__(self) -> str:
        """Returns string representation of test case.

        Returns:
            str: String representation of test case.
        """

        return self.__repr__()


    def __repr__(self) -> str:
        """Returns string representation of test case.

        Returns:
            str: String representation of test case.
        """

        return str(vars(self))

    
    def _bytes(self) -> bytes:
        """Returns binary string representation of test case.

        Returns:
            bytearray: Binary string representation of test case.
        """

        ret = b''

        # Function ID.
        ret += struct.pack("<I", self.func_id)
        ret += struct.pack("<I", len(self.args))

        # Return value.
        ret += struct.pack("<I", self.ret_val.value_type)

        if self.ret_val.value_type == STR:
            ret += struct.pack("<I", len(self.ret_val.value))
            if isinstance(self.ret_val.value, str):
                ret += self.ret_val.value.encode()
            
            else:
                ret += self.ret_val.value

        elif self.ret_val.value_type == FLOAT32:
            ret += struct.pack("<fI", self.ret_val.value, 0)

        elif self.ret_val.value_type == FLOAT64:
            ret += struct.pack("<d", self.ret_val.value)

        elif self.ret_val.value_type == INT32:
            if self.ret_val.value < 0:
                ret += struct.pack("<ii", self.ret_val.value, -1)

            else:
                ret += struct.pack("<iI", self.ret_val.value, 0)

        elif self.ret_val.value_type == INT64:
            ret += struct.pack("<q", self.ret_val.value)

        elif self.ret_val.value_type == UINT32:
            ret += struct.pack("<II", self.ret_val.value, 0)

        elif self.ret_val.value_type == UINT64 or self.ret_val.value_type == HEX:
            ret += struct.pack("<Q", self.ret_val.value)
            
        else:
            ret += struct.pack("<Q", self.ret_val.value)
        
        # Arguments.
        for i in self.args:
            ret += struct.pack("<I", i.value_type)

            if i.value_type == STR:
                ret += struct.pack("<I", len(i.value))
                if isinstance(i.value, str):
                    ret += i.value.encode()
                
                else:
                    ret += i.value

            elif i.value_type == FLOAT32:
                ret += struct.pack("<fI", i.value, 0)

            elif i.value_type == FLOAT64:
                ret += struct.pack("<d", i.value)

            elif i.value_type == INT32:
                if i.value < 0:
                    ret += struct.pack("<ii", i.value, -1)

                else:
                    ret += struct.pack("<iI", i.value, 0)

            elif i.value_type == INT64:
                ret += struct.pack("<q", i.value)

            elif i.value_type == UINT32:
                ret += struct.pack("<II", i.value, 0)

            elif i.value_type == UINT64 or i.value_type == HEX:
                ret += struct.pack("<Q", i.value)
                
            else:
                ret += struct.pack("<Q", self.ret_val.value)

        return ret


    ## Dict methods.
    # None.


    ## Methods.
    # None.


class CaseList:
    """Test case list class.
    """

    ## Constructors.
    def __init__(self):
        """Constructor for test case list.
        """

        self.cases: list[Case] = list()


    ## Getters and setters.
    # None.


    ## Strings methods.
    def __str__(self) -> str:
        """Returns string representation of test case list.

        Returns:
            str: String representation of test case list.
        """

        return self.__repr__()


    def __repr__(self) -> str:
        """Returns string representation of test case list.

        Returns:
            str: String representation of test case list.
        """

        return str(vars(self))


    ## Dict methods.
    # None.


    ## Methods.
    def add(self, func_id, ret_val = 0, ret_val_type = None, args = None):
        """Adds a new test case with the given return value and arguments to 
        the test case list.

        Args:
            ret_val:    Expected return value for function.
            args:       Arguments to pass to function.
        """

        self.cases.append(Case(func_id, ret_val, ret_val_type, args))


    def generate_data_file(self, filename: str):
        """Generates a binary file with test case information in it for a 
        application testing program to use.

        Args:
            filename (str):     Filename of new test data file to generate.
        """

        path = pl.Path.cwd()
        path = path.joinpath(filename)

        with open(path, 'wb') as f:

            # File signature.
            f.write(struct.pack(">Q", 0x7e57da7a7e57da7a))

            # Test cases.
            f.write(struct.pack("<I", len(self.cases)))

            self.cases.sort(key=lambda x : x.func_id)

            for i in self.cases:
                f.write(i._bytes())


## Static functions.
# None.


## Helper functions.
# None.


## Tests.
# None.


## Scripts.
if __name__ == '__main__':
    print("This module provides test case classes and is meant to be",
          "imported. It does not have any functionality being run.")


# End of file.
