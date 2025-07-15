# AWK and Gawk: A Comprehensive Guide

AWK is a powerful text-processing language, and **GNU Awk (gawk)** is a popular free implementation. It excels at pattern-driven data extraction and reporting. This guide covers AWK from the basics to advanced features, including examples and platform notes for Linux, macOS, and Windows.

## Quick Reference

| Feature/Variable                                                       | Description 【source】                                                                          |
| :--------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------- |
| **Invocation:** `awk 'program' file...` <br> `awk -f prog.awk file...` | Run AWK with inline program or from a file.                                                   |
| **Options:** `-F fs` or `--field-separator=fs`                         | Set input field separator (`FS`) to *fs*. `-v var=val` assigns variables before execution.    |
| **FS**                                                                 | Input field separator (default is `" "` meaning any whitespace).                              |
| **OFS**                                                                | Output field separator (default `" "`).                                                       |
| **RS**                                                                 | Input record separator (default `"\n"`, newline).                                             |
| **ORS**                                                                | Output record separator (default `"\n"`).                                                     |
| **NF**                                                                 | Number of fields in the current record.                                                       |
| **\$1, \$2, ... \$NF**                                                 | Fields in current record (`$0` is the whole line).                                            |
| **FNR**                                                                | Record number in current file (resets to 1 at each new file).                                 |
| **NR**                                                                 | Total number of records seen so far across all files.                                         |
| **FILENAME**                                                           | Name of current input file (empty `""` in `BEGIN`).                                           |
| **ARGV, ARGC**                                                         | Array of command-line args and count (indexed 0…ARC-1).                                       |
| **SUBSEP**                                                             | Subscript separator for multi-dimensional arrays (default `"\034"`).                          |
| **Pattern → Action**                                                   | Basic form: `pattern { action }`. Patterns can be regex (`/foo/`), expressions, or BEGIN/END. |
| **Print:** `print`, `printf`                                           | Output record or formatted data. `print` joins fields with `OFS` and adds `ORS`.              |
| **Assignment:** `$i = val`                                             | Modify a field or built-in variable (e.g. `FS = ","` or `OFS=","`).                           |
| **redirect**                                                           | `> file` overwrite file, `>> file` append. Can redirect `print` or output of `system()`.      |
| **Close:** `close(file)`                                               | Close an output or input stream (file or pipe) to flush buffers.                              |
| **Flush:** `fflush([file])`                                            | Flush gawk’s output buffer for given file/pipe (useful for real-time pipelines).              |

## Introduction and Syntax

AWK reads input in **records** (by default, lines) and splits each record into **fields** (default separated by whitespace). A typical AWK program consists of rules:

```
pattern { action }
pattern { action }
...
```

Each *pattern* is tested against each record; if it matches, the corresponding *action* is executed. For example:

```sh
awk '/error/ { print $0 }' logfile.txt
```

This prints every line containing “error” from `logfile.txt` (pattern `/error/` is a regular expression).  If no pattern is given, the action applies to all records.  Conversely, `BEGIN{...}` and `END{...}` are special patterns that run before processing any input, or after all input is done, respectively.

### Running AWK

* Inline program: `awk 'program' file1 file2 ...`. (Quote the program to protect special characters.)
* From file: `awk -f prog.awk file1 file2 ...`.
* Variables can be assigned before execution: `awk -v var=val ...` to set `var` in the `BEGIN` phase.
* Field separator from command line: `awk -F, '...' file` sets `FS = ","`.

On **Linux**, gawk is usually the default `awk`. On **macOS**, the default `/usr/bin/awk` is the BSD variant (mostly POSIX compatible but lacks some GNU extensions); you may install GNU awk (gawk) via Homebrew or MacPorts. On **Windows**, AWK is not built-in; you can use `gawk` under environments like Cygwin/MSYS or Windows Subsystem for Linux. Note that Windows text files use `\r\n`; by default gawk under Cygwin strips `\r`. To preserve Windows CRLF endings, use the GNU extension `BINMODE=3` (e.g., `awk -v BINMODE=3 '...' file`).

## Built-In Variables

AWK provides many special variables. Key ones include:

