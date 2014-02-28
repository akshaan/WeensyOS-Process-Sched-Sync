#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
//#define PRIORITY 4
#define SHARES 4
#define PART8
#endif

void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.

	#ifndef PART8
		while(atomic_swap((uint32_t*)&lock,1) != 0){};
		*cursorpos++ = PRINTCHAR;
		atomic_swap((uint32_t *)&lock,0);
	#endif

	#ifdef PART8
		sys_lock_acquire();
		*cursorpos++ = PRINTCHAR;
		sys_lock_release();
	#endif
		sys_shares(SHARES);
	//	sys_prior(1);
		sys_yield();
	}

	// Yield forever.
	//while (1)
		sys_exit(0);
}
