
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
#define PART8
#endif

void
start(void)
{
  400000:	31 d2                	xor    %edx,%edx

/* System call to set process shares */
static inline void sys_shares(int shares)
{
	
	asm volatile("int %0\n"
  400002:	b8 02 00 00 00       	mov    $0x2,%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  400007:	b9 01 00 00 00       	mov    $0x1,%ecx
  40000c:	87 0d 04 80 19 00    	xchg   %ecx,0x198004

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.

	#ifndef PART8
		while(atomic_swap((uint32_t*)&lock,1) != 0){};
  400012:	85 c9                	test   %ecx,%ecx
  400014:	75 f1                	jne    400007 <start+0x7>
		*cursorpos++ = PRINTCHAR;
  400016:	8b 0d 00 80 19 00    	mov    0x198000,%ecx
  40001c:	66 c7 01 33 09       	movw   $0x933,(%ecx)
  400021:	83 c1 02             	add    $0x2,%ecx
  400024:	89 0d 00 80 19 00    	mov    %ecx,0x198000
  40002a:	31 c9                	xor    %ecx,%ecx
  40002c:	87 0d 04 80 19 00    	xchg   %ecx,0x198004
  400032:	cd 35                	int    $0x35
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400034:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  400036:	42                   	inc    %edx
  400037:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  40003d:	75 c8                	jne    400007 <start+0x7>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  40003f:	31 c0                	xor    %eax,%eax
  400041:	cd 31                	int    $0x31
  400043:	eb fe                	jmp    400043 <start+0x43>