* **FS** – Input field separator (default is a space which treats runs of spaces/tabs as one separator).  Can be a regex (e.g. `FS=","` for CSV).  Setting `FS=""` makes each character a field.
* **OFS** – Output field separator, output between fields in `print` (default `" "`).
* **RS** – Input record separator (default newline, `"\n"`). Setting `RS=""` makes records separated by blank lines, or to a regex for complex splitting.
* **ORS** – Output record separator (default `"\n"`).
* **NF** – Number of fields in the current record. Automatically set whenever AWK reads a record and splits into fields.
* **\$1, \$2, …, \$NF** – Individual fields of the current record after splitting.
* **NR** – Number of input records processed so far (cumulative across all files).
* **FNR** – Number of records processed in the current file (resets to 1 on each new file).  For example, reading two files, FNR starts over at 1 for the second file while NR keeps counting.
* **FILENAME** – Name of the current input file (`BEGIN` block: empty `""`; if reading STDIN: `"-"`).
* **ARGV, ARGC** – Array of command-line arguments and its count.  `ARGV[0]` is `awk`, `ARGV[1]` is the first filename or script, etc.  You can manipulate `ARGV` to skip files.
* **SUBSEP** – The separator between indices in a multi-dimensional array (default `"\034"` octal 034).  E.g. `arr["a","b"]` is really `arr["a\034b"]`.

**Example:** Suppose `file.txt` contains:

```
apple=red
banana=yellow
cherry=red
```

An AWK command to read key/value pairs into an array and print the value for “banana” could be:

```awk
awk -F= '{ pairs[$1] = $2 } END { print pairs["banana"] }' file.txt
```

Result: `yellow` (field separator `=` splits each line into `$1` (key) and `$2` (value)).

## Pattern-Action Structure

An AWK **rule** has the form `pattern { action }`. Common patterns include:

* Regular expressions in slashes: `/regex/` matches any record containing that pattern.
* Boolean expressions: e.g. `$3 > 100`, `$1 == "foo"`.
* Range patterns: `pat1, pat2` applies from first match of `pat1` through next match of `pat2`.
* Special patterns: `BEGIN { ... }` (before input) and `END { ... }` (after all input).

If the pattern is omitted, action applies to every record. If action is omitted, the default is `print $0`. Actions can contain any AWK statements, e.g. `print`, `next`, `if`, loops, variable assignments, function calls, etc.

**Example:** Print second field of lines matching “error”:

```awk
awk '/error/ { print $2 }' logfile.txt
```

## Field and Record Separators

By default, AWK splits each input record (line) into fields using `FS` (input field separator). Commonly, `FS=","` for CSV data.  You can also set `FS` in a `BEGIN` block:

```awk
awk 'BEGIN { FS = "," } { print $1, $3 }' data.csv
```

For more advanced CSV parsing (handling quoted fields), GNU Awk offers `FPAT` (Field PATtern) which defines a regex for fields. For example:

```awk
BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" }
{ print $1, $2, $3 }
```

This will correctly treat commas inside quotes as part of a field. The gawk manual shows an example CSV parser using `FPAT`.

The record separator `RS` defines how records are split. Default `RS="\n"` (each line). If `RS=""`, records are paragraphs (separated by blank lines). You can also make `RS` a regex. The gawk manual notes that `RT` (a gawk extension) captures the text matching `RS`.

## Built-In Functions

### String Functions

* **`length(str)`** – Number of characters in *str* (or number of elements if str is an array in gawk). If no argument, returns `length($0)`.
* **`index(str, search)`** – Returns starting position of *search* in *str*, or 0 if not found. Example: `index("peanut","nut")` yields 4.
* **`substr(str, start [, len])`** – Extract substring of length *len* from *str* starting at *start* (1-based). E.g. `substr("abcdef", 2, 3)` → `"bcd"`.
* **`split(str, array, sep)`** – Splits *str* by *sep* (regex) into array, returns number of fields. By default splits on `FS`.
* **`match(str, regex [, arr])`** – Searches *str* for longest match of *regex*. Returns index where it begins (1-based), or 0 if none. Sets built-ins `RSTART` and `RLENGTH` to the match’s position and length. If an array *arr* is given, subexpressions are stored in `arr[1]`, `arr[2]`, etc.
* **`sub(regex, repl, target)`** – Replaces the first match of *regex* in *target* with *repl*; default target is `$0`. Returns 1 if replaced. Uses `&` and `\1` for matched text and groups.
* **`gsub(regex, repl, target)`** – Replaces **all** non-overlapping matches of *regex* in *target* with *repl*. Returns number of replacements. Example:

  ```awk
  { gsub(/foo/, "bar"); print }
  ```

  replaces every “foo” with “bar” in each line.
