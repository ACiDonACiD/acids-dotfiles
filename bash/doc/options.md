# Functions

# INFO : Internal function's [ __intern_funcname()]

To denote a function as internal, prepend an
internal suffix( __intern_ ), functions
labeled as 'internal' can only be interacted
with when invoked using external functions.

  > intern_init_msg() { hostnamectl ;}

#  INFO : External functions [__extern_funcname()]
#
# A function denoted using the '__extern_' suffix, 
# has access to any functions defined within the same
# file. This includes functions denoted using the
# '__intern_' suffix. 

  __extern_init_msg() { __internal_init_msg ;}

  # ─────────────────────────────────────────────────────── #

  #  INFO : Functions [funcname()]
  #
  # When the program expects interactions between the 
  # user and program interface, generic functions provide
  # a simple set of rules for the user
    
      init_msg() { __extern_init_msg ;}

  # ─────────────────────────────────────────────────────── #

  #  NOTE : 
  #  Consider the following scenario detailing an
  #  internal function '__internal_foo()' which
  #  has been defined within the file 'foo.sh'
  #
  #  The '__internal_foo()' is only accessable from
  #  within the file in which it resides, preventing
  #  any external usage. An example has been 
  #  provided in the section below

```bash/bar.sh __internal_foo``` [✖] This will not work
```bash/foo.sh __internal_foo``` [✔] This will work

## Take notes

Both internal + external reside within the script and
Are not intended for use outside of this file, with
The exception being extern may be passed to other.
Scripts residing within the program itself.
