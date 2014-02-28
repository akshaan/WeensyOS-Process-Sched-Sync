
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
  100014:	e8 ae 02 00 00       	call   1002c7 <start>
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
  10006d:	e8 cb 01 00 00       	call   10023d <interrupt>

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
  1000a0:	a1 78 8d 10 00       	mov    0x108d78,%eax
  1000a5:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a7:	a1 7c 8d 10 00       	mov    0x108d7c,%eax
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
  1000bb:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000be:	83 b8 8c 83 10 00 01 	cmpl   $0x1,0x10838c(%eax)
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
  1000d1:	83 3d e8 83 10 00 01 	cmpl   $0x1,0x1083e8
  1000d8:	74 25                	je     1000ff <schedule+0x63>
  1000da:	83 3d 44 84 10 00 01 	cmpl   $0x1,0x108444
  1000e1:	b0 02                	mov    $0x2,%al
  1000e3:	74 1a                	je     1000ff <schedule+0x63>
  1000e5:	83 3d a0 84 10 00 01 	cmpl   $0x1,0x1084a0
  1000ec:	b0 03                	mov    $0x3,%al
  1000ee:	74 0f                	je     1000ff <schedule+0x63>
  1000f0:	31 c0                	xor    %eax,%eax
  1000f2:	83 3d fc 84 10 00 01 	cmpl   $0x1,0x1084fc
  1000f9:	0f 94 c0             	sete   %al
  1000fc:	c1 e0 02             	shl    $0x2,%eax
					next_pid = i;
					break;
				}
		}

		run(&proc_array[next_pid]);
  1000ff:	6b c0 5c             	imul   $0x5c,%eax,%eax
  100102:	83 ec 0c             	sub    $0xc,%esp
  100105:	05 44 83 10 00       	add    $0x108344,%eax
  10010a:	50                   	push   %eax
  10010b:	e8 dd 04 00 00       	call   1005ed <run>

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
  10011c:	8b 88 f0 83 10 00    	mov    0x1083f0(%eax),%ecx
  100122:	39 d9                	cmp    %ebx,%ecx
  100124:	7d 09                	jge    10012f <schedule+0x93>
  100126:	83 b8 e8 83 10 00 01 	cmpl   $0x1,0x1083e8(%eax)
  10012d:	74 02                	je     100131 <schedule+0x95>
  10012f:	89 d9                	mov    %ebx,%ecx
  100131:	83 c0 5c             	add    $0x5c,%eax
	if(scheduling_algorithm == 2){
	int min = 2222;
	pid_t next = pid;
	int i;
	
	for(i = 1; i < NPROCS; i++)
  100134:	3d 70 01 00 00       	cmp    $0x170,%eax
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
  10014a:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10014d:	83 b8 8c 83 10 00 01 	cmpl   $0x1,0x10838c(%eax)
  100154:	75 0f                	jne    100165 <schedule+0xc9>
  100156:	05 44 83 10 00       	add    $0x108344,%eax
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
	
		run(&proc_array[next]);
		}	


	if(scheduling_algorithm == 3){
  10016a:	83 f8 03             	cmp    $0x3,%eax
  10016d:	0f 85 a9 00 00 00    	jne    10021c <schedule+0x180>
  100173:	ba e8 83 10 00       	mov    $0x1083e8,%edx
  100178:	b0 01                	mov    $0x1,%al
		int flag = 0;

	
		for(i = 1; i < NPROCS; i++)
		{
			if(proc_array[i].p_state == P_RUNNABLE && proc_array[i].p_shares == 0)
  10017a:	83 3a 01             	cmpl   $0x1,(%edx)
  10017d:	75 0a                	jne    100189 <schedule+0xed>
  10017f:	83 7a 0c 00          	cmpl   $0x0,0xc(%edx)
  100183:	0f 84 76 ff ff ff    	je     1000ff <schedule+0x63>
		int i;
		pid_t next_pid = 0;	
		int flag = 0;

	
		for(i = 1; i < NPROCS; i++)
  100189:	40                   	inc    %eax
  10018a:	83 c2 5c             	add    $0x5c,%edx
  10018d:	83 f8 05             	cmp    $0x5,%eax
  100190:	75 e8                	jne    10017a <schedule+0xde>
  100192:	30 c0                	xor    %al,%al
  100194:	31 d2                	xor    %edx,%edx

		}

		for(i = 1; i < NPROCS; i++)
		{
			if(proc_array[i].p_shares != proc_array[i].p_count && proc_array[i].p_state == P_RUNNABLE)
  100196:	8b 88 f4 83 10 00    	mov    0x1083f4(%eax),%ecx
  10019c:	3b 88 f8 83 10 00    	cmp    0x1083f8(%eax),%ecx
  1001a2:	74 0e                	je     1001b2 <schedule+0x116>
  1001a4:	83 b8 e8 83 10 00 01 	cmpl   $0x1,0x1083e8(%eax)
  1001ab:	75 05                	jne    1001b2 <schedule+0x116>
  1001ad:	ba 01 00 00 00       	mov    $0x1,%edx
  1001b2:	83 c0 5c             	add    $0x5c,%eax
			if(proc_array[i].p_state == P_RUNNABLE && proc_array[i].p_shares == 0)
			{next_pid = i;goto run;}

		}

		for(i = 1; i < NPROCS; i++)
  1001b5:	3d 70 01 00 00       	cmp    $0x170,%eax
  1001ba:	75 da                	jne    100196 <schedule+0xfa>
			if(proc_array[i].p_shares != proc_array[i].p_count && proc_array[i].p_state == P_RUNNABLE)
				flag = 1;

		}

		if(flag == 0)
  1001bc:	85 d2                	test   %edx,%edx
  1001be:	75 28                	jne    1001e8 <schedule+0x14c>
		for(i = 1; i < NPROCS; i++)
		{
			proc_array[i].p_count = 0;
  1001c0:	c7 05 f8 83 10 00 00 	movl   $0x0,0x1083f8
  1001c7:	00 00 00 
  1001ca:	c7 05 54 84 10 00 00 	movl   $0x0,0x108454
  1001d1:	00 00 00 
  1001d4:	c7 05 b0 84 10 00 00 	movl   $0x0,0x1084b0
  1001db:	00 00 00 
  1001de:	c7 05 0c 85 10 00 00 	movl   $0x0,0x10850c
  1001e5:	00 00 00 
  1001e8:	ba f4 83 10 00       	mov    $0x1083f4,%edx
  1001ed:	b8 01 00 00 00       	mov    $0x1,%eax
		}


		for(i = 1; i < NPROCS; i++)
		{
			if(proc_array[i].p_state == P_RUNNABLE && proc_array[i].p_shares > proc_array[i].p_count)
  1001f2:	83 7a f4 01          	cmpl   $0x1,-0xc(%edx)
  1001f6:	75 0b                	jne    100203 <schedule+0x167>
  1001f8:	8b 0a                	mov    (%edx),%ecx
  1001fa:	3b 4a 04             	cmp    0x4(%edx),%ecx
  1001fd:	7e 04                	jle    100203 <schedule+0x167>
  1001ff:	89 c2                	mov    %eax,%edx
  100201:	eb 0b                	jmp    10020e <schedule+0x172>
		{
			proc_array[i].p_count = 0;
		}


		for(i = 1; i < NPROCS; i++)
  100203:	40                   	inc    %eax
  100204:	83 c2 5c             	add    $0x5c,%edx
  100207:	83 f8 05             	cmp    $0x5,%eax
  10020a:	75 e6                	jne    1001f2 <schedule+0x156>
  10020c:	31 d2                	xor    %edx,%edx
		
			{next_pid = i; break;}
			
		}
		
			proc_array[next_pid].p_count++;
  10020e:	6b d2 5c             	imul   $0x5c,%edx,%edx
  100211:	ff 82 9c 83 10 00    	incl   0x10839c(%edx)
  100217:	e9 e3 fe ff ff       	jmp    1000ff <schedule+0x63>
			run:
			run(&proc_array[i]);
	
}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10021c:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100222:	50                   	push   %eax
  100223:	68 ac 0b 10 00       	push   $0x100bac
  100228:	68 00 01 00 00       	push   $0x100
  10022d:	52                   	push   %edx
  10022e:	e8 5f 09 00 00       	call   100b92 <console_printf>
  100233:	83 c4 10             	add    $0x10,%esp
  100236:	a3 00 80 19 00       	mov    %eax,0x198000
  10023b:	eb fe                	jmp    10023b <schedule+0x19f>

