%include "io64.inc"

section .bss
    number resb 1

section .text

global CMAIN

CMAIN:
    mov rbp, rsp; for correct debugging
    ;печатает строку в консоль
    PRINT_STRING "Number: "
    ;считывает беззнаковое число number - имя переменной.
    GET_UDEC 1, number
    ;выводим биты числа
    call PrintValue
    ;ecx - регистр счётчика
    GET_UDEC 1, ecx
    
    ;Метка для цикла на которую будем прыгать пока двигаем
    .For:
        ;сравнение счётчика с 0
        cmp ecx, 0
        ;если равны то заканчиваем
        je .Finish
        ;сдвиг правво       
        shr byte [number], 1
        ;уменьшаем счётчик
        dec ecx
        ;прыгаем снова на метку
        jmp .For

    .Finish:
        ;выводим строку
        PRINT_STRING "Result: "
        ;прыгаем на метку
        call PrintValue
    xor rax, rax
    ret

PrintValue:
    ;помещаем число в регистр
    mov r8b, [number] ; Number copy.
    ;счётчик
    mov ecx, 8 ; All 8 binary digits.
    ;аналогичсно прошлому for. Выводим уменьшаем счётчик. Повторяем
    .For:
        shl r8b, 1
        setc dl
        PRINT_UDEC 1, dl
        dec ecx
        jnz .For
    NEWLINE
    ret