
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 01 02 00 00       	call   10021a <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 19 01 00 00       	call   10018b <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	53                   	push   %ebx
  10009d:	83 ec 08             	sub    $0x8,%esp
	pid_t pid = current->p_pid;
  1000a0:	a1 a4 7f 10 00       	mov    0x107fa4,%eax
  1000a5:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a7:	a1 a8 7f 10 00       	mov    0x107fa8,%eax
  1000ac:	85 c0                	test   %eax,%eax
  1000ae:	75 1c                	jne    1000cc <schedule+0x30>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b0:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b5:	8d 42 01             	lea    0x1(%edx),%eax
  1000b8:	99                   	cltd   
  1000b9:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bb:	6b c2 54             	imul   $0x54,%edx,%eax
  1000be:	83 b8 e0 75 10 00 01 	cmpl   $0x1,0x1075e0(%eax)
  1000c5:	75 ee                	jne    1000b5 <schedule+0x19>
				run(&proc_array[pid]);
  1000c7:	83 ec 0c             	sub    $0xc,%esp
  1000ca:	eb 39                	jmp    100105 <schedule+0x69>
		}

	if(scheduling_algorithm == 1){
  1000cc:	83 f8 01             	cmp    $0x1,%eax
  1000cf:	75 3f                	jne    100110 <schedule+0x74>
		pid_t next_pid =0;
	
		int i;
		for(i =1; i < NPROCS; i++)
		{
			if(proc_array[i].p_state == P_RUNNABLE)
  1000d1:	83 3d 34 76 10 00 01 	cmpl   $0x1,0x107634
  1000d8:	74 25                	je     1000ff <schedule+0x63>
  1000da:	83 3d 88 76 10 00 01 	cmpl   $0x1,0x107688
  1000e1:	b0 02                	mov    $0x2,%al
  1000e3:	74 1a                	je     1000ff <schedule+0x63>
  1000e5:	83 3d dc 76 10 00 01 	cmpl   $0x1,0x1076dc
  1000ec:	b0 03                	mov    $0x3,%al
  1000ee:	74 0f                	je     1000ff <schedule+0x63>
  1000f0:	31 c0                	xor    %eax,%eax
  1000f2:	83 3d 30 77 10 00 01 	cmpl   $0x1,0x107730
  1000f9:	0f 94 c0             	sete   %al
  1000fc:	c1 e0 02             	shl    $0x2,%eax
					next_pid = i;
					break;
				}
		}

		run(&proc_array[next_pid]);
  1000ff:	6b c0 54             	imul   $0x54,%eax,%eax
  100102:	83 ec 0c             	sub    $0xc,%esp
  100105:	05 98 75 10 00       	add    $0x107598,%eax
  10010a:	50                   	push   %eax
  10010b:	e8 25 04 00 00       	call   100535 <run>

	}

	if(scheduling_algorithm == 2){
  100110:	83 f8 02             	cmp    $0x2,%eax
  100113:	75 55                	jne    10016a <schedule+0xce>
  100115:	30 c0                	xor    %al,%al
  100117:	bb ae 08 00 00       	mov    $0x8ae,%ebx
	pid_t next = pid;
	int i;
	
	for(i = 1; i < NPROCS; i++)
	{
		if(proc_array[i].p_priority < min && proc_array[i].p_state == P_RUNNABLE)
  10011c:	8b 88 3c 76 10 00    	mov    0x10763c(%eax),%ecx
  100122:	39 d9                	cmp    %ebx,%ecx
  100124:	7d 09                	jge    10012f <schedule+0x93>
  100126:	83 b8 34 76 10 00 01 	cmpl   $0x1,0x107634(%eax)
  10012d:	74 02                	je     100131 <schedule+0x95>
  10012f:	89 d9                	mov    %ebx,%ecx
  100131:	83 c0 54             	add    $0x54,%eax
	if(scheduling_algorithm == 2){
	int min = 2222;
	pid_t next = pid;
	int i;
	
	for(i = 1; i < NPROCS; i++)
  100134:	3d 50 01 00 00       	cmp    $0x150,%eax
  100139:	74 04                	je     10013f <schedule+0xa3>
  10013b:	89 cb                	mov    %ecx,%ebx
  10013d:	eb dd                	jmp    10011c <schedule+0x80>
			min = proc_array[i].p_priority;
		}

	}

		int k = (pid + 1) % NPROCS;
  10013f:	8d 42 01             	lea    0x1(%edx),%eax
  100142:	bb 05 00 00 00       	mov    $0x5,%ebx
  100147:	99                   	cltd   
  100148:	f7 fb                	idiv   %ebx
		while(1)
		{
			if(proc_array[k].p_state == P_RUNNABLE && \
  10014a:	6b c2 54             	imul   $0x54,%edx,%eax
  10014d:	83 b8 e0 75 10 00 01 	cmpl   $0x1,0x1075e0(%eax)
  100154:	75 0f                	jne    100165 <schedule+0xc9>
  100156:	05 98 75 10 00       	add    $0x107598,%eax
  10015b:	39 48 50             	cmp    %ecx,0x50(%eax)
  10015e:	75 05                	jne    100165 <schedule+0xc9>
			{next = k; break; }
		
			k = (k + 1) % NPROCS;
		}
	
		run(&proc_array[next]);
  100160:	83 ec 0c             	sub    $0xc,%esp
  100163:	eb a5                	jmp    10010a <schedule+0x6e>
		{
			if(proc_array[k].p_state == P_RUNNABLE && \
		   	proc_array[k].p_priority == min)
			{next = k; break; }
		
			k = (k + 1) % NPROCS;
  100165:	8d 42 01             	lea    0x1(%edx),%eax
  100168:	eb dd                	jmp    100147 <schedule+0xab>

	//if(scheduling_algorithm == 3){

			
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10016a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100170:	50                   	push   %eax
  100171:	68 f4 0a 10 00       	push   $0x100af4
  100176:	68 00 01 00 00       	push   $0x100
  10017b:	52                   	push   %edx
  10017c:	e8 59 09 00 00       	call   100ada <console_printf>
  100181:	83 c4 10             	add    $0x10,%esp
  100184:	a3 00 80 19 00       	mov    %eax,0x198000
  100189:	eb fe                	jmp    100189 <schedule+0xed>

0010018b <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10018b:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10018c:	8b 3d a4 7f 10 00    	mov    0x107fa4,%edi
  100192:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100197:	56                   	push   %esi
  100198:	53                   	push   %ebx
  100199:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10019d:	83 c7 04             	add    $0x4,%edi
  1001a0:	89 de                	mov    %ebx,%esi
  1001a2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001a4:	8b 43 28             	mov    0x28(%ebx),%eax
  1001a7:	83 f8 32             	cmp    $0x32,%eax
  1001aa:	74 38                	je     1001e4 <interrupt+0x59>
  1001ac:	77 0e                	ja     1001bc <interrupt+0x31>
  1001ae:	83 f8 30             	cmp    $0x30,%eax
  1001b1:	74 15                	je     1001c8 <interrupt+0x3d>
  1001b3:	77 18                	ja     1001cd <interrupt+0x42>
  1001b5:	83 f8 20             	cmp    $0x20,%eax
  1001b8:	74 55                	je     10020f <interrupt+0x84>
  1001ba:	eb 58                	jmp    100214 <interrupt+0x89>
  1001bc:	83 f8 33             	cmp    $0x33,%eax
  1001bf:	74 2e                	je     1001ef <interrupt+0x64>
  1001c1:	83 f8 34             	cmp    $0x34,%eax
  1001c4:	74 3d                	je     100203 <interrupt+0x78>
  1001c6:	eb 4c                	jmp    100214 <interrupt+0x89>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001c8:	e8 cf fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001cd:	a1 a4 7f 10 00       	mov    0x107fa4,%eax
		current->p_exit_status = reg->reg_eax;
  1001d2:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001d5:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1001dc:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1001df:	e8 b8 fe ff ff       	call   10009c <schedule>

	case INT_SYS_USER1: 
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		current->p_priority = reg->reg_eax;
  1001e4:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001e7:	a1 a4 7f 10 00       	mov    0x107fa4,%eax
  1001ec:	89 50 50             	mov    %edx,0x50(%eax)

	case INT_SYS_USER2: // LOCK
		/* Your code here (if you want). */
	 	while(lock == 1){};
  1001ef:	a1 04 80 19 00       	mov    0x198004,%eax
  1001f4:	48                   	dec    %eax
  1001f5:	74 f8                	je     1001ef <interrupt+0x64>
		lock = 1;
  1001f7:	c7 05 04 80 19 00 01 	movl   $0x1,0x198004
  1001fe:	00 00 00 
		break;
  100201:	eb 13                	jmp    100216 <interrupt+0x8b>

	case INT_SYS_USER3: // UNLOCK
		lock = 0;
  100203:	c7 05 04 80 19 00 00 	movl   $0x0,0x198004
  10020a:	00 00 00 
  10020d:	eb 07                	jmp    100216 <interrupt+0x8b>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10020f:	e8 88 fe ff ff       	call   10009c <schedule>
  100214:	eb fe                	jmp    100214 <interrupt+0x89>
	default:
		while (1)
			/* do nothing */;

	}
}
  100216:	5b                   	pop    %ebx
  100217:	5e                   	pop    %esi
  100218:	5f                   	pop    %edi
  100219:	c3                   	ret    

0010021a <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10021a:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10021b:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100220:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100221:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100223:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100224:	bb ec 75 10 00       	mov    $0x1075ec,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100229:	e8 e6 00 00 00       	call   100314 <segments_init>
	interrupt_controller_init(1);
  10022e:	83 ec 0c             	sub    $0xc,%esp
  100231:	6a 01                	push   $0x1
  100233:	e8 d7 01 00 00       	call   10040f <interrupt_controller_init>
	console_clear();
  100238:	e8 5b 02 00 00       	call   100498 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10023d:	83 c4 0c             	add    $0xc,%esp
  100240:	68 a4 01 00 00       	push   $0x1a4
  100245:	6a 00                	push   $0x0
  100247:	68 98 75 10 00       	push   $0x107598
  10024c:	e8 27 04 00 00       	call   100678 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100251:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100254:	c7 05 98 75 10 00 00 	movl   $0x0,0x107598
  10025b:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10025e:	c7 05 e0 75 10 00 00 	movl   $0x0,0x1075e0
  100265:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100268:	c7 05 ec 75 10 00 01 	movl   $0x1,0x1075ec
  10026f:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100272:	c7 05 34 76 10 00 00 	movl   $0x0,0x107634
  100279:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10027c:	c7 05 40 76 10 00 02 	movl   $0x2,0x107640
  100283:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100286:	c7 05 88 76 10 00 00 	movl   $0x0,0x107688
  10028d:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100290:	c7 05 94 76 10 00 03 	movl   $0x3,0x107694
  100297:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10029a:	c7 05 dc 76 10 00 00 	movl   $0x0,0x1076dc
  1002a1:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002a4:	c7 05 e8 76 10 00 04 	movl   $0x4,0x1076e8
  1002ab:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002ae:	c7 05 30 77 10 00 00 	movl   $0x0,0x107730
  1002b5:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1002b8:	83 ec 0c             	sub    $0xc,%esp
  1002bb:	53                   	push   %ebx
  1002bc:	e8 8b 02 00 00       	call   10054c <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002c1:	58                   	pop    %eax
  1002c2:	5a                   	pop    %edx
  1002c3:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1002c6:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		// Set initial priorities to zero
		proc->p_priority = 0;
  1002c9:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002cf:	50                   	push   %eax
  1002d0:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		// Set initial priorities to zero
		proc->p_priority = 0;
  1002d1:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002d2:	e8 b1 02 00 00       	call   100588 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002d7:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002da:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

		// Set initial priorities to zero
		proc->p_priority = 0;
  1002e1:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
  1002e8:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002eb:	83 fe 04             	cmp    $0x4,%esi
  1002ee:	75 c8                	jne    1002b8 <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 0;

	// Switch to the first process.
	run(&proc_array[1]);
  1002f0:	83 ec 0c             	sub    $0xc,%esp
  1002f3:	68 ec 75 10 00       	push   $0x1075ec
		proc->p_priority = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1002f8:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1002ff:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 0;
  100302:	c7 05 a8 7f 10 00 00 	movl   $0x0,0x107fa8
  100309:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10030c:	e8 24 02 00 00       	call   100535 <run>
  100311:	90                   	nop
  100312:	90                   	nop
  100313:	90                   	nop

00100314 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100314:	b8 3c 77 10 00       	mov    $0x10773c,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100319:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10031e:	89 c2                	mov    %eax,%edx
  100320:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100323:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100324:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100329:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10032c:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100332:	c1 e8 18             	shr    $0x18,%eax
  100335:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10033b:	ba a4 77 10 00       	mov    $0x1077a4,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100340:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100345:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100347:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10034e:	68 00 
  100350:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100357:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10035e:	c7 05 40 77 10 00 00 	movl   $0x180000,0x107740
  100365:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100368:	66 c7 05 44 77 10 00 	movw   $0x10,0x107744
  10036f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100371:	66 89 0c c5 a4 77 10 	mov    %cx,0x1077a4(,%eax,8)
  100378:	00 
  100379:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100380:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100385:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10038a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10038f:	40                   	inc    %eax
  100390:	3d 00 01 00 00       	cmp    $0x100,%eax
  100395:	75 da                	jne    100371 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100397:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10039c:	ba a4 77 10 00       	mov    $0x1077a4,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003a1:	66 a3 a4 78 10 00    	mov    %ax,0x1078a4
  1003a7:	c1 e8 10             	shr    $0x10,%eax
  1003aa:	66 a3 aa 78 10 00    	mov    %ax,0x1078aa
  1003b0:	b8 30 00 00 00       	mov    $0x30,%eax
  1003b5:	66 c7 05 a6 78 10 00 	movw   $0x8,0x1078a6
  1003bc:	08 00 
  1003be:	c6 05 a8 78 10 00 00 	movb   $0x0,0x1078a8
  1003c5:	c6 05 a9 78 10 00 8e 	movb   $0x8e,0x1078a9

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003cc:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1003d3:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003da:	66 89 0c c5 a4 77 10 	mov    %cx,0x1077a4(,%eax,8)
  1003e1:	00 
  1003e2:	c1 e9 10             	shr    $0x10,%ecx
  1003e5:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003ea:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003ef:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1003f4:	40                   	inc    %eax
  1003f5:	83 f8 3a             	cmp    $0x3a,%eax
  1003f8:	75 d2                	jne    1003cc <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003fa:	b0 28                	mov    $0x28,%al
  1003fc:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100403:	0f 00 d8             	ltr    %ax
  100406:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  10040d:	5b                   	pop    %ebx
  10040e:	c3                   	ret    

0010040f <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10040f:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100410:	b0 ff                	mov    $0xff,%al
  100412:	57                   	push   %edi
  100413:	56                   	push   %esi
  100414:	53                   	push   %ebx
  100415:	bb 21 00 00 00       	mov    $0x21,%ebx
  10041a:	89 da                	mov    %ebx,%edx
  10041c:	ee                   	out    %al,(%dx)
  10041d:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100422:	89 ca                	mov    %ecx,%edx
  100424:	ee                   	out    %al,(%dx)
  100425:	be 11 00 00 00       	mov    $0x11,%esi
  10042a:	bf 20 00 00 00       	mov    $0x20,%edi
  10042f:	89 f0                	mov    %esi,%eax
  100431:	89 fa                	mov    %edi,%edx
  100433:	ee                   	out    %al,(%dx)
  100434:	b0 20                	mov    $0x20,%al
  100436:	89 da                	mov    %ebx,%edx
  100438:	ee                   	out    %al,(%dx)
  100439:	b0 04                	mov    $0x4,%al
  10043b:	ee                   	out    %al,(%dx)
  10043c:	b0 03                	mov    $0x3,%al
  10043e:	ee                   	out    %al,(%dx)
  10043f:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100444:	89 f0                	mov    %esi,%eax
  100446:	89 ea                	mov    %ebp,%edx
  100448:	ee                   	out    %al,(%dx)
  100449:	b0 28                	mov    $0x28,%al
  10044b:	89 ca                	mov    %ecx,%edx
  10044d:	ee                   	out    %al,(%dx)
  10044e:	b0 02                	mov    $0x2,%al
  100450:	ee                   	out    %al,(%dx)
  100451:	b0 01                	mov    $0x1,%al
  100453:	ee                   	out    %al,(%dx)
  100454:	b0 68                	mov    $0x68,%al
  100456:	89 fa                	mov    %edi,%edx
  100458:	ee                   	out    %al,(%dx)
  100459:	be 0a 00 00 00       	mov    $0xa,%esi
  10045e:	89 f0                	mov    %esi,%eax
  100460:	ee                   	out    %al,(%dx)
  100461:	b0 68                	mov    $0x68,%al
  100463:	89 ea                	mov    %ebp,%edx
  100465:	ee                   	out    %al,(%dx)
  100466:	89 f0                	mov    %esi,%eax
  100468:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100469:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10046e:	89 da                	mov    %ebx,%edx
  100470:	19 c0                	sbb    %eax,%eax
  100472:	f7 d0                	not    %eax
  100474:	05 ff 00 00 00       	add    $0xff,%eax
  100479:	ee                   	out    %al,(%dx)
  10047a:	b0 ff                	mov    $0xff,%al
  10047c:	89 ca                	mov    %ecx,%edx
  10047e:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10047f:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100484:	74 0d                	je     100493 <interrupt_controller_init+0x84>
  100486:	b2 43                	mov    $0x43,%dl
  100488:	b0 34                	mov    $0x34,%al
  10048a:	ee                   	out    %al,(%dx)
  10048b:	b0 a9                	mov    $0xa9,%al
  10048d:	b2 40                	mov    $0x40,%dl
  10048f:	ee                   	out    %al,(%dx)
  100490:	b0 04                	mov    $0x4,%al
  100492:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100493:	5b                   	pop    %ebx
  100494:	5e                   	pop    %esi
  100495:	5f                   	pop    %edi
  100496:	5d                   	pop    %ebp
  100497:	c3                   	ret    

00100498 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100498:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100499:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10049b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10049c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004a3:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1004a6:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1004ac:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1004b2:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004b5:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1004ba:	75 ea                	jne    1004a6 <console_clear+0xe>
  1004bc:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004c1:	b0 0e                	mov    $0xe,%al
  1004c3:	89 f2                	mov    %esi,%edx
  1004c5:	ee                   	out    %al,(%dx)
  1004c6:	31 c9                	xor    %ecx,%ecx
  1004c8:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004cd:	88 c8                	mov    %cl,%al
  1004cf:	89 da                	mov    %ebx,%edx
  1004d1:	ee                   	out    %al,(%dx)
  1004d2:	b0 0f                	mov    $0xf,%al
  1004d4:	89 f2                	mov    %esi,%edx
  1004d6:	ee                   	out    %al,(%dx)
  1004d7:	88 c8                	mov    %cl,%al
  1004d9:	89 da                	mov    %ebx,%edx
  1004db:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004dc:	5b                   	pop    %ebx
  1004dd:	5e                   	pop    %esi
  1004de:	c3                   	ret    

001004df <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004df:	ba 64 00 00 00       	mov    $0x64,%edx
  1004e4:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004e5:	a8 01                	test   $0x1,%al
  1004e7:	74 45                	je     10052e <console_read_digit+0x4f>
  1004e9:	b2 60                	mov    $0x60,%dl
  1004eb:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004ec:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004ef:	80 fa 08             	cmp    $0x8,%dl
  1004f2:	77 05                	ja     1004f9 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004f4:	0f b6 c0             	movzbl %al,%eax
  1004f7:	48                   	dec    %eax
  1004f8:	c3                   	ret    
	else if (data == 0x0B)
  1004f9:	3c 0b                	cmp    $0xb,%al
  1004fb:	74 35                	je     100532 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004fd:	8d 50 b9             	lea    -0x47(%eax),%edx
  100500:	80 fa 02             	cmp    $0x2,%dl
  100503:	77 07                	ja     10050c <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100505:	0f b6 c0             	movzbl %al,%eax
  100508:	83 e8 40             	sub    $0x40,%eax
  10050b:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  10050c:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10050f:	80 fa 02             	cmp    $0x2,%dl
  100512:	77 07                	ja     10051b <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100514:	0f b6 c0             	movzbl %al,%eax
  100517:	83 e8 47             	sub    $0x47,%eax
  10051a:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10051b:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10051e:	80 fa 02             	cmp    $0x2,%dl
  100521:	77 07                	ja     10052a <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100523:	0f b6 c0             	movzbl %al,%eax
  100526:	83 e8 4e             	sub    $0x4e,%eax
  100529:	c3                   	ret    
	else if (data == 0x53)
  10052a:	3c 53                	cmp    $0x53,%al
  10052c:	74 04                	je     100532 <console_read_digit+0x53>
  10052e:	83 c8 ff             	or     $0xffffffff,%eax
  100531:	c3                   	ret    
  100532:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100534:	c3                   	ret    

00100535 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100535:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100539:	a3 a4 7f 10 00       	mov    %eax,0x107fa4

	asm volatile("movl %0,%%esp\n\t"
  10053e:	83 c0 04             	add    $0x4,%eax
  100541:	89 c4                	mov    %eax,%esp
  100543:	61                   	popa   
  100544:	07                   	pop    %es
  100545:	1f                   	pop    %ds
  100546:	83 c4 08             	add    $0x8,%esp
  100549:	cf                   	iret   
  10054a:	eb fe                	jmp    10054a <run+0x15>

0010054c <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10054c:	53                   	push   %ebx
  10054d:	83 ec 0c             	sub    $0xc,%esp
  100550:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100554:	6a 44                	push   $0x44
  100556:	6a 00                	push   $0x0
  100558:	8d 43 04             	lea    0x4(%ebx),%eax
  10055b:	50                   	push   %eax
  10055c:	e8 17 01 00 00       	call   100678 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100561:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100567:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  10056d:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100573:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100579:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100580:	83 c4 18             	add    $0x18,%esp
  100583:	5b                   	pop    %ebx
  100584:	c3                   	ret    
  100585:	90                   	nop
  100586:	90                   	nop
  100587:	90                   	nop

00100588 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100588:	55                   	push   %ebp
  100589:	57                   	push   %edi
  10058a:	56                   	push   %esi
  10058b:	53                   	push   %ebx
  10058c:	83 ec 1c             	sub    $0x1c,%esp
  10058f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100593:	83 f8 03             	cmp    $0x3,%eax
  100596:	7f 04                	jg     10059c <program_loader+0x14>
  100598:	85 c0                	test   %eax,%eax
  10059a:	79 02                	jns    10059e <program_loader+0x16>
  10059c:	eb fe                	jmp    10059c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10059e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1005a5:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1005ab:	74 02                	je     1005af <program_loader+0x27>
  1005ad:	eb fe                	jmp    1005ad <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005af:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1005b2:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005b6:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005b8:	c1 e5 05             	shl    $0x5,%ebp
  1005bb:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1005be:	eb 3f                	jmp    1005ff <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005c0:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005c3:	75 37                	jne    1005fc <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1005c5:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005c8:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005cb:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005ce:	01 c7                	add    %eax,%edi
	memsz += va;
  1005d0:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005d7:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005db:	52                   	push   %edx
  1005dc:	89 fa                	mov    %edi,%edx
  1005de:	29 c2                	sub    %eax,%edx
  1005e0:	52                   	push   %edx
  1005e1:	8b 53 04             	mov    0x4(%ebx),%edx
  1005e4:	01 f2                	add    %esi,%edx
  1005e6:	52                   	push   %edx
  1005e7:	50                   	push   %eax
  1005e8:	e8 27 00 00 00       	call   100614 <memcpy>
  1005ed:	83 c4 10             	add    $0x10,%esp
  1005f0:	eb 04                	jmp    1005f6 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005f2:	c6 07 00             	movb   $0x0,(%edi)
  1005f5:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005f6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005fa:	72 f6                	jb     1005f2 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005fc:	83 c3 20             	add    $0x20,%ebx
  1005ff:	39 eb                	cmp    %ebp,%ebx
  100601:	72 bd                	jb     1005c0 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100603:	8b 56 18             	mov    0x18(%esi),%edx
  100606:	8b 44 24 34          	mov    0x34(%esp),%eax
  10060a:	89 10                	mov    %edx,(%eax)
}
  10060c:	83 c4 1c             	add    $0x1c,%esp
  10060f:	5b                   	pop    %ebx
  100610:	5e                   	pop    %esi
  100611:	5f                   	pop    %edi
  100612:	5d                   	pop    %ebp
  100613:	c3                   	ret    

00100614 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100614:	56                   	push   %esi
  100615:	31 d2                	xor    %edx,%edx
  100617:	53                   	push   %ebx
  100618:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10061c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100620:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100624:	eb 08                	jmp    10062e <memcpy+0x1a>
		*d++ = *s++;
  100626:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100629:	4e                   	dec    %esi
  10062a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10062d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10062e:	85 f6                	test   %esi,%esi
  100630:	75 f4                	jne    100626 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100632:	5b                   	pop    %ebx
  100633:	5e                   	pop    %esi
  100634:	c3                   	ret    

00100635 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100635:	57                   	push   %edi
  100636:	56                   	push   %esi
  100637:	53                   	push   %ebx
  100638:	8b 44 24 10          	mov    0x10(%esp),%eax
  10063c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100640:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100644:	39 c7                	cmp    %eax,%edi
  100646:	73 26                	jae    10066e <memmove+0x39>
  100648:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10064b:	39 c6                	cmp    %eax,%esi
  10064d:	76 1f                	jbe    10066e <memmove+0x39>
		s += n, d += n;
  10064f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100652:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100654:	eb 07                	jmp    10065d <memmove+0x28>
			*--d = *--s;
  100656:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100659:	4a                   	dec    %edx
  10065a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10065d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10065e:	85 d2                	test   %edx,%edx
  100660:	75 f4                	jne    100656 <memmove+0x21>
  100662:	eb 10                	jmp    100674 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100664:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100667:	4a                   	dec    %edx
  100668:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10066b:	41                   	inc    %ecx
  10066c:	eb 02                	jmp    100670 <memmove+0x3b>
  10066e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100670:	85 d2                	test   %edx,%edx
  100672:	75 f0                	jne    100664 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100674:	5b                   	pop    %ebx
  100675:	5e                   	pop    %esi
  100676:	5f                   	pop    %edi
  100677:	c3                   	ret    

00100678 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100678:	53                   	push   %ebx
  100679:	8b 44 24 08          	mov    0x8(%esp),%eax
  10067d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100681:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100685:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100687:	eb 04                	jmp    10068d <memset+0x15>
		*p++ = c;
  100689:	88 1a                	mov    %bl,(%edx)
  10068b:	49                   	dec    %ecx
  10068c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10068d:	85 c9                	test   %ecx,%ecx
  10068f:	75 f8                	jne    100689 <memset+0x11>
		*p++ = c;
	return v;
}
  100691:	5b                   	pop    %ebx
  100692:	c3                   	ret    

