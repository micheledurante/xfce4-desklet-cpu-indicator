
1.8 Miscellaneous kernel statistics in /proc/stat<sup>1</sup>
-------------------------------------------------

Various pieces   of  information about  kernel activity  are  available in the
/proc/stat file.  All  of  the numbers reported  in  this file are  aggregates
since the system first booted.  For a quick look, simply cat the file:

  > cat /proc/stat<br>
  cpu  2255 34 2290 22625563 6290 127 456 0 0 0<br>
  cpu0 1132 34 1441 11311718 3675 127 438 0 0 0<br>
  cpu1 1123 0 849 11313845 2614 0 18 0 0 0<br>
  intr 114930548 113199788 3 0 5 263 0 4 [... lots more numbers ...]<br>
  ctxt 1990473<br>
  btime 1062191376<br>
  processes 2915<br>
  procs_running 1<br>
  procs_blocked 0<br>
  softirq 183433 0 21755 12 39 1137 231 21459 2263

The very first  "cpu" line aggregates the  numbers in all  of the other "cpuN"
lines.  These numbers identify the amount of time the CPU has spent performing
different kinds of work.  Time units are in USER_HZ (typically hundredths of a
second).  The meanings of the columns are as follows, from left to right:

- user: normal processes executing in user mode
- nice: niced processes executing in user mode
- system: processes executing in kernel mode
- idle: twiddling thumbs
- iowait: In a word, iowait stands for waiting for I/O to complete. But there
  are several problems:
  1. Cpu will not wait for I/O to complete, iowait is the time that a task is
     waiting for I/O to complete. When cpu goes into idle state for
     outstanding task io, another task will be scheduled on this CPU.
  2. In a multi-core CPU, the task waiting for I/O to complete is not running
     on any CPU, so the iowait of each CPU is difficult to calculate.
  3. The value of iowait field in /proc/stat will decrease in certain
     conditions.
  So, the iowait is not reliable by reading from /proc/stat.
- irq: servicing interrupts
- softirq: servicing softirqs
- steal: involuntary wait
- guest: running a normal guest
- guest_nice: running a niced guest

The "intr" line gives counts of interrupts  serviced since boot time, for each
of the  possible system interrupts.   The first  column  is the  total of  all
interrupts serviced  including  unnumbered  architecture specific  interrupts;
each  subsequent column is the  total for that particular numbered interrupt.
Unnumbered interrupts are not shown, only summed into the total.

The "ctxt" line gives the total number of context switches across all CPUs.

The "btime" line gives  the time at which the  system booted, in seconds since
the Unix epoch.

The "processes" line gives the number  of processes and threads created, which
includes (but  is not limited  to) those  created by  calls to the  fork() and
clone() system calls.

The "procs_running" line gives the total number of threads that are
running or ready to run (i.e., the total number of runnable threads).

The   "procs_blocked" line gives  the  number of  processes currently blocked,
waiting for I/O to complete.

The "softirq" line gives counts of softirqs serviced since boot time, for each
of the possible system softirqs. The first column is the total of all
softirqs serviced; each subsequent column is the total for that particular
softirq.

---
1. https://www.kernel.org/doc/Documentation/filesystems/proc.txt, accessed 17.05.2017
