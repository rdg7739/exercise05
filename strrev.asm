;;
;; strrev.asm
;;
;;  Created on: Apr 16, 2013
;;      Author: rdg77_000
;;



	SECTION .text			;code section.
	global strrev			;let loader see entry point


strrev:						;address for gdb
	push ebp
	mov ebp, esp

	push ebx				;;save all the register
	push esi
	push edi
	push ecx
	push edx

	mov eax, 0				;initialize all register to 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov edi, 0
	mov esi, [ebp + 8]

check_null:					;check that string is null or not
	cmp esi, 0h
	je exit					;jump if the string is null

countLength:				;;count down the size of string
	mov al, [esi +ecx]
	inc ecx
	cmp al, 0h				;check that string  is null
	je check_empty			;jump if the string reach end
	jmp countLength

check_empty:				;check that string is empty or not
	dec ecx
	cmp ecx, 0
	je exit


for_init:
	mov ebx, 0 				;reinitialze ebx register  ;count

forLoop:
	mov al, [esi +ebx]		;;get nth element from string and store it to eax
	push eax				;;push it to stack
	inc ebx
	cmp ecx, ebx 			;; compare ebx with string length
	je forPop_init  		;;if ebx reach size of string, move to forPop_init
	jmp forLoop				;; keep running for loop until ebx reach string length

forPop_init:
	mov ebx, 0 				;;initialize
	mov edx, 0
for_pop:

	pop edx					;; pop out from stack
	mov dl, dl
	mov [esi +ebx], edx 	;;place dl from string's front
	inc ebx
	cmp ecx, ebx
	je exit
	jmp for_pop


exit:
	pop edx					;;restore all variable back to register
	pop ecx
	pop edi
	pop esi
	pop ebx
	mov esp, ebp
	pop ebp

	ret