0010023d <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10023d:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10023e:	a1 78 8d 10 00       	mov    0x108d78,%eax
  100243:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100248:	56                   	push   %esi
  100249:	53                   	push   %ebx
  10024a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10024e:	8d 78 04             	lea    0x4(%eax),%edi
  100251:	89 de                	mov    %ebx,%esi
  100253:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100255:	8b 53 28             	mov    0x28(%ebx),%edx
  100258:	83 ea 20             	sub    $0x20,%edx
  10025b:	83 fa 15             	cmp    $0x15,%edx
  10025e:	77 65                	ja     1002c5 <interrupt+0x88>
  100260:	ff 24 95 d0 0b 10 00 	jmp    *0x100bd0(,%edx,4)

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100267:	e8 30 fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10026c:	a1 78 8d 10 00       	mov    0x108d78,%eax
		current->p_exit_status = reg->reg_eax;
  100271:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100274:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10027b:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10027e:	e8 19 fe ff ff       	call   10009c <schedule>

	case INT_SYS_USER1: 
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		current->p_priority = reg->reg_eax;
  100283:	a1 78 8d 10 00       	mov    0x108d78,%eax
  100288:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10028b:	89 50 50             	mov    %edx,0x50(%eax)
  10028e:	eb 13                	jmp    1002a3 <interrupt+0x66>
		run(current);


	case INT_SYS_USER2: // LOCK
		/* Your code here (if you want). */
	 	while(lock == 1){};
  100290:	8b 15 04 80 19 00    	mov    0x198004,%edx
  100296:	4a                   	dec    %edx
  100297:	74 f7                	je     100290 <interrupt+0x53>
		lock = 1;
  100299:	c7 05 04 80 19 00 01 	movl   $0x1,0x198004
  1002a0:	00 00 00 
		run(current);
  1002a3:	83 ec 0c             	sub    $0xc,%esp
  1002a6:	50                   	push   %eax
  1002a7:	e8 41 03 00 00       	call   1005ed <run>

	case INT_SYS_USER3: // UNLOCK
		lock = 0;
  1002ac:	c7 05 04 80 19 00 00 	movl   $0x0,0x198004
  1002b3:	00 00 00 
  1002b6:	eb eb                	jmp    1002a3 <interrupt+0x66>
		run(current);


	case INT_SYS_USER4: // Set shares for process
		current->p_shares = reg->reg_eax;
  1002b8:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002bb:	89 50 54             	mov    %edx,0x54(%eax)
  1002be:	eb e3                	jmp    1002a3 <interrupt+0x66>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1002c0:	e8 d7 fd ff ff       	call   10009c <schedule>
  1002c5:	eb fe                	jmp    1002c5 <interrupt+0x88>

