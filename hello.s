# text sectoin

.text
.global _start

_start: 
    # write our string to stdout, its fd is 1
    # third argument: message length
    movl    $len, %edx           
    # second argument: pointer to message to write
    movl    $msg, %ecx          
    # first argument: file handle (stdout)
    movl    $1, %ebx            
    
    # system call: write 
    movl    $4, %eax            
    int     $0x80               
    
    # system call: exit
    movl    $0,%ebx             # first argument: exit code
    movl    $1,%eax             # system call number (sys_exit)
    int     $0x80               # call kernel


.data                           # section declaration

msg:
    .ascii "Hello, world!\n"
msg_end:
    # calculate length of msg
    .equ len, msg_end - msg
