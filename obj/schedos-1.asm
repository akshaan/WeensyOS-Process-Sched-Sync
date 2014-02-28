
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
#define PART8
#endif

void
start(void)
{
  200000:	31 d2                	xor    %edx,%edx

/* System call to set process shares */
static inline void sys_shares(int shares)
{
	
	asm volatile("int %0\n"
  200002:	b8 04 00 00 00       	mov    $0x4,%eax
}

/* System call to lock the lock */
static inline void sys_lock_acquire(void)
{
	asm volatile("int %0\n"
  200007:	cd 33                	int    $0x33
		atomic_swap((uint32_t *)&lock,0);
	#endif

	#ifdef PART8
		sys_lock_acquire();
		*cursorpos++ = PRINTCHAR;
  200009:	8b 0d 00 80 19 00    	mov    0x198000,%ecx
  20000f:	66 c7 01 31 0c       	movw   $0xc31,(%ecx)
  200014:	83 c1 02             	add    $0x2,%ecx
  200017:	89 0d 00 80 19 00    	mov    %ecx,0x198000
}

/* System call to unlock the lock */
static inline void sys_lock_release(void)
{
	asm volatile("int %0\n"
  20001d:	cd 34                	int    $0x34

/* System call to set process shares */
static inline void sys_shares(int shares)
{
	
	asm volatile("int %0\n"
  20001f:	cd 35                	int    $0x35
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200021:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  200023:	42                   	inc    %edx
  200024:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  20002a:	75 db                	jne    200007 <start+0x7>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  20002c:	31 c0                	xor    %eax,%eax
  20002e:	cd 31                	int    $0x31
  200030:	eb fe                	jmp    200030 <start+0x30>