001002c7 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1002c7:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002c8:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1002cd:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002ce:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1002d0:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002d1:	bb a0 83 10 00       	mov    $0x1083a0,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1002d6:	e8 f1 00 00 00       	call   1003cc <segments_init>
	interrupt_controller_init(0);
  1002db:	83 ec 0c             	sub    $0xc,%esp
  1002de:	6a 00                	push   $0x0
  1002e0:	e8 e2 01 00 00       	call   1004c7 <interrupt_controller_init>
	console_clear();
  1002e5:	e8 66 02 00 00       	call   100550 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002ea:	83 c4 0c             	add    $0xc,%esp
  1002ed:	68 cc 01 00 00       	push   $0x1cc
  1002f2:	6a 00                	push   $0x0
  1002f4:	68 44 83 10 00       	push   $0x108344
  1002f9:	e8 32 04 00 00       	call   100730 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002fe:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100301:	c7 05 44 83 10 00 00 	movl   $0x0,0x108344
  100308:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10030b:	c7 05 8c 83 10 00 00 	movl   $0x0,0x10838c
  100312:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100315:	c7 05 a0 83 10 00 01 	movl   $0x1,0x1083a0
  10031c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10031f:	c7 05 e8 83 10 00 00 	movl   $0x0,0x1083e8
  100326:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100329:	c7 05 fc 83 10 00 02 	movl   $0x2,0x1083fc
  100330:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100333:	c7 05 44 84 10 00 00 	movl   $0x0,0x108444
  10033a:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10033d:	c7 05 58 84 10 00 03 	movl   $0x3,0x108458
  100344:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100347:	c7 05 a0 84 10 00 00 	movl   $0x0,0x1084a0
  10034e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100351:	c7 05 b4 84 10 00 04 	movl   $0x4,0x1084b4
  100358:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10035b:	c7 05 fc 84 10 00 00 	movl   $0x0,0x1084fc
  100362:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100365:	83 ec 0c             	sub    $0xc,%esp
  100368:	53                   	push   %ebx
  100369:	e8 96 02 00 00       	call   100604 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10036e:	58                   	pop    %eax
  10036f:	5a                   	pop    %edx
  100370:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100373:	89 7b 40             	mov    %edi,0x40(%ebx)
		// Set initial priorities to zero
		proc->p_priority = 0;

		// Set initial shares and count
		proc->p_shares = 0;
		proc->p_count = 0;
  100376:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10037c:	50                   	push   %eax
  10037d:	56                   	push   %esi
		// Set initial priorities to zero
		proc->p_priority = 0;

		// Set initial shares and count
		proc->p_shares = 0;
		proc->p_count = 0;
  10037e:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10037f:	e8 bc 02 00 00       	call   100640 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100384:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100387:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

		// Set initial priorities to zero
		proc->p_priority = 0;
  10038e:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)

		// Set initial shares and count
		proc->p_shares = 0;
  100395:	c7 43 54 00 00 00 00 	movl   $0x0,0x54(%ebx)
		proc->p_count = 0;
  10039c:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  1003a3:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003a6:	83 fe 04             	cmp    $0x4,%esi
  1003a9:	75 ba                	jne    100365 <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;

	// Switch to the first process.
	run(&proc_array[1]);
  1003ab:	83 ec 0c             	sub    $0xc,%esp
  1003ae:	68 a0 83 10 00       	push   $0x1083a0
		proc->p_count = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1003b3:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1003ba:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;
  1003bd:	c7 05 7c 8d 10 00 03 	movl   $0x3,0x108d7c
  1003c4:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1003c7:	e8 21 02 00 00       	call   1005ed <run>

001003cc <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003cc:	b8 10 85 10 00       	mov    $0x108510,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003d1:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003d6:	89 c2                	mov    %eax,%edx
  1003d8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003db:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003dc:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1003e1:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003e4:	66 a3 92 1c 10 00    	mov    %ax,0x101c92
  1003ea:	c1 e8 18             	shr    $0x18,%eax
  1003ed:	88 15 94 1c 10 00    	mov    %dl,0x101c94
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003f3:	ba 78 85 10 00       	mov    $0x108578,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003f8:	a2 97 1c 10 00       	mov    %al,0x101c97
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003fd:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003ff:	66 c7 05 90 1c 10 00 	movw   $0x68,0x101c90
  100406:	68 00 
  100408:	c6 05 96 1c 10 00 40 	movb   $0x40,0x101c96
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10040f:	c6 05 95 1c 10 00 89 	movb   $0x89,0x101c95

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100416:	c7 05 14 85 10 00 00 	movl   $0x180000,0x108514
  10041d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100420:	66 c7 05 18 85 10 00 	movw   $0x10,0x108518
  100427:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100429:	66 89 0c c5 78 85 10 	mov    %cx,0x108578(,%eax,8)
  100430:	00 
  100431:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100438:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10043d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100442:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100447:	40                   	inc    %eax
  100448:	3d 00 01 00 00       	cmp    $0x100,%eax
  10044d:	75 da                	jne    100429 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10044f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100454:	ba 78 85 10 00       	mov    $0x108578,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100459:	66 a3 78 86 10 00    	mov    %ax,0x108678
  10045f:	c1 e8 10             	shr    $0x10,%eax
  100462:	66 a3 7e 86 10 00    	mov    %ax,0x10867e
  100468:	b8 30 00 00 00       	mov    $0x30,%eax
  10046d:	66 c7 05 7a 86 10 00 	movw   $0x8,0x10867a
  100474:	08 00 
  100476:	c6 05 7c 86 10 00 00 	movb   $0x0,0x10867c
  10047d:	c6 05 7d 86 10 00 8e 	movb   $0x8e,0x10867d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100484:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10048b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100492:	66 89 0c c5 78 85 10 	mov    %cx,0x108578(,%eax,8)
  100499:	00 
  10049a:	c1 e9 10             	shr    $0x10,%ecx
  10049d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004a2:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1004a7:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1004ac:	40                   	inc    %eax
  1004ad:	83 f8 3a             	cmp    $0x3a,%eax
  1004b0:	75 d2                	jne    100484 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1004b2:	b0 28                	mov    $0x28,%al
  1004b4:	0f 01 15 58 1c 10 00 	lgdtl  0x101c58
  1004bb:	0f 00 d8             	ltr    %ax
  1004be:	0f 01 1d 60 1c 10 00 	lidtl  0x101c60
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1004c5:	5b                   	pop    %ebx
  1004c6:	c3                   	ret    

001004c7 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1004c7:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1004c8:	b0 ff                	mov    $0xff,%al
  1004ca:	57                   	push   %edi
  1004cb:	56                   	push   %esi
  1004cc:	53                   	push   %ebx
  1004cd:	bb 21 00 00 00       	mov    $0x21,%ebx
  1004d2:	89 da                	mov    %ebx,%edx
  1004d4:	ee                   	out    %al,(%dx)
  1004d5:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1004da:	89 ca                	mov    %ecx,%edx
  1004dc:	ee                   	out    %al,(%dx)
  1004dd:	be 11 00 00 00       	mov    $0x11,%esi
  1004e2:	bf 20 00 00 00       	mov    $0x20,%edi
  1004e7:	89 f0                	mov    %esi,%eax
  1004e9:	89 fa                	mov    %edi,%edx
  1004eb:	ee                   	out    %al,(%dx)
  1004ec:	b0 20                	mov    $0x20,%al
  1004ee:	89 da                	mov    %ebx,%edx
  1004f0:	ee                   	out    %al,(%dx)
  1004f1:	b0 04                	mov    $0x4,%al
  1004f3:	ee                   	out    %al,(%dx)
  1004f4:	b0 03                	mov    $0x3,%al
  1004f6:	ee                   	out    %al,(%dx)
  1004f7:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004fc:	89 f0                	mov    %esi,%eax
  1004fe:	89 ea                	mov    %ebp,%edx
  100500:	ee                   	out    %al,(%dx)
  100501:	b0 28                	mov    $0x28,%al
  100503:	89 ca                	mov    %ecx,%edx
  100505:	ee                   	out    %al,(%dx)
  100506:	b0 02                	mov    $0x2,%al
  100508:	ee                   	out    %al,(%dx)
  100509:	b0 01                	mov    $0x1,%al
  10050b:	ee                   	out    %al,(%dx)
  10050c:	b0 68                	mov    $0x68,%al
  10050e:	89 fa                	mov    %edi,%edx
  100510:	ee                   	out    %al,(%dx)
  100511:	be 0a 00 00 00       	mov    $0xa,%esi
  100516:	89 f0                	mov    %esi,%eax
  100518:	ee                   	out    %al,(%dx)
  100519:	b0 68                	mov    $0x68,%al
  10051b:	89 ea                	mov    %ebp,%edx
  10051d:	ee                   	out    %al,(%dx)
  10051e:	89 f0                	mov    %esi,%eax
  100520:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100521:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100526:	89 da                	mov    %ebx,%edx
  100528:	19 c0                	sbb    %eax,%eax
  10052a:	f7 d0                	not    %eax
  10052c:	05 ff 00 00 00       	add    $0xff,%eax
  100531:	ee                   	out    %al,(%dx)
  100532:	b0 ff                	mov    $0xff,%al
  100534:	89 ca                	mov    %ecx,%edx
  100536:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100537:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10053c:	74 0d                	je     10054b <interrupt_controller_init+0x84>
  10053e:	b2 43                	mov    $0x43,%dl
  100540:	b0 34                	mov    $0x34,%al
  100542:	ee                   	out    %al,(%dx)
  100543:	b0 9c                	mov    $0x9c,%al
  100545:	b2 40                	mov    $0x40,%dl
  100547:	ee                   	out    %al,(%dx)
  100548:	b0 2e                	mov    $0x2e,%al
  10054a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10054b:	5b                   	pop    %ebx
  10054c:	5e                   	pop    %esi
  10054d:	5f                   	pop    %edi
  10054e:	5d                   	pop    %ebp
  10054f:	c3                   	ret    

00100550 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100550:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100551:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100553:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100554:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10055b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10055e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100564:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10056a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10056d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100572:	75 ea                	jne    10055e <console_clear+0xe>
  100574:	be d4 03 00 00       	mov    $0x3d4,%esi
  100579:	b0 0e                	mov    $0xe,%al
  10057b:	89 f2                	mov    %esi,%edx
  10057d:	ee                   	out    %al,(%dx)
  10057e:	31 c9                	xor    %ecx,%ecx
  100580:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100585:	88 c8                	mov    %cl,%al
  100587:	89 da                	mov    %ebx,%edx
  100589:	ee                   	out    %al,(%dx)
  10058a:	b0 0f                	mov    $0xf,%al
  10058c:	89 f2                	mov    %esi,%edx
  10058e:	ee                   	out    %al,(%dx)
  10058f:	88 c8                	mov    %cl,%al
  100591:	89 da                	mov    %ebx,%edx
  100593:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100594:	5b                   	pop    %ebx
  100595:	5e                   	pop    %esi
  100596:	c3                   	ret    

00100597 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100597:	ba 64 00 00 00       	mov    $0x64,%edx
  10059c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10059d:	a8 01                	test   $0x1,%al
  10059f:	74 45                	je     1005e6 <console_read_digit+0x4f>
  1005a1:	b2 60                	mov    $0x60,%dl
  1005a3:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1005a4:	8d 50 fe             	lea    -0x2(%eax),%edx
  1005a7:	80 fa 08             	cmp    $0x8,%dl
  1005aa:	77 05                	ja     1005b1 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1005ac:	0f b6 c0             	movzbl %al,%eax
  1005af:	48                   	dec    %eax
  1005b0:	c3                   	ret    
	else if (data == 0x0B)
  1005b1:	3c 0b                	cmp    $0xb,%al
  1005b3:	74 35                	je     1005ea <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1005b5:	8d 50 b9             	lea    -0x47(%eax),%edx
  1005b8:	80 fa 02             	cmp    $0x2,%dl
  1005bb:	77 07                	ja     1005c4 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1005bd:	0f b6 c0             	movzbl %al,%eax
  1005c0:	83 e8 40             	sub    $0x40,%eax
  1005c3:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1005c4:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1005c7:	80 fa 02             	cmp    $0x2,%dl
  1005ca:	77 07                	ja     1005d3 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1005cc:	0f b6 c0             	movzbl %al,%eax
  1005cf:	83 e8 47             	sub    $0x47,%eax
  1005d2:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1005d3:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1005d6:	80 fa 02             	cmp    $0x2,%dl
  1005d9:	77 07                	ja     1005e2 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1005db:	0f b6 c0             	movzbl %al,%eax
  1005de:	83 e8 4e             	sub    $0x4e,%eax
  1005e1:	c3                   	ret    
	else if (data == 0x53)
  1005e2:	3c 53                	cmp    $0x53,%al
  1005e4:	74 04                	je     1005ea <console_read_digit+0x53>
  1005e6:	83 c8 ff             	or     $0xffffffff,%eax
  1005e9:	c3                   	ret    
  1005ea:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1005ec:	c3                   	ret    

001005ed <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1005ed:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1005f1:	a3 78 8d 10 00       	mov    %eax,0x108d78

	asm volatile("movl %0,%%esp\n\t"
  1005f6:	83 c0 04             	add    $0x4,%eax
  1005f9:	89 c4                	mov    %eax,%esp
  1005fb:	61                   	popa   
  1005fc:	07                   	pop    %es
  1005fd:	1f                   	pop    %ds
  1005fe:	83 c4 08             	add    $0x8,%esp
  100601:	cf                   	iret   
  100602:	eb fe                	jmp    100602 <run+0x15>

00100604 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100604:	53                   	push   %ebx
  100605:	83 ec 0c             	sub    $0xc,%esp
  100608:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10060c:	6a 44                	push   $0x44
  10060e:	6a 00                	push   $0x0
  100610:	8d 43 04             	lea    0x4(%ebx),%eax
  100613:	50                   	push   %eax
  100614:	e8 17 01 00 00       	call   100730 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100619:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10061f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100625:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10062b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100631:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100638:	83 c4 18             	add    $0x18,%esp
  10063b:	5b                   	pop    %ebx
  10063c:	c3                   	ret    
  10063d:	90                   	nop
  10063e:	90                   	nop
  10063f:	90                   	nop

00100640 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100640:	55                   	push   %ebp
  100641:	57                   	push   %edi
  100642:	56                   	push   %esi
  100643:	53                   	push   %ebx
  100644:	83 ec 1c             	sub    $0x1c,%esp
  100647:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10064b:	83 f8 03             	cmp    $0x3,%eax
  10064e:	7f 04                	jg     100654 <program_loader+0x14>
  100650:	85 c0                	test   %eax,%eax
  100652:	79 02                	jns    100656 <program_loader+0x16>
  100654:	eb fe                	jmp    100654 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100656:	8b 34 c5 98 1c 10 00 	mov    0x101c98(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10065d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100663:	74 02                	je     100667 <program_loader+0x27>
  100665:	eb fe                	jmp    100665 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100667:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10066a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10066e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100670:	c1 e5 05             	shl    $0x5,%ebp
  100673:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100676:	eb 3f                	jmp    1006b7 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100678:	83 3b 01             	cmpl   $0x1,(%ebx)
  10067b:	75 37                	jne    1006b4 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10067d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100680:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100683:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100686:	01 c7                	add    %eax,%edi
	memsz += va;
  100688:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10068a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10068f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100693:	52                   	push   %edx
  100694:	89 fa                	mov    %edi,%edx
  100696:	29 c2                	sub    %eax,%edx
  100698:	52                   	push   %edx
  100699:	8b 53 04             	mov    0x4(%ebx),%edx
  10069c:	01 f2                	add    %esi,%edx
  10069e:	52                   	push   %edx
  10069f:	50                   	push   %eax
  1006a0:	e8 27 00 00 00       	call   1006cc <memcpy>
  1006a5:	83 c4 10             	add    $0x10,%esp
  1006a8:	eb 04                	jmp    1006ae <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1006aa:	c6 07 00             	movb   $0x0,(%edi)
  1006ad:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1006ae:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1006b2:	72 f6                	jb     1006aa <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1006b4:	83 c3 20             	add    $0x20,%ebx
  1006b7:	39 eb                	cmp    %ebp,%ebx
  1006b9:	72 bd                	jb     100678 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1006bb:	8b 56 18             	mov    0x18(%esi),%edx
  1006be:	8b 44 24 34          	mov    0x34(%esp),%eax
  1006c2:	89 10                	mov    %edx,(%eax)
}
  1006c4:	83 c4 1c             	add    $0x1c,%esp
  1006c7:	5b                   	pop    %ebx
  1006c8:	5e                   	pop    %esi
  1006c9:	5f                   	pop    %edi
  1006ca:	5d                   	pop    %ebp
  1006cb:	c3                   	ret    

001006cc <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1006cc:	56                   	push   %esi
  1006cd:	31 d2                	xor    %edx,%edx
  1006cf:	53                   	push   %ebx
  1006d0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1006d4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1006d8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006dc:	eb 08                	jmp    1006e6 <memcpy+0x1a>
		*d++ = *s++;
  1006de:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1006e1:	4e                   	dec    %esi
  1006e2:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1006e5:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006e6:	85 f6                	test   %esi,%esi
  1006e8:	75 f4                	jne    1006de <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1006ea:	5b                   	pop    %ebx
  1006eb:	5e                   	pop    %esi
  1006ec:	c3                   	ret    

001006ed <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1006ed:	57                   	push   %edi
  1006ee:	56                   	push   %esi
  1006ef:	53                   	push   %ebx
  1006f0:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006f4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006f8:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006fc:	39 c7                	cmp    %eax,%edi
  1006fe:	73 26                	jae    100726 <memmove+0x39>
  100700:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100703:	39 c6                	cmp    %eax,%esi
  100705:	76 1f                	jbe    100726 <memmove+0x39>
		s += n, d += n;
  100707:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10070a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10070c:	eb 07                	jmp    100715 <memmove+0x28>
			*--d = *--s;
  10070e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100711:	4a                   	dec    %edx
  100712:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100715:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100716:	85 d2                	test   %edx,%edx
  100718:	75 f4                	jne    10070e <memmove+0x21>
  10071a:	eb 10                	jmp    10072c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10071c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10071f:	4a                   	dec    %edx
  100720:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100723:	41                   	inc    %ecx
  100724:	eb 02                	jmp    100728 <memmove+0x3b>
  100726:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100728:	85 d2                	test   %edx,%edx
  10072a:	75 f0                	jne    10071c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10072c:	5b                   	pop    %ebx
  10072d:	5e                   	pop    %esi
  10072e:	5f                   	pop    %edi
  10072f:	c3                   	ret    

00100730 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100730:	53                   	push   %ebx
  100731:	8b 44 24 08          	mov    0x8(%esp),%eax
  100735:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100739:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10073d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10073f:	eb 04                	jmp    100745 <memset+0x15>
		*p++ = c;
  100741:	88 1a                	mov    %bl,(%edx)
  100743:	49                   	dec    %ecx
  100744:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100745:	85 c9                	test   %ecx,%ecx
  100747:	75 f8                	jne    100741 <memset+0x11>
		*p++ = c;
	return v;
}
  100749:	5b                   	pop    %ebx
  10074a:	c3                   	ret    