* **`toupper(str)`**, **`tolower(str)`** – Return an upper-/lowercase copy of *str*. E.g. `toupper("AbC")` → `"ABC"`.
* **`sprintf(fmt, …)`**, **`printf fmt, …`** – Format printing (C-style). `printf` goes to output (no automatic `ORS`).
* **`strtonum(str)`** – Convert string to number (handles scientific notation, hex, etc).
* **`asort(array [, dest])` / `asorti(array [, dest])`** – gawk extensions to sort array by values or indices (example shown in gawk manual).

### Math Functions

AWK provides standard math functions (arguments in radians, or natural log):

* `sqrt(x)` – square root.
* `sin(x)`, `cos(x)`, `atan2(y,x)` – trigonometry.
* `exp(x)` – *e^x* (exponential).
* `log(x)` – natural log (ln).
* `int(x)` – integer part of x (truncated toward 0).
* `rand()` – random number in \[0,1).
* `srand([x])` – seed random number generator. With no argument, uses current time (see **Caution** below). Returns previous seed.

  > *Caution:* By default `rand()` in AWK produces the same sequence each run. Use `srand()` once (e.g. in `BEGIN`) to get different results.

Example: Generate a random integer 1–6:

```awk
BEGIN { srand(); }
{ roll = 1 + int(rand()*6); print roll }
```

This simulates a die roll.

## User-Defined Functions

You can define functions to reuse code. Syntax:

```awk
function fname(param1, param2, ..., local1, local2) {
    # body: statements
    return value    # optional
}
```

* Function and parameter names follow the same rules as variables (letters, digits, underscore, not starting with digit).
* **Arguments:** When calling `fname(a,b)`, the values are assigned to `param1`, `param2` (passed by value).  **Arrays** passed to functions are passed by reference (i.e., the function can modify the array); simple scalars (numbers/strings) are by value.
* **Locals:** Any names in the parameter list beyond the supplied arguments act as local variables.
* **Return:** Use `return expr` to return a value. If omitted, return the value of the last expression (or 0/empty).

Example:

```awk
# Function to add two numbers
function add(x, y) {
    return x + y
}
{ print "Sum:", add($1, $2) }
```

This prints “Sum:” and the sum of fields 1 and 2 for each record.

#### Simulating Keyword Arguments

AWK does not have built-in “keyword” arguments. However, you can simulate them by passing an associative array of options:

```awk
function process(opts) {
    if ("mode" in opts) mode = opts["mode"]
    else mode = "default"
    # ...
    print "Mode is", mode
}

BEGIN {
    opts["mode"] = "fast"
    process(opts)
}
```

Here `opts["mode"]="fast"` acts like a named parameter. The function checks the presence of keys in the array to determine behavior.

## Associative Arrays

AWK’s arrays are associative (indexed by **string**). You do *not* predeclare or size them. For example:

```awk
{ count[$1]++ } 
END { for (item in count) print item, count[item] }
```

This counts occurrences of the first field. Common idiom: `a[$key]++` counts keys.  To clear an array: `delete a[key]` or `delete a`.

For multi-dimensional behavior, use multiple indices (which gawk concatenates with `SUBSEP`): e.g. `sales[year,month] = total`. Under the hood, `SUBSEP` separates the two keys.

To iterate in sorted order (GNU extension), use `PROCINFO["sorted_in"]`. Or use `asort()`/`asorti()`. In gawk, `length(arr)` returns the number of elements in *arr* (other AWKs may not support this).

## File I/O and Redirection

AWK can read from and write to files beyond the input records:

* **Reading from file:** `getline < "file"` reads the next line from *file* into `$0` (splitting fields, setting `NF` etc). This does *not* advance the main input; `NR`/`FNR` stay the same. Example:

  ```awk
  # When field $1 == 10, read one line from secondary.input
  $1 == 10 {
      if (getline < "secondary.input" > 0)
          print "Read from secondary:", $0
  }
  ```

  (After this `getline`, fields `$i` change to what was read.)