00100693 <strlen>:

size_t
strlen(const char *s)
{
  100693:	8b 54 24 04          	mov    0x4(%esp),%edx
  100697:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100699:	eb 01                	jmp    10069c <strlen+0x9>
		++n;
  10069b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10069c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1006a0:	75 f9                	jne    10069b <strlen+0x8>
		++n;
	return n;
}
  1006a2:	c3                   	ret    

001006a3 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1006a3:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1006a7:	31 c0                	xor    %eax,%eax
  1006a9:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006ad:	eb 01                	jmp    1006b0 <strnlen+0xd>
		++n;
  1006af:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006b0:	39 d0                	cmp    %edx,%eax
  1006b2:	74 06                	je     1006ba <strnlen+0x17>
  1006b4:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006b8:	75 f5                	jne    1006af <strnlen+0xc>
		++n;
	return n;
}
  1006ba:	c3                   	ret    

001006bb <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006bb:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1006bc:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006c1:	53                   	push   %ebx
  1006c2:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1006c4:	76 05                	jbe    1006cb <console_putc+0x10>
  1006c6:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006cb:	80 fa 0a             	cmp    $0xa,%dl
  1006ce:	75 2c                	jne    1006fc <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006d0:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006d6:	be 50 00 00 00       	mov    $0x50,%esi
  1006db:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006dd:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006e0:	99                   	cltd   
  1006e1:	f7 fe                	idiv   %esi
  1006e3:	89 de                	mov    %ebx,%esi
  1006e5:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006e7:	eb 07                	jmp    1006f0 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006e9:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006ec:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1006ed:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006f0:	83 f8 50             	cmp    $0x50,%eax
  1006f3:	75 f4                	jne    1006e9 <console_putc+0x2e>
  1006f5:	29 d0                	sub    %edx,%eax
  1006f7:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006fa:	eb 0b                	jmp    100707 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006fc:	0f b6 d2             	movzbl %dl,%edx
  1006ff:	09 ca                	or     %ecx,%edx
  100701:	66 89 13             	mov    %dx,(%ebx)
  100704:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100707:	5b                   	pop    %ebx
  100708:	5e                   	pop    %esi
  100709:	c3                   	ret    

