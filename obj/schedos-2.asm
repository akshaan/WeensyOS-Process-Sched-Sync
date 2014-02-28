
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
#define PART8
#endif

void
start(void)
{
  300000:	31 d2                	xor    %edx,%edx

/* System call to set process shares */
static inline void sys_shares(int shares)
{
	
	asm volatile("int %0\n"
  300002:	b8 03 00 00 00       	mov    $0x3,%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  300007:	b9 01 00 00 00       	mov    $0x1,%ecx
  30000c:	87 0d 04 80 19 00    	xchg   %ecx,0x198004

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.

	#ifndef PART8
		while(atomic_swap((uint32_t*)&lock,1) != 0){};
  300012:	85 c9                	test   %ecx,%ecx
  300014:	75 f1                	jne    300007 <start+0x7>
		*cursorpos++ = PRINTCHAR;
  300016:	8b 0d 00 80 19 00    	mov    0x198000,%ecx
  30001c:	66 c7 01 32 0a       	movw   $0xa32,(%ecx)
  300021:	83 c1 02             	add    $0x2,%ecx
  300024:	89 0d 00 80 19 00    	mov    %ecx,0x198000
  30002a:	31 c9                	xor    %ecx,%ecx
  30002c:	87 0d 04 80 19 00    	xchg   %ecx,0x198004
  300032:	cd 35                	int    $0x35
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300034:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  300036:	42                   	inc    %edx
  300037:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  30003d:	75 c8                	jne    300007 <start+0x7>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  30003f:	31 c0                	xor    %eax,%eax
  300041:	cd 31                	int    $0x31
  300043:	eb fe                	jmp    300043 <start+0x43>