* **Reading from command (pipe):** `command | getline var` runs *command* and reads one line from its output into `var` (or into `$0` if `var` omitted). Repeat to read more lines. Always `close(cmd)` after finishing to reset it. Example from the gawk manual:

  ```awk
  # Replace lines beginning with "@exec" by output of the shell command following it
  {
    if ($1 == "@exec") {
      cmd = substr($0, 7)          # remove "@exec "
      while ((cmd | getline) > 0)  # read each line of command output
          print
      close(cmd)
    } else {
      print
    }
  }
  ```

  (This runs `cmd` each time and prints its result.)

* **Writing (redirect):** Use `print >> "file"` to append or `print > "file"` to overwrite (on first use, `>` creates file; subsequent `>` reopens/truncates). E.g.:

  ```awk
  { print $0 > "out.txt" }  # writes every record to out.txt (truncated once)
  ```

  Use `close("out.txt")` when done writing to flush and release the handle.

* **Two-way pipes (gawk):** Gawk supports `|&` for bidirectional coprocess. E.g. `cmd |& getline` reads from a coprocess, and `print |& cmd` writes to it (after doing `cmd = "|sort"` and `cmd |& getline`). Closing with `close(cmd)` is important.

## Regular Expressions

AWK uses POSIX extended regular expressions. A regex literal is written between slashes and is treated as a pattern. Examples:

* `/foo/` matches any record containing “foo” (as substring).
* `/^Error:/` matches lines starting with “Error:”.
* `$0 ~ /regex/` tests if current record matches.
* `$1 ~ /[0-9]+/` tests first field has digits.

Regex features: `.` matches any character, `* + ? {m,n}` for repetition, `^ $` for anchors, `[...]` for character classes, `()` for grouping (in `gensub`, subexpressions `\1` etc). AWK also supports `~` (match) and `!~` (not match) operators:

```awk
$5 !~ /done/ { print "Not done:", $0 }
```

Character classes and escape sequences follow typical regex rules. To match a literal slash, escape it (`\/`). To match a backslash, escape as `\\`.

Example – extract email addresses using regex:

```awk
/^[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}$/ {
    print "Email:", $0
}
```

Gawk extensions (not in all AWKs):

* **Ignore case:** `IGNORECASE=1` (all matches/cases insensitive).
* **`gensub()`**: like `sub`/`gsub` but returns modified string without altering original. Supports `\1` syntax for submatches (example in gawk manual).
* **`PROCINFO["re_match_mode"]`**: advanced mode for regex (rarely needed).

## Performance Tips

* **Minimize external calls:** Avoid calling shell commands or `system()` inside per-line processing if possible. Pipes with `getline` or filtering before AWK can help.
* **Use `next`:** If you match a pattern and are done with that record, use `next` to skip remaining rules. This prevents unnecessary work.
* **Bulk operations:** Writing many `print` statements can be slow due to I/O. Buffer output in strings or arrays and print in one go when possible. Use `>>` vs multiple writes carefully.
* **Close files:** After writing to many files, use `close()` to free file descriptors (also flushes output).
* **Use built-ins wisely:** Frequent regex matching or function calls inside loops can be costlier. In tight loops, it may pay to precompute or simplify expressions.
* **Choose implementation:** For large data, `mawk` or `nawk` may run faster than gawk (though they lack some extensions). Consider gawk for features, or mawk for speed on simple tasks.

## Examples

### Parsing Key-Value Config Files

AWK easily parses `key=value` config lines. For instance, given a file `settings.conf`:

```
host=example.com
port=8080
mode=production
```

You can load it into variables or an array. Example using an associative array:

```awk
awk -F= '
$0 ~ /^[^#]/ && $1 != "" {
    config[$1] = $2
}
END {
    print "Host:", config["host"]
    print "Port:", config["port"]
}
' settings.conf
```

This skips blank/comment lines and splits on `=`. The gawk manual similarly uses `-F=` to parse environment-like key/value pairs:

```sh
env | awk -F= '{ a[$1] = $2 } END { print a["EDITOR"] }'
```

(grep removed spaces in original example.)

### Processing CSV Data