0010070a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10070a:	56                   	push   %esi
  10070b:	53                   	push   %ebx
  10070c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100710:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100713:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100717:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10071c:	75 04                	jne    100722 <fill_numbuf+0x18>
  10071e:	85 d2                	test   %edx,%edx
  100720:	74 10                	je     100732 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100722:	89 d0                	mov    %edx,%eax
  100724:	31 d2                	xor    %edx,%edx
  100726:	f7 f1                	div    %ecx
  100728:	4b                   	dec    %ebx
  100729:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10072c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10072e:	89 c2                	mov    %eax,%edx
  100730:	eb ec                	jmp    10071e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100732:	89 d8                	mov    %ebx,%eax
  100734:	5b                   	pop    %ebx
  100735:	5e                   	pop    %esi
  100736:	c3                   	ret    

00100737 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100737:	55                   	push   %ebp
  100738:	57                   	push   %edi
  100739:	56                   	push   %esi
  10073a:	53                   	push   %ebx
  10073b:	83 ec 38             	sub    $0x38,%esp
  10073e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100742:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100746:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10074a:	e9 60 03 00 00       	jmp    100aaf <console_vprintf+0x378>
		if (*format != '%') {
  10074f:	80 fa 25             	cmp    $0x25,%dl
  100752:	74 13                	je     100767 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100754:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100758:	0f b6 d2             	movzbl %dl,%edx
  10075b:	89 f0                	mov    %esi,%eax
  10075d:	e8 59 ff ff ff       	call   1006bb <console_putc>
  100762:	e9 45 03 00 00       	jmp    100aac <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100767:	47                   	inc    %edi
  100768:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10076f:	00 
  100770:	eb 12                	jmp    100784 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100772:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100773:	8a 11                	mov    (%ecx),%dl
  100775:	84 d2                	test   %dl,%dl
  100777:	74 1a                	je     100793 <console_vprintf+0x5c>
  100779:	89 e8                	mov    %ebp,%eax
  10077b:	38 c2                	cmp    %al,%dl
  10077d:	75 f3                	jne    100772 <console_vprintf+0x3b>
  10077f:	e9 3f 03 00 00       	jmp    100ac3 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100784:	8a 17                	mov    (%edi),%dl
  100786:	84 d2                	test   %dl,%dl
  100788:	74 0b                	je     100795 <console_vprintf+0x5e>
  10078a:	b9 18 0b 10 00       	mov    $0x100b18,%ecx
  10078f:	89 d5                	mov    %edx,%ebp
  100791:	eb e0                	jmp    100773 <console_vprintf+0x3c>
  100793:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100795:	8d 42 cf             	lea    -0x31(%edx),%eax
  100798:	3c 08                	cmp    $0x8,%al
  10079a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1007a1:	00 
  1007a2:	76 13                	jbe    1007b7 <console_vprintf+0x80>
  1007a4:	eb 1d                	jmp    1007c3 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1007a6:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1007ab:	0f be c0             	movsbl %al,%eax
  1007ae:	47                   	inc    %edi
  1007af:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1007b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1007b7:	8a 07                	mov    (%edi),%al
  1007b9:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007bc:	80 fa 09             	cmp    $0x9,%dl
  1007bf:	76 e5                	jbe    1007a6 <console_vprintf+0x6f>
  1007c1:	eb 18                	jmp    1007db <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007c3:	80 fa 2a             	cmp    $0x2a,%dl
  1007c6:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007cd:	ff 
  1007ce:	75 0b                	jne    1007db <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007d0:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007d3:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007d4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007d7:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007db:	83 cd ff             	or     $0xffffffff,%ebp
  1007de:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007e1:	75 37                	jne    10081a <console_vprintf+0xe3>
			++format;
  1007e3:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007e4:	31 ed                	xor    %ebp,%ebp
  1007e6:	8a 07                	mov    (%edi),%al
  1007e8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007eb:	80 fa 09             	cmp    $0x9,%dl
  1007ee:	76 0d                	jbe    1007fd <console_vprintf+0xc6>
  1007f0:	eb 17                	jmp    100809 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007f2:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007f5:	0f be c0             	movsbl %al,%eax
  1007f8:	47                   	inc    %edi
  1007f9:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007fd:	8a 07                	mov    (%edi),%al
  1007ff:	8d 50 d0             	lea    -0x30(%eax),%edx
  100802:	80 fa 09             	cmp    $0x9,%dl
  100805:	76 eb                	jbe    1007f2 <console_vprintf+0xbb>
  100807:	eb 11                	jmp    10081a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100809:	3c 2a                	cmp    $0x2a,%al
  10080b:	75 0b                	jne    100818 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10080d:	83 c3 04             	add    $0x4,%ebx
				++format;
  100810:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100811:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100814:	85 ed                	test   %ebp,%ebp
  100816:	79 02                	jns    10081a <console_vprintf+0xe3>
  100818:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10081a:	8a 07                	mov    (%edi),%al
  10081c:	3c 64                	cmp    $0x64,%al
  10081e:	74 34                	je     100854 <console_vprintf+0x11d>
  100820:	7f 1d                	jg     10083f <console_vprintf+0x108>
  100822:	3c 58                	cmp    $0x58,%al
  100824:	0f 84 a2 00 00 00    	je     1008cc <console_vprintf+0x195>
  10082a:	3c 63                	cmp    $0x63,%al
  10082c:	0f 84 bf 00 00 00    	je     1008f1 <console_vprintf+0x1ba>
  100832:	3c 43                	cmp    $0x43,%al
  100834:	0f 85 d0 00 00 00    	jne    10090a <console_vprintf+0x1d3>
  10083a:	e9 a3 00 00 00       	jmp    1008e2 <console_vprintf+0x1ab>
  10083f:	3c 75                	cmp    $0x75,%al
  100841:	74 4d                	je     100890 <console_vprintf+0x159>
  100843:	3c 78                	cmp    $0x78,%al
  100845:	74 5c                	je     1008a3 <console_vprintf+0x16c>
  100847:	3c 73                	cmp    $0x73,%al
  100849:	0f 85 bb 00 00 00    	jne    10090a <console_vprintf+0x1d3>
  10084f:	e9 86 00 00 00       	jmp    1008da <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100854:	83 c3 04             	add    $0x4,%ebx
  100857:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10085a:	89 d1                	mov    %edx,%ecx
  10085c:	c1 f9 1f             	sar    $0x1f,%ecx
  10085f:	89 0c 24             	mov    %ecx,(%esp)
  100862:	31 ca                	xor    %ecx,%edx
  100864:	55                   	push   %ebp
  100865:	29 ca                	sub    %ecx,%edx
  100867:	68 20 0b 10 00       	push   $0x100b20
  10086c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100871:	8d 44 24 40          	lea    0x40(%esp),%eax
  100875:	e8 90 fe ff ff       	call   10070a <fill_numbuf>
  10087a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10087e:	58                   	pop    %eax
  10087f:	5a                   	pop    %edx
  100880:	ba 01 00 00 00       	mov    $0x1,%edx
  100885:	8b 04 24             	mov    (%esp),%eax
  100888:	83 e0 01             	and    $0x1,%eax
  10088b:	e9 a5 00 00 00       	jmp    100935 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100890:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100893:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100898:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10089b:	55                   	push   %ebp
  10089c:	68 20 0b 10 00       	push   $0x100b20
  1008a1:	eb 11                	jmp    1008b4 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1008a3:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1008a6:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008a9:	55                   	push   %ebp
  1008aa:	68 34 0b 10 00       	push   $0x100b34
  1008af:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008b4:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008b8:	e8 4d fe ff ff       	call   10070a <fill_numbuf>
  1008bd:	ba 01 00 00 00       	mov    $0x1,%edx
  1008c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1008c6:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008c8:	59                   	pop    %ecx
  1008c9:	59                   	pop    %ecx
  1008ca:	eb 69                	jmp    100935 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008cc:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008cf:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008d2:	55                   	push   %ebp
  1008d3:	68 20 0b 10 00       	push   $0x100b20
  1008d8:	eb d5                	jmp    1008af <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008da:	83 c3 04             	add    $0x4,%ebx
  1008dd:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008e0:	eb 40                	jmp    100922 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008e2:	83 c3 04             	add    $0x4,%ebx
  1008e5:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008e8:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1008ec:	e9 bd 01 00 00       	jmp    100aae <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008f1:	83 c3 04             	add    $0x4,%ebx
  1008f4:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008f7:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008fb:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100900:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100904:	88 44 24 24          	mov    %al,0x24(%esp)
  100908:	eb 27                	jmp    100931 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10090a:	84 c0                	test   %al,%al
  10090c:	75 02                	jne    100910 <console_vprintf+0x1d9>
  10090e:	b0 25                	mov    $0x25,%al
  100910:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100914:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100919:	80 3f 00             	cmpb   $0x0,(%edi)
  10091c:	74 0a                	je     100928 <console_vprintf+0x1f1>
  10091e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100922:	89 44 24 04          	mov    %eax,0x4(%esp)
  100926:	eb 09                	jmp    100931 <console_vprintf+0x1fa>
				format--;
  100928:	8d 54 24 24          	lea    0x24(%esp),%edx
  10092c:	4f                   	dec    %edi
  10092d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100931:	31 d2                	xor    %edx,%edx
  100933:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100935:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100937:	83 fd ff             	cmp    $0xffffffff,%ebp
  10093a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100941:	74 1f                	je     100962 <console_vprintf+0x22b>
  100943:	89 04 24             	mov    %eax,(%esp)
  100946:	eb 01                	jmp    100949 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100948:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100949:	39 e9                	cmp    %ebp,%ecx
  10094b:	74 0a                	je     100957 <console_vprintf+0x220>
  10094d:	8b 44 24 04          	mov    0x4(%esp),%eax
  100951:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100955:	75 f1                	jne    100948 <console_vprintf+0x211>
  100957:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10095a:	89 0c 24             	mov    %ecx,(%esp)
  10095d:	eb 1f                	jmp    10097e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  10095f:	42                   	inc    %edx
  100960:	eb 09                	jmp    10096b <console_vprintf+0x234>
  100962:	89 d1                	mov    %edx,%ecx
  100964:	8b 14 24             	mov    (%esp),%edx
  100967:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10096b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10096f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100973:	75 ea                	jne    10095f <console_vprintf+0x228>
  100975:	8b 44 24 08          	mov    0x8(%esp),%eax
  100979:	89 14 24             	mov    %edx,(%esp)
  10097c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10097e:	85 c0                	test   %eax,%eax
  100980:	74 0c                	je     10098e <console_vprintf+0x257>
  100982:	84 d2                	test   %dl,%dl
  100984:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10098b:	00 
  10098c:	75 24                	jne    1009b2 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10098e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100993:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10099a:	00 
  10099b:	75 15                	jne    1009b2 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10099d:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009a1:	83 e0 08             	and    $0x8,%eax
  1009a4:	83 f8 01             	cmp    $0x1,%eax
  1009a7:	19 c9                	sbb    %ecx,%ecx
  1009a9:	f7 d1                	not    %ecx
  1009ab:	83 e1 20             	and    $0x20,%ecx
  1009ae:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009b2:	3b 2c 24             	cmp    (%esp),%ebp
  1009b5:	7e 0d                	jle    1009c4 <console_vprintf+0x28d>
  1009b7:	84 d2                	test   %dl,%dl
  1009b9:	74 40                	je     1009fb <console_vprintf+0x2c4>
			zeros = precision - len;
  1009bb:	2b 2c 24             	sub    (%esp),%ebp
  1009be:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009c2:	eb 3f                	jmp    100a03 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009c4:	84 d2                	test   %dl,%dl
  1009c6:	74 33                	je     1009fb <console_vprintf+0x2c4>
  1009c8:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009cc:	83 e0 06             	and    $0x6,%eax
  1009cf:	83 f8 02             	cmp    $0x2,%eax
  1009d2:	75 27                	jne    1009fb <console_vprintf+0x2c4>
  1009d4:	45                   	inc    %ebp
  1009d5:	75 24                	jne    1009fb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009d7:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009d9:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009dc:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009e1:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009e4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009e7:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009eb:	7d 0e                	jge    1009fb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1009ed:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009f1:	29 ca                	sub    %ecx,%edx
  1009f3:	29 c2                	sub    %eax,%edx
  1009f5:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009f9:	eb 08                	jmp    100a03 <console_vprintf+0x2cc>
  1009fb:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a02:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a03:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a07:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a09:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a0d:	2b 2c 24             	sub    (%esp),%ebp
  100a10:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a15:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a18:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a1b:	29 c5                	sub    %eax,%ebp
  100a1d:	89 f0                	mov    %esi,%eax
  100a1f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a23:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a27:	eb 0f                	jmp    100a38 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a29:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a2d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a32:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a33:	e8 83 fc ff ff       	call   1006bb <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a38:	85 ed                	test   %ebp,%ebp
  100a3a:	7e 07                	jle    100a43 <console_vprintf+0x30c>
  100a3c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a41:	74 e6                	je     100a29 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a43:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a48:	89 c6                	mov    %eax,%esi
  100a4a:	74 23                	je     100a6f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a4c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a51:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a55:	e8 61 fc ff ff       	call   1006bb <console_putc>
  100a5a:	89 c6                	mov    %eax,%esi
  100a5c:	eb 11                	jmp    100a6f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a5e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a62:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a67:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a68:	e8 4e fc ff ff       	call   1006bb <console_putc>
  100a6d:	eb 06                	jmp    100a75 <console_vprintf+0x33e>
  100a6f:	89 f0                	mov    %esi,%eax
  100a71:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a75:	85 f6                	test   %esi,%esi
  100a77:	7f e5                	jg     100a5e <console_vprintf+0x327>
  100a79:	8b 34 24             	mov    (%esp),%esi
  100a7c:	eb 15                	jmp    100a93 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a7e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a82:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a83:	0f b6 11             	movzbl (%ecx),%edx
  100a86:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a8a:	e8 2c fc ff ff       	call   1006bb <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a8f:	ff 44 24 04          	incl   0x4(%esp)
  100a93:	85 f6                	test   %esi,%esi
  100a95:	7f e7                	jg     100a7e <console_vprintf+0x347>
  100a97:	eb 0f                	jmp    100aa8 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a99:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a9d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100aa2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100aa3:	e8 13 fc ff ff       	call   1006bb <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100aa8:	85 ed                	test   %ebp,%ebp
  100aaa:	7f ed                	jg     100a99 <console_vprintf+0x362>
  100aac:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100aae:	47                   	inc    %edi
  100aaf:	8a 17                	mov    (%edi),%dl
  100ab1:	84 d2                	test   %dl,%dl
  100ab3:	0f 85 96 fc ff ff    	jne    10074f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100ab9:	83 c4 38             	add    $0x38,%esp
  100abc:	89 f0                	mov    %esi,%eax
  100abe:	5b                   	pop    %ebx
  100abf:	5e                   	pop    %esi
  100ac0:	5f                   	pop    %edi
  100ac1:	5d                   	pop    %ebp
  100ac2:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ac3:	81 e9 18 0b 10 00    	sub    $0x100b18,%ecx
  100ac9:	b8 01 00 00 00       	mov    $0x1,%eax
  100ace:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ad0:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ad1:	09 44 24 14          	or     %eax,0x14(%esp)
  100ad5:	e9 aa fc ff ff       	jmp    100784 <console_vprintf+0x4d>

00100ada <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100ada:	8d 44 24 10          	lea    0x10(%esp),%eax
  100ade:	50                   	push   %eax
  100adf:	ff 74 24 10          	pushl  0x10(%esp)
  100ae3:	ff 74 24 10          	pushl  0x10(%esp)
  100ae7:	ff 74 24 10          	pushl  0x10(%esp)
  100aeb:	e8 47 fc ff ff       	call   100737 <console_vprintf>
  100af0:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100af3:	c3                   	ret    
