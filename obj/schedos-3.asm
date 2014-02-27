
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
//#define PART8
#endif

void
start(void)
{
  400000:	31 c0                	xor    %eax,%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  400002:	ba 01 00 00 00       	mov    $0x1,%edx
  400007:	87 15 04 80 19 00    	xchg   %edx,0x198004

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.

	#ifndef PART8
		while(atomic_swap((uint32_t*)&lock,1) != 0){};
  40000d:	85 d2                	test   %edx,%edx
  40000f:	75 f1                	jne    400002 <start+0x2>
		*cursorpos++ = PRINTCHAR;
  400011:	8b 15 00 80 19 00    	mov    0x198000,%edx
  400017:	66 c7 02 33 09       	movw   $0x933,(%edx)
  40001c:	83 c2 02             	add    $0x2,%edx
  40001f:	89 15 00 80 19 00    	mov    %edx,0x198000
  400025:	31 d2                	xor    %edx,%edx
  400027:	87 15 04 80 19 00    	xchg   %edx,0x198004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  40002d:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  40002f:	40                   	inc    %eax
  400030:	3d 40 01 00 00       	cmp    $0x140,%eax
  400035:	75 cb                	jne    400002 <start+0x2>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400037:	66 31 c0             	xor    %ax,%ax
  40003a:	cd 31                	int    $0x31
  40003c:	eb fe                	jmp    40003c <start+0x3c>
