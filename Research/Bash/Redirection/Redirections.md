# Bash Redirection: The Basics

A Bash script is commonly a set of commands. Every command in Bash interacts
with **three standard file descriptors** by default:

* `0` — Standard Input (stdin)
* `1` — Standard Output (stdout)
* `2` — Standard Error (stderr)

---

## 📚 Table of Contents

1. [File Descriptor]("#file-descriptors")
2. [Redirection Operators](#redirection-operators)
3. [Output Redirection](#output-redirection)
4. [Input Redirection](#input-redirection)
5. [Error Redirection](#error-redirection)
6. [Redirecting Both stdout and stderr](#redirecting-both-stdout-and-stderr)
7. [Appending Output](#appending-output)
8. [Piping vs. Redirection](#piping-vs-redirection)
9. [Useful Examples](#useful-examples)
10. [References](#references)

---

## 🧩 File Descriptors

### Bash Redirection Fun With Descriptors

| FD | Name       | Description                       |
| -- | ---------- | --------------------------------- |
| 0  | **stdin**  | Input taken from keyboard or file |
| 1  | **stdout** | Normal output stream              |
| 2  | **stderr** | Error output stream               |

---

## 🔁 Redirection Operators

```bash
< input   # Redirect standard input (fd 0)
> output  # Redirect standard output (fd 1)
2> error  # Redirect standard error (fd 2)
```

You can also use:

* `>>` → append instead of overwrite
* `&>` → redirect both stdout and stderr

---

## 🖨 Output Redirection

Redirect stdout to a file:

```bash
echo "hello world" > foo.txt
```

Equivalent to:

```bash
echo "hello world" 1> foo.txt
```

---

## 📥 Input Redirection

Redirect a file as the input to a command:

```bash
wc -l < foo.txt
```

This counts the lines of `foo.txt` by redirecting it to the standard input of `wc`.

---

## ❌ Error Redirection

Redirect standard error to a file:

```bash
command 2> error.log
```

Useful when you want to capture only the errors from a command.

---

## 🔄 Redirecting Both stdout and stderr

Redirect both stdout and stderr to the same file:

```bash
command &> all_output.log
```

Or redirect them separately:

```bash
command > out.log 2> err.log
```

---

## ➕ Appending Output

To append instead of overwrite:

```bash
echo "more data" >> output.txt
```

Or append both stdout and stderr:

```bash
command >> output.log 2>&1
```

---

## 🔗 Piping vs. Redirection

* **Redirection** saves output to a file.
* **Piping** sends output from one command as input to another.

Example of piping:

```bash
cat file.txt | grep "pattern"
```

Equivalent redirection form:

```bash
grep "pattern" < file.txt
```

---

## ✅ Useful Examples

Redirect errors to null:

```bash
command 2>/dev/null
```

Log everything:

```bash
command > out.log 2>&1
```

Use file as input:

```bash
read line < file.txt
```

---

## 📚 References

* [Bash Redirection Fun With Descriptors](https://copyconstruct.medium.com/bash-redirection-fun-with-descriptors-e799ec5a3c16)
* `man bash` – see the **REDIRECTION** section
* [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/io-redirection.html)