For simple CSV (no embedded commas/quotes):

```awk
BEGIN { FS=","; OFS=" | " }
NR>1 {    # skip header
    print $1, $3, $5
}
```

For complex CSV with quoted fields, use gawk’s `FPAT`. Example (fields are either unquoted text or quoted text with commas):

```awk
BEGIN {
    FPAT = "([^,]+)|(\"[^\"]+\")"
}
{
    # Remove quotes for printing (optional)
    for (i = 1; i <= NF; i++) {
        gsub(/"/, "", $i)
    }
    print $1, $2, $3
}
```

This handles a line like `John,"Doe, Jane",28` correctly. The gawk guide demonstrates using `FPAT` to split CSV fields.

### Extracting from Log Files

AWK is great for logs. For example, an NGINX access log (combined format):

```awk
# access.log: ip - user [date] "req" status bytes ...
{
    ip = $1
    time = substr($4, 2)    # remove leading '['
    url = $7
    status = $9
    print ip, time, url, status
}
```

To count requests by status code:

```sh
awk '{ print $9 }' access.log | sort | uniq -c | sort -rn
```

As shown in a blog, `awk '{print $9}' access.log` prints the HTTP status, then `sort|uniq` tallies them. Or do it in pure AWK:

```awk
{ codes[$9]++ }
END { for (c in codes) print codes[c], c }
```

Filtering lines matching a pattern (e.g., “ERROR”) is trivial:

```awk
/ERROR/ { print strftime("%Y-%m-%d %H:%M:%S"), $0 }
```

This example prepends a timestamp to error lines. Use `IGNORECASE=1` if case-insensitive.

### Generating Makefile Dependencies

AWK can process `#include` directives to build dependency lists. Example for C files:

```awk
{
    if (match($0, /^#include[ \t]*"([^"]+)"/, arr)) {
        fname = arr[1]
        print FILENAME ": " fname
    }
}
```

Run on multiple `.c` files:

```sh
awk -f deps.awk *.c > dependencies.d
```

Each line becomes `file.c: header.h`.  (Be careful with <> includes or use regex for angle brackets.)  This output can be included in a Makefile to track header dependencies.

### String Processing and Regex Tasks

* **Trim whitespace:** Remove leading/trailing spaces:

  ```awk
  {
      gsub(/^[ \t]+|[ \t]+$/, "")
      print
  }
  ```
* **Replace text:** Swap “foo” and “bar” globally:

  ```awk
  { gsub(/foo/, "bar"); print }
  ```
* **Case conversion:** `awk '{ print toupper($0) }'` converts all text to uppercase.
* **Field splitting by regex:** Use `split()` to break strings. E.g., split a URL:

  ```awk
  { n = split($0, parts, "/"); print parts[3] }   # prints domain from a URL
  ```
* **Field formatting:** Using `printf` for alignment or zero-padding:

  ```awk
  { printf("%-10s %5d\n", $1, $2) }
  ```

These examples show how AWK’s regex and functions can be used for common text-manipulation tasks.

## Built-in Variables (Summary)

* **ARGC, ARGV:** Command-line args count and array.
* **ENVIRON:** (gawk) associative array of environment variables.
* **RSTART, RLENGTH:** After `match()`, `RSTART` is start index and `RLENGTH` the length of matched substring.
* **SUBSEP:** Separator for array subscripts (see above).
* **CONVFMT, OFMT:** Format for number→string conversion (`printf` default). Not often needed except for precision control.
* **BINMODE:** (gawk) Binary I/O mode (e.g. `-v BINMODE=3` on Windows to preserve CRLF).

## Glossary

* **Field (FS):** A piece of a record (column) after splitting by `FS`. Referenced as `$1`, `$2`, ... `$NF`.
* **Record:** By default, a line of input (changed by `RS`). Referred to as `$0`.
* **Pattern:** A condition (regex or expression) to match records.
* **Action:** Code block to execute when a pattern matches.

## Further Reading

For in-depth details, see the GNU Awk User’s Guide (especially *Patterns, Actions, and Variables*, *Built-in Functions*, and *Regular Expressions* chapters). This guide has covered AWK features from beginner to advanced, with practical examples. Saving this as `README.md` or printing to PDF will provide an offline reference.
