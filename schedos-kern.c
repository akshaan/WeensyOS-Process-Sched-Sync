#include "schedos-kern.h"
#include "x86.h"
#include "lib.h"

/*****************************************************************************
 * schedos-kern
 *
 *   This is the schedos's kernel.
 *   It sets up process descriptors for the 4 applications, then runs
 *   them in some schedule.
 *
 *****************************************************************************/

// The program loader loads 4 processes, starting at PROC1_START, allocating
// 1 MB to each process.
// Each process's stack grows down from the top of its memory space.
// (But note that SchedOS processes, like MiniprocOS processes, are not fully
// isolated: any process could modify any part of memory.)

#define NPROCS		5
#define PROC1_START	0x200000
#define PROC_SIZE	0x100000

// +---------+-----------------------+--------+---------------------+---------/
// | Base    | Kernel         Kernel | Shared | App 0         App 0 | App 1
// | Memory  | Code + Data     Stack | Data   | Code + Data   Stack | Code ...
// +---------+-----------------------+--------+---------------------+---------/
// 0x0    0x100000               0x198000 0x200000              0x300000
//
// The program loader puts each application's starting instruction pointer
// at the very top of its stack.
//
// System-wide global variables shared among the kernel and the four
// applications are stored in memory from 0x198000 to 0x200000.  Currently
// there is just one variable there, 'cursorpos', which occupies the four
// bytes of memory 0x198000-0x198003.  You can add more variables by defining
// their addresses in schedos-symbols.ld; make sure they do not overlap!


// A process descriptor for each process.
// Note that proc_array[0] is never used.
// The first application process descriptor is proc_array[1].
static process_t proc_array[NPROCS];

// A pointer to the currently running process.
// This is kept up to date by the run() function, in mpos-x86.c.
process_t *current;

// The preferred scheduling algorithm.
int scheduling_algorithm;


/*****************************************************************************
 * start
 *
 *   Initialize the hardware and process descriptors, then run
 *   the first process.
 *
 *****************************************************************************/

void
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
	interrupt_controller_init(0);
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		// Set initial priorities to zero
		proc->p_priority = 0;

		// Set initial shares and count
		proc->p_shares = 0;
		proc->p_count = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;

	// Switch to the first process.
	run(&proc_array[1]);

	// Set the lock to 'unlocked'
	lock = 0;

	// Should never get here!
	while (1)
		/* do nothing */;
}



/*****************************************************************************
 * interrupt
 *
 *   This is the weensy interrupt and system call handler.
 *   The current handler handles 4 different system calls (two of which
 *   do nothing), plus the clock interrupt.
 *
 *   Note that we will never receive clock interrupts while in the kernel.
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;

	switch (reg->reg_intno) {

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();

	case INT_SYS_EXIT:
		// 'sys_exit' exits the current process: it is marked as
		// non-runnable.
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
		current->p_exit_status = reg->reg_eax;
		schedule();

	case INT_SYS_USER1: 
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		current->p_priority = reg->reg_eax;
		run(current);


	case INT_SYS_USER2: // LOCK
		/* Your code here (if you want). */
	 	while(lock == 1){};
		lock = 1;
		run(current);

	case INT_SYS_USER3: // UNLOCK
		lock = 0;
		run(current);


	case INT_SYS_USER4: // Set shares for process
		current->p_shares = reg->reg_eax;
		run(current);
			

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();

	default:
		while (1)
			/* do nothing */;

	}
}



/*****************************************************************************
 * schedule
 *
 *   This is the weensy process scheduler.
 *   It picks a runnable process, then context-switches to that process.
 *   If there are no runnable processes, it spins forever.
 *
 *   This function implements multiple scheduling algorithms, depending on
 *   the value of 'scheduling_algorithm'.  We've provided one; in the problem
 *   set you will provide at least one more.
 *
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;

	if (scheduling_algorithm == 0)
		while (1) {
			pid = (pid + 1) % NPROCS;

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}

	if(scheduling_algorithm == 1){
	 
		pid = current->p_pid;
		pid_t next_pid =0;
	
		int i;
		for(i =1; i < NPROCS; i++)
		{
			if(proc_array[i].p_state == P_RUNNABLE)
				{
					next_pid = i;
					break;
				}
		}

		run(&proc_array[next_pid]);

	}

	if(scheduling_algorithm == 2){
	int min = 2222;
	pid_t next = pid;
	int i;
	
	for(i = 1; i < NPROCS; i++)
	{
		if(proc_array[i].p_priority < min && proc_array[i].p_state == P_RUNNABLE)
		{
			min = proc_array[i].p_priority;
		}

	}

		int k = (pid + 1) % NPROCS;
		while(1)
		{
			if(proc_array[k].p_state == P_RUNNABLE && \
		   	proc_array[k].p_priority == min)
			{next = k; break; }
		
			k = (k + 1) % NPROCS;
		}
	
		run(&proc_array[next]);
		}	


	if(scheduling_algorithm == 3){
		
		int i;
		pid_t next_pid = 0;	
		int flag = 0;

	
		for(i = 1; i < NPROCS; i++)
		{
			if(proc_array[i].p_state == P_RUNNABLE && proc_array[i].p_shares == 0)
			{next_pid = i;goto run;}

		}

		for(i = 1; i < NPROCS; i++)
		{
			if(proc_array[i].p_shares != proc_array[i].p_count && proc_array[i].p_state == P_RUNNABLE)
				flag = 1;

		}

		if(flag == 0)
		for(i = 1; i < NPROCS; i++)
		{
			proc_array[i].p_count = 0;
		}


		for(i = 1; i < NPROCS; i++)
		{
			if(proc_array[i].p_state == P_RUNNABLE && proc_array[i].p_shares > proc_array[i].p_count)
		
			{next_pid = i; break;}
			
		}
		
			proc_array[next_pid].p_count++;
			run:
			run(&proc_array[i]);
	
}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
	while (1)
		/* do nothing */;
}
