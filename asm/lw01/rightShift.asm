%include "io64.inc"

section .bss
    number resb 1

section .text

global CMAIN

CMAIN:
    mov rbp, rsp; for correct debugging
    ;�������� ������ � �������
    PRINT_STRING "Number: "
    ;��������� ����������� ����� number - ��� ����������.
    GET_UDEC 1, number
    ;������� ���� �����
    call PrintValue
    ;ecx - ������� ��������
    GET_UDEC 1, ecx
    
    ;����� ��� ����� �� ������� ����� ������� ���� �������
    .For:
        ;��������� �������� � 0
        cmp ecx, 0
        ;���� ����� �� �����������
        je .Finish
        ;����� ������       
        shr byte [number], 1
        ;��������� �������
        dec ecx
        ;������� ����� �� �����
        jmp .For

    .Finish:
        ;������� ������
        PRINT_STRING "Result: "
        ;������� �� �����
        call PrintValue
    xor rax, rax
    ret

PrintValue:
    ;�������� ����� � �������
    mov r8b, [number] ; Number copy.
    ;�������
    mov ecx, 8 ; All 8 binary digits.
    ;����������� �������� for. ������� ��������� �������. ���������
    .For:
        shl r8b, 1
        setc dl
        PRINT_UDEC 1, dl
        dec ecx
        jnz .For
    NEWLINE
    ret