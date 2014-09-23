# Linux Fundamental Concepts

## The Kernel

* Why do we need a kernel?

## The Kernel

* Why do we need a kernel?

    * Increases the **power** and **flexibility**
    * Provides a **SW layer** to managed the limited resources

## Kernel's Tasks

* **Process Scheduling**: Linux is a *preemptive multitasking*: multiple process residing in 
memory (RAM) where the scheduler decides which one to execute and its duration
* **Memory Management**: Provides *Virtual Memory Management*:
    * Process are isolated, so one process can not read or modify memory from other process
    * Only one part of the process needs to be in memory
* Provision of a **file system**
* Creation and termination of processes
* Access to devices
* Networking
* Provision of a system call application programming interface (API): Processes can request
the kernel to perform various tasks using kernel entry points known as **system calls**
* **Multiuser**: virtual private computer

## Kernel mode and user mode (1)

* Processor Architectures can operate in two modes: **user mode** and **kernel mode**
* HW instructions allows switching from one to the other
* Areas of the virtual memory can be marked as being part of **user space** or **kernel
space**

## Kernel mode and user mode (2)

* When CPU runs in user mode, it can access only memory marked as being in user space
* When CPU runs in kernel mode, it can access both user and kernel memory space

## The Shell

* Special-purpose program designed to read commands typed by a user and execute appropriate programs
in response to those commands. Commonly known as **command interpreter**
* **login shell** is the process that is created to run a shell when the user first logs in
* The shell is a user process. Important shells:
    * `Bourne shell (sh)`
    * `C shell (csh)`
    * `Korn shell (ksh)`
    * `Bourne again shell (bash)`: this shell is the GNU project's reimplementation of the Bourne shell.
    It is probably the most widely used shell on Linux

## Shell scripts

* Text files containing shell commands

~~~~{.bash}
#!/bin/bash
# fatal --- print an error message and die:

fatal () {
    # Messages go to standard error.
    echo "$0: fatal error:" "$@" >&2
    exit 1
}
…
if [ $# = 0 ]    # not enough arguments
then
    fatal not enough arguments
fi
~~~~

## Users

* Each user on the system is uniquely identified, and users may belong to groups
* A user has
    * `user ID (UID)`
    * `Group ID (GID)`
    * `Home directory`
    * `Login shell`
* All the above info can be located at `/etc/passwd`

## Groups

* Groups are useful for administrative purposes --in particular, for controlling access to files and other system resources--
* A group has
    * `Group name`
    * `Group ID (GID)`
    * `User list`
* Group's info is located at `/etc/group`

## Superuser

* The **superuser** has special privileges within the system
* `ID 0` and login name `root`
* **Bypasses all permission** checks in the system


## Single Directory Hierarchy, Directories, Links and Files (1)

* The kernel maintains a single hierarchical directory structure to organize all files in the system
* Linux needs a filesystem to work correctly
* On OS like Microsoft Windows, each disk device has its own directory hierarchy
* **Root directory** named `/` (slash)

![](http://www.safaribooksonline.com/library/view/the-linux-programming/9781593272203/figs/web/02-1_CONCEPTS-file-system.png.jpg)

## Single Directory Hierarchy, Directories, Links and Files (2)

* **File Types**: regular or plain, devices, pipes, sockets, directories and symbolic
links files
* **Directory** special file whose contents take the form of a table of filenames and 
references to the corresponding files. This filename-plus-reference association is called
a *link*, so many files can have multiple names
* `.` (dot) is a link to the directory itself
* `..` (dot-dot) is a link to the *parent directory*

## Single Directory Hierarchy, Directories, Links and Files (3)

* **Symbolic link** provides an alternative name for a file
* **Filenames** up to 255 characters long
* **Pathnames** optional initial slash (/) followed by a series of filenames separated
by slashes
    * **Absolute pathname** begins with a slash (`/home/mtk/.bashrc`)
    * **Relative pathname** location of a file relative to a process's current
      working directory

## Single Directory Hierarchy, Directories, Links and Files (4)

* Each file has an associated user ID, group ID that define the owner and the
group
* For the purpose of accessing a file, system divides users into three categories:
    * The **owner** of the file
    * The users who are members of the **group**
    * The rest of the world **other**

* Three permissions bits may be set for each of these categories: _read_, _write_ and
_execute_
* Shell command `chown` to change ownership
* Shell command `chmod` to change permissions


## File I/O Model

* The same system calls (`open()`, `read()`, `write()`, `close()`, and so on) are used to 
perform I/O on all types of files, including **devices**
* **File descriptors** represent open files, a nonnegative integer
* A process inherits three open file descriptors when it is started by the shell:
    * Descriptor `0` is **standard input**, the file from which the process takes its input
    * Descriptor `1` is **standard output**, the file to which the process writes its output
    * Descriptor `2` is **standard error**, the file to which the process writes error messages and 
      notifications of exceptional or abnormal conditions


## The `stdio` library

* To perform file I/O, C programs typically employ I/O functions contained in the standard C library
* Includes `fopen()`, `fclose()`, `scanf()`, `printf()`, `fgets()`, `fputs()`, and so on.
* Wrap the I/O System calls (`open()`, `read()`, `write()`, `close()`, ..)

## Programs

* Normally exist in two forms: **source code**, human-readable text consisting of a series of statements
* To be useful, the source code must be converted to a second form: **binary machine-language** instructions
* A **script** is a text file containing commands to be directly processed by a program (shell or other commnand
  interpreter)

## Filters

* Type of programs that reads its input from `stdin`, performs some transformation of this data, and writes
  to `stdout`: `cat`, `grep`, `tr`, `sort`, `wc`, `sed` and `awk`

~~~~{.bash}
$: cat /etc/passwd | grep $USER
~~~~

## Command-line arguments

* Words that are supplied on the command line when a program is run

~~~~{.c}
int main(int argc, char *argv[])
~~~~

* `argc` contains the total number of command-line arguments
* `argv` arguments as strings pointed to by members of `argv`
* `argv[0]` is the name of the program itself

## Processes

* Instance of an executing program
* When a program is executed, the kernel loads the code of the program into virtual memory,
  allocates space for program variables and sets up kernel bookkeeping data structures to
  record various information (process ID, termination status, user IDs, group IDs) about
  the process

## Process memory layout

* Logically divided into the following parts, known as **segments**:
    * **Text**: instructions
    * **Data**: static variables
    * **Heap**: area from which programs can dynamically allocate extra memory
    * **Stack**: piece of memory that grows and shrinks as functions are called and return, used to
      allocate storage for local variables and function call linkage information

## Process creating and program execution

* A process can create a new process using the `fork()` system call
* _Parent process_ is the one that calls `fork()` and the new process is referred to as the `child process`
* The child is a duplicate of the parent (the program text is shared but the two processes)
* The child can execute the same parent's code or use the `execve()` system call to load and execute
  an entirely new program.
* An `execve()` call destroys the existing text, data, stack and heap segments, replacing them with the new segments

## The `init` process

* When booting, the kernel creates a special process called `init`, the _parent of all processes_, derived from the program
`/sbin/init`
* All process on the system are created either by `init` or by one of its descendats
* Process ID `1`

## Daemon processes

* A special-purpose process that is created and handled by the system
    * it is long-lived
    * runs on the background, no controlling terminal

## Static and Shared Libraries

* An _object library_ is a file containing the compiled object code for a set of functions that may be called from
  applications programs
* Two types of object libraries:
    * **Static** : the linker extract copies of the required object modules from the library and copies into the resulting executable
    * **Shared** : the necessary libraries are loaded into memory by the _dynamic linker_, and performs run-time linking

## Interprocess Communication and Synchronization

* Most processes operate independently of each other
* Some processes need to cooperate to archive their intended purposes, so there is a need
  for methods of communicating with one other and synchronizing their actions
* _InterProcess Communication (IPC)_ methods:
    * _signals_ used to indicate that an event has ocurred
    * _pipes_ (familiar to shell users as the `|` operator) and _FIFOs_
    * _sockets_ used to transfer data from one process to another, either on the same host or on different ones connected by a network
    * _file locking_
    * _message queues_ used to exchange messages (packets of data) between processes
    * _semaphores_ used to synchronize the actions of processes
    * _shared memory_ allows two or more processes to share a piece of memory

## Threads

* A process can have multiple _threads_ of execution
* Share the same virtual memory (data area and heap) but each thread has its own stack
* _Condition variables_ and _mutexes_ are primitives that enable the threads of a process to communicate and syncronize
* Some process transpose more naturally to a multithreaded implementation than to a multiprocess implementation

## Date and Time

* _Real time_ is measured either from some standard point (_calendar_ time, measured in seconds since midnight of January 1, 1970) or from some fixed point, tipically the start, in the life of a process (_elapsed_ or _wall clock_ time)
* _Process time_ is called _CPU Time_, is the amount of CPU time that a process has used since starting. Divided into _system CPU time_, the time spent executing code in _kernel mode_ 
  and _user CPU time_ is the time spent executing code in _user mode_

## Realtime

* The defining factor is that the response is guaranteed to be delivered within a certain deadline time after the triggering event
* Examples of applications with realtime reponse requirements include automated assembly lines, bank ATMs and aircraft navigation systems
* Requires support from the underlying operating system: requirements of realtime responsiveness can conflict with the requirements of multiuser
  time-sharing operating system

## The `/proc` File System

* Virtual file system that provides an interface to kernel data structures
* Easy mechanism for viewing and changing various system attributes
* `/proc/PID` allows to view information about each process running on the system

## References

1. [The Linux Programming Interface](http://man7.org/tlpi/) by Michael Kerrisk. Publisher: No Starch Press

1. Bash Pocket Reference by Arnold Robbins. Publisher: O'Reilly Media, Inc.