0010074b <strlen>:

size_t
strlen(const char *s)
{
  10074b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10074f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100751:	eb 01                	jmp    100754 <strlen+0x9>
		++n;
  100753:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100754:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100758:	75 f9                	jne    100753 <strlen+0x8>
		++n;
	return n;
}
  10075a:	c3                   	ret    

0010075b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10075b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10075f:	31 c0                	xor    %eax,%eax
  100761:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100765:	eb 01                	jmp    100768 <strnlen+0xd>
		++n;
  100767:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100768:	39 d0                	cmp    %edx,%eax
  10076a:	74 06                	je     100772 <strnlen+0x17>
  10076c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100770:	75 f5                	jne    100767 <strnlen+0xc>
		++n;
	return n;
}
  100772:	c3                   	ret    

00100773 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100773:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100774:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100779:	53                   	push   %ebx
  10077a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10077c:	76 05                	jbe    100783 <console_putc+0x10>
  10077e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100783:	80 fa 0a             	cmp    $0xa,%dl
  100786:	75 2c                	jne    1007b4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100788:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10078e:	be 50 00 00 00       	mov    $0x50,%esi
  100793:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100795:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100798:	99                   	cltd   
  100799:	f7 fe                	idiv   %esi
  10079b:	89 de                	mov    %ebx,%esi
  10079d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10079f:	eb 07                	jmp    1007a8 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1007a1:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007a4:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1007a5:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007a8:	83 f8 50             	cmp    $0x50,%eax
  1007ab:	75 f4                	jne    1007a1 <console_putc+0x2e>
  1007ad:	29 d0                	sub    %edx,%eax
  1007af:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1007b2:	eb 0b                	jmp    1007bf <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1007b4:	0f b6 d2             	movzbl %dl,%edx
  1007b7:	09 ca                	or     %ecx,%edx
  1007b9:	66 89 13             	mov    %dx,(%ebx)
  1007bc:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1007bf:	5b                   	pop    %ebx
  1007c0:	5e                   	pop    %esi
  1007c1:	c3                   	ret    

001007c2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1007c2:	56                   	push   %esi
  1007c3:	53                   	push   %ebx
  1007c4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1007c8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1007cb:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1007cf:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1007d4:	75 04                	jne    1007da <fill_numbuf+0x18>
  1007d6:	85 d2                	test   %edx,%edx
  1007d8:	74 10                	je     1007ea <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1007da:	89 d0                	mov    %edx,%eax
  1007dc:	31 d2                	xor    %edx,%edx
  1007de:	f7 f1                	div    %ecx
  1007e0:	4b                   	dec    %ebx
  1007e1:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1007e4:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1007e6:	89 c2                	mov    %eax,%edx
  1007e8:	eb ec                	jmp    1007d6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1007ea:	89 d8                	mov    %ebx,%eax
  1007ec:	5b                   	pop    %ebx
  1007ed:	5e                   	pop    %esi
  1007ee:	c3                   	ret    

