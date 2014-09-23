# Linux Fundamentals: Lab book

## Reference Book

* The Linux Programming Interface

![](http://man7.org/tlpi/cover/TLPI-front-cover.png)

## Source code

* [Source code](http://man7.org/tlpi/code/online/all_files_by_chapter.html)
* [Distribution version](http://man7.org/tlpi/code/download/tlpi-140725-dist.tar.gz)

~~~~{.bash}
$: wget http://man7.org/tlpi/code/download/tlpi-140725-dist.tar.gz
~~~~

## Cross-Compilation

* Compile

~~~~{.bash}
$: source /opt/poky/1.6.1/environment-setup-cortexa9hf-vfp-neon-poky-linux-gnueabi
$: cd tlpi-dist
$: make
~~~~


## System Programming concepts: System Calls speed

* Understand how _expensive_ are system calls

### Running the application calling `getppid`

* On Host

~~~~{.bash}
$: cd progconc
$: make
$: cp sycall_speed <where your target root file system resides>/home/root
~~~~

* On target, run

~~~~{.bash}
$: time ./syscall_speed 10000000
Calling getppid()
real    0m 2.77s
user    0m 0.76s
sys 0m 2.01s
~~~~

### Running the application calling a custom function

* On host, include the parameter `DNOSYSCALL` into the `Makefile.inc`

~~~~{.makefile}
CFLAGS = -DNOSYSCALL ${IMPL_CFLAGS}
~~~~

* On host, compile

~~~~{.makefile}
$: make clean
$: make
$: cp sycall_speed <where your target root file system resides>/home/root
~~~~

* On target, run

~~~~{.bash}
time ./syscall_speed 10000000
Calling normal function
real    0m 0.23s
user    0m 0.23s
sys 0m 0.00s
~~~~


## File I/O: The Universal I/O Model

* Understand the Universality of I/O

### Copy `fileio/copy` into target

* On Host

~~~~{.bash}
cp fileio/copy <where your target root file system resides>/home/root
~~~~

* On target

~~~~{.bash}
./copy /etc/passwd passwd.txt
./copy /etc/passwd /dev/ttymxc0
./copy /dev/ttymxc0 session.txt
~~~~
