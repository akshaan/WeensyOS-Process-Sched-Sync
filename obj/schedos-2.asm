
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
//#define PRIORITY 4
#endif

void
start(void)
{
  300000:	31 c0                	xor    %eax,%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  300002:	ba 01 00 00 00       	mov    $0x1,%edx
  300007:	87 15 04 80 19 00    	xchg   %edx,0x198004
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		while(atomic_swap((uint32_t*)&lock,1) != 0){};
  30000d:	85 d2                	test   %edx,%edx
  30000f:	75 f1                	jne    300002 <start+0x2>
		*cursorpos++ = PRINTCHAR;
  300011:	8b 15 00 80 19 00    	mov    0x198000,%edx
  300017:	66 c7 02 32 0a       	movw   $0xa32,(%edx)
  30001c:	83 c2 02             	add    $0x2,%edx
  30001f:	89 15 00 80 19 00    	mov    %edx,0x198000
  300025:	31 d2                	xor    %edx,%edx
  300027:	87 15 04 80 19 00    	xchg   %edx,0x198004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  30002d:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  30002f:	40                   	inc    %eax
  300030:	3d 40 01 00 00       	cmp    $0x140,%eax
  300035:	75 cb                	jne    300002 <start+0x2>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300037:	66 31 c0             	xor    %ax,%ax
  30003a:	cd 31                	int    $0x31
  30003c:	eb fe                	jmp    30003c <start+0x3c>