001007ef <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1007ef:	55                   	push   %ebp
  1007f0:	57                   	push   %edi
  1007f1:	56                   	push   %esi
  1007f2:	53                   	push   %ebx
  1007f3:	83 ec 38             	sub    $0x38,%esp
  1007f6:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007fa:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007fe:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100802:	e9 60 03 00 00       	jmp    100b67 <console_vprintf+0x378>
		if (*format != '%') {
  100807:	80 fa 25             	cmp    $0x25,%dl
  10080a:	74 13                	je     10081f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10080c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100810:	0f b6 d2             	movzbl %dl,%edx
  100813:	89 f0                	mov    %esi,%eax
  100815:	e8 59 ff ff ff       	call   100773 <console_putc>
  10081a:	e9 45 03 00 00       	jmp    100b64 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10081f:	47                   	inc    %edi
  100820:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100827:	00 
  100828:	eb 12                	jmp    10083c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10082a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10082b:	8a 11                	mov    (%ecx),%dl
  10082d:	84 d2                	test   %dl,%dl
  10082f:	74 1a                	je     10084b <console_vprintf+0x5c>
  100831:	89 e8                	mov    %ebp,%eax
  100833:	38 c2                	cmp    %al,%dl
  100835:	75 f3                	jne    10082a <console_vprintf+0x3b>
  100837:	e9 3f 03 00 00       	jmp    100b7b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10083c:	8a 17                	mov    (%edi),%dl
  10083e:	84 d2                	test   %dl,%dl
  100840:	74 0b                	je     10084d <console_vprintf+0x5e>
  100842:	b9 28 0c 10 00       	mov    $0x100c28,%ecx
  100847:	89 d5                	mov    %edx,%ebp
  100849:	eb e0                	jmp    10082b <console_vprintf+0x3c>
  10084b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10084d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100850:	3c 08                	cmp    $0x8,%al
  100852:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100859:	00 
  10085a:	76 13                	jbe    10086f <console_vprintf+0x80>
  10085c:	eb 1d                	jmp    10087b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10085e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100863:	0f be c0             	movsbl %al,%eax
  100866:	47                   	inc    %edi
  100867:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10086b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10086f:	8a 07                	mov    (%edi),%al
  100871:	8d 50 d0             	lea    -0x30(%eax),%edx
  100874:	80 fa 09             	cmp    $0x9,%dl
  100877:	76 e5                	jbe    10085e <console_vprintf+0x6f>
  100879:	eb 18                	jmp    100893 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10087b:	80 fa 2a             	cmp    $0x2a,%dl
  10087e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100885:	ff 
  100886:	75 0b                	jne    100893 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100888:	83 c3 04             	add    $0x4,%ebx
			++format;
  10088b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10088c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10088f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100893:	83 cd ff             	or     $0xffffffff,%ebp
  100896:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100899:	75 37                	jne    1008d2 <console_vprintf+0xe3>
			++format;
  10089b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10089c:	31 ed                	xor    %ebp,%ebp
  10089e:	8a 07                	mov    (%edi),%al
  1008a0:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008a3:	80 fa 09             	cmp    $0x9,%dl
  1008a6:	76 0d                	jbe    1008b5 <console_vprintf+0xc6>
  1008a8:	eb 17                	jmp    1008c1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1008aa:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1008ad:	0f be c0             	movsbl %al,%eax
  1008b0:	47                   	inc    %edi
  1008b1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1008b5:	8a 07                	mov    (%edi),%al
  1008b7:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008ba:	80 fa 09             	cmp    $0x9,%dl
  1008bd:	76 eb                	jbe    1008aa <console_vprintf+0xbb>
  1008bf:	eb 11                	jmp    1008d2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1008c1:	3c 2a                	cmp    $0x2a,%al
  1008c3:	75 0b                	jne    1008d0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1008c5:	83 c3 04             	add    $0x4,%ebx
				++format;
  1008c8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1008c9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1008cc:	85 ed                	test   %ebp,%ebp
  1008ce:	79 02                	jns    1008d2 <console_vprintf+0xe3>
  1008d0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1008d2:	8a 07                	mov    (%edi),%al
  1008d4:	3c 64                	cmp    $0x64,%al
  1008d6:	74 34                	je     10090c <console_vprintf+0x11d>
  1008d8:	7f 1d                	jg     1008f7 <console_vprintf+0x108>
  1008da:	3c 58                	cmp    $0x58,%al
  1008dc:	0f 84 a2 00 00 00    	je     100984 <console_vprintf+0x195>
  1008e2:	3c 63                	cmp    $0x63,%al
  1008e4:	0f 84 bf 00 00 00    	je     1009a9 <console_vprintf+0x1ba>
  1008ea:	3c 43                	cmp    $0x43,%al
  1008ec:	0f 85 d0 00 00 00    	jne    1009c2 <console_vprintf+0x1d3>
  1008f2:	e9 a3 00 00 00       	jmp    10099a <console_vprintf+0x1ab>
  1008f7:	3c 75                	cmp    $0x75,%al
  1008f9:	74 4d                	je     100948 <console_vprintf+0x159>
  1008fb:	3c 78                	cmp    $0x78,%al
  1008fd:	74 5c                	je     10095b <console_vprintf+0x16c>
  1008ff:	3c 73                	cmp    $0x73,%al
  100901:	0f 85 bb 00 00 00    	jne    1009c2 <console_vprintf+0x1d3>
  100907:	e9 86 00 00 00       	jmp    100992 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  10090c:	83 c3 04             	add    $0x4,%ebx
  10090f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100912:	89 d1                	mov    %edx,%ecx
  100914:	c1 f9 1f             	sar    $0x1f,%ecx
  100917:	89 0c 24             	mov    %ecx,(%esp)
  10091a:	31 ca                	xor    %ecx,%edx
  10091c:	55                   	push   %ebp
  10091d:	29 ca                	sub    %ecx,%edx
  10091f:	68 30 0c 10 00       	push   $0x100c30
  100924:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100929:	8d 44 24 40          	lea    0x40(%esp),%eax
  10092d:	e8 90 fe ff ff       	call   1007c2 <fill_numbuf>
  100932:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100936:	58                   	pop    %eax
  100937:	5a                   	pop    %edx
  100938:	ba 01 00 00 00       	mov    $0x1,%edx
  10093d:	8b 04 24             	mov    (%esp),%eax
  100940:	83 e0 01             	and    $0x1,%eax
  100943:	e9 a5 00 00 00       	jmp    1009ed <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100948:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10094b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100950:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100953:	55                   	push   %ebp
  100954:	68 30 0c 10 00       	push   $0x100c30
  100959:	eb 11                	jmp    10096c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10095b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10095e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100961:	55                   	push   %ebp
  100962:	68 44 0c 10 00       	push   $0x100c44
  100967:	b9 10 00 00 00       	mov    $0x10,%ecx
  10096c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100970:	e8 4d fe ff ff       	call   1007c2 <fill_numbuf>
  100975:	ba 01 00 00 00       	mov    $0x1,%edx
  10097a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10097e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100980:	59                   	pop    %ecx
  100981:	59                   	pop    %ecx
  100982:	eb 69                	jmp    1009ed <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100984:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100987:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10098a:	55                   	push   %ebp
  10098b:	68 30 0c 10 00       	push   $0x100c30
  100990:	eb d5                	jmp    100967 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100992:	83 c3 04             	add    $0x4,%ebx
  100995:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100998:	eb 40                	jmp    1009da <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10099a:	83 c3 04             	add    $0x4,%ebx
  10099d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009a0:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1009a4:	e9 bd 01 00 00       	jmp    100b66 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009a9:	83 c3 04             	add    $0x4,%ebx
  1009ac:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1009af:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1009b3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1009b8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009bc:	88 44 24 24          	mov    %al,0x24(%esp)
  1009c0:	eb 27                	jmp    1009e9 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1009c2:	84 c0                	test   %al,%al
  1009c4:	75 02                	jne    1009c8 <console_vprintf+0x1d9>
  1009c6:	b0 25                	mov    $0x25,%al
  1009c8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1009cc:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1009d1:	80 3f 00             	cmpb   $0x0,(%edi)
  1009d4:	74 0a                	je     1009e0 <console_vprintf+0x1f1>
  1009d6:	8d 44 24 24          	lea    0x24(%esp),%eax
  1009da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009de:	eb 09                	jmp    1009e9 <console_vprintf+0x1fa>
				format--;
  1009e0:	8d 54 24 24          	lea    0x24(%esp),%edx
  1009e4:	4f                   	dec    %edi
  1009e5:	89 54 24 04          	mov    %edx,0x4(%esp)
  1009e9:	31 d2                	xor    %edx,%edx
  1009eb:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009ed:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1009ef:	83 fd ff             	cmp    $0xffffffff,%ebp
  1009f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009f9:	74 1f                	je     100a1a <console_vprintf+0x22b>
  1009fb:	89 04 24             	mov    %eax,(%esp)
  1009fe:	eb 01                	jmp    100a01 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a00:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a01:	39 e9                	cmp    %ebp,%ecx
  100a03:	74 0a                	je     100a0f <console_vprintf+0x220>
  100a05:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a09:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a0d:	75 f1                	jne    100a00 <console_vprintf+0x211>
  100a0f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a12:	89 0c 24             	mov    %ecx,(%esp)
  100a15:	eb 1f                	jmp    100a36 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a17:	42                   	inc    %edx
  100a18:	eb 09                	jmp    100a23 <console_vprintf+0x234>
  100a1a:	89 d1                	mov    %edx,%ecx
  100a1c:	8b 14 24             	mov    (%esp),%edx
  100a1f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a23:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a27:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a2b:	75 ea                	jne    100a17 <console_vprintf+0x228>
  100a2d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a31:	89 14 24             	mov    %edx,(%esp)
  100a34:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a36:	85 c0                	test   %eax,%eax
  100a38:	74 0c                	je     100a46 <console_vprintf+0x257>
  100a3a:	84 d2                	test   %dl,%dl
  100a3c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a43:	00 
  100a44:	75 24                	jne    100a6a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a46:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a4b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a52:	00 
  100a53:	75 15                	jne    100a6a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a55:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a59:	83 e0 08             	and    $0x8,%eax
  100a5c:	83 f8 01             	cmp    $0x1,%eax
  100a5f:	19 c9                	sbb    %ecx,%ecx
  100a61:	f7 d1                	not    %ecx
  100a63:	83 e1 20             	and    $0x20,%ecx
  100a66:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a6a:	3b 2c 24             	cmp    (%esp),%ebp
  100a6d:	7e 0d                	jle    100a7c <console_vprintf+0x28d>
  100a6f:	84 d2                	test   %dl,%dl
  100a71:	74 40                	je     100ab3 <console_vprintf+0x2c4>
			zeros = precision - len;
  100a73:	2b 2c 24             	sub    (%esp),%ebp
  100a76:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a7a:	eb 3f                	jmp    100abb <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a7c:	84 d2                	test   %dl,%dl
  100a7e:	74 33                	je     100ab3 <console_vprintf+0x2c4>
  100a80:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a84:	83 e0 06             	and    $0x6,%eax
  100a87:	83 f8 02             	cmp    $0x2,%eax
  100a8a:	75 27                	jne    100ab3 <console_vprintf+0x2c4>
  100a8c:	45                   	inc    %ebp
  100a8d:	75 24                	jne    100ab3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a8f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a91:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a94:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a99:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a9c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a9f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100aa3:	7d 0e                	jge    100ab3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100aa5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100aa9:	29 ca                	sub    %ecx,%edx
  100aab:	29 c2                	sub    %eax,%edx
  100aad:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ab1:	eb 08                	jmp    100abb <console_vprintf+0x2cc>
  100ab3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100aba:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100abb:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100abf:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ac1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100ac5:	2b 2c 24             	sub    (%esp),%ebp
  100ac8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100acd:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ad0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100ad3:	29 c5                	sub    %eax,%ebp
  100ad5:	89 f0                	mov    %esi,%eax
  100ad7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100adb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100adf:	eb 0f                	jmp    100af0 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100ae1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ae5:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aea:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100aeb:	e8 83 fc ff ff       	call   100773 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100af0:	85 ed                	test   %ebp,%ebp
  100af2:	7e 07                	jle    100afb <console_vprintf+0x30c>
  100af4:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100af9:	74 e6                	je     100ae1 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100afb:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b00:	89 c6                	mov    %eax,%esi
  100b02:	74 23                	je     100b27 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b04:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b09:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b0d:	e8 61 fc ff ff       	call   100773 <console_putc>
  100b12:	89 c6                	mov    %eax,%esi
  100b14:	eb 11                	jmp    100b27 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b16:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b1a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b1f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b20:	e8 4e fc ff ff       	call   100773 <console_putc>
  100b25:	eb 06                	jmp    100b2d <console_vprintf+0x33e>
  100b27:	89 f0                	mov    %esi,%eax
  100b29:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b2d:	85 f6                	test   %esi,%esi
  100b2f:	7f e5                	jg     100b16 <console_vprintf+0x327>
  100b31:	8b 34 24             	mov    (%esp),%esi
  100b34:	eb 15                	jmp    100b4b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b36:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b3a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b3b:	0f b6 11             	movzbl (%ecx),%edx
  100b3e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b42:	e8 2c fc ff ff       	call   100773 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b47:	ff 44 24 04          	incl   0x4(%esp)
  100b4b:	85 f6                	test   %esi,%esi
  100b4d:	7f e7                	jg     100b36 <console_vprintf+0x347>
  100b4f:	eb 0f                	jmp    100b60 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b51:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b55:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b5a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b5b:	e8 13 fc ff ff       	call   100773 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b60:	85 ed                	test   %ebp,%ebp
  100b62:	7f ed                	jg     100b51 <console_vprintf+0x362>
  100b64:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b66:	47                   	inc    %edi
  100b67:	8a 17                	mov    (%edi),%dl
  100b69:	84 d2                	test   %dl,%dl
  100b6b:	0f 85 96 fc ff ff    	jne    100807 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b71:	83 c4 38             	add    $0x38,%esp
  100b74:	89 f0                	mov    %esi,%eax
  100b76:	5b                   	pop    %ebx
  100b77:	5e                   	pop    %esi
  100b78:	5f                   	pop    %edi
  100b79:	5d                   	pop    %ebp
  100b7a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b7b:	81 e9 28 0c 10 00    	sub    $0x100c28,%ecx
  100b81:	b8 01 00 00 00       	mov    $0x1,%eax
  100b86:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b88:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b89:	09 44 24 14          	or     %eax,0x14(%esp)
  100b8d:	e9 aa fc ff ff       	jmp    10083c <console_vprintf+0x4d>

00100b92 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b92:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b96:	50                   	push   %eax
  100b97:	ff 74 24 10          	pushl  0x10(%esp)
  100b9b:	ff 74 24 10          	pushl  0x10(%esp)
  100b9f:	ff 74 24 10          	pushl  0x10(%esp)
  100ba3:	e8 47 fc ff ff       	call   1007ef <console_vprintf>
  100ba8:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100bab:	c3                   	ret    
