.section .data
    input_format: .asciz "%d"      
    output_format: .asciz "Wynik: %d\n"  
    error_msg: .asciz "Błąd: przepełnienie liczby całkowitej!\n"
    liczba: .long 0               

.section .text
    .global main
    .extern printf, scanf  

main:
    pushl %ebp
    movl %esp, %ebp

    # Wczytywanie liczby od użytkownika
    pushl $liczba           
    pushl $input_format     
    call scanf              
    addl $8, %esp           

    movl liczba, %eax      # Pobranie liczby do %eax
    movl %eax, %ebx        

    imull %eax, %eax       # n * n
    jo overflow_error      # Jeśli overflow, skaczemy do error handlingu
    movl %eax, %ecx        

    movl %ebx, %edx        
    imull %eax, %edx       # n^2 * n
    jo overflow_error      
    
    imull $3, %ecx         # 3 * n^2
    jo overflow_error      
    addl %ecx, %edx        # n^3 + 3n^2
    jo overflow_error      

    imull $2, %ebx         # 2 * n
    jo overflow_error      
    subl %ebx, %edx        # (n^3 + 3n^2) - 2n
    jo overflow_error      

    pushl %edx             
    pushl $output_format   
    call printf            
    addl $8, %esp          

    movl $0, %eax          
    leave
    ret

overflow_error:
    pushl $error_msg
    call printf            
    addl $4, %esp          
    movl $1, %eax          # Zwracamy kod błędu 1
    leave
    ret

