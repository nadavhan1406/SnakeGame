IDEAL
MODEL small
STACK 100h
DATASEG
	Clock equ es:6Ch
	home_screen_text db 10,13," Snake",10,10,10,13, "-Made by Nadav Hananel",10,10,10,10,10,10,10,10,10,10,13,"        Start               Exit$"
	game_over_text db 10,10,10,13,"               GAME OVER",10,10,10,13," Your Score:      $"
	end_buttons db 10,10,10,10,10,10,10,10,13,"     Play Again             Exit$"
	test_text db 13,"GAME OVER$"

	score_text db 13,"$"
	score dw 0

	head_x dw 110
	head_y dw 105
	snake_x dw 300 dup (110,110,110)
	snake_y dw 300 dup (94,83,72,61)
	snake_cord dw 300 dup (?)
	tail_x dw ?
	tail_y dw ?
	tail2_x dw ?
	tail2_y dw ?
	snakelen dw 3
	dir db 'd'

	isValid db 1 
	isApple db 0

	e11 db 11
	e28 db 28

	ranxorkey dw 348

	apple_cord dw 245
	apple_x dw ?
	apple_y dw ?

	buffer db 0

CODESEG
proc setup
	push bx
	push cx
	push si
	push bp
	mov [score], 0
	mov [buffer], 0
	mov [snakelen], 3
	mov [isValid], 1
	mov [dir], 'd'
	mov [isApple], 0
	mov [apple_cord], 245
	mov [head_x], 110
	mov [head_y], 105
	mov cx, [snakelen]
	mov bp, cx
	shl bp, 1
	mov bx, [head_y]
setuploop:
	mov si, cx
	shl si, 1
	neg si
	add si, bp
	sub bx, 11
	mov [snake_y+si], bx
	mov [snake_x+si], 110
	loop setuploop
	pop bp
	pop si
	pop cx
	pop bx
	ret
endp setup
proc pixel
	push bp ;access the stack with bp
	mov bp, sp
	push cx ;save registers
	push dx
	push ax
	
	mov al, [bp+4] ;al color
	mov dx, [bp+6] ;dx is the y
	mov cx, [bp+8] ;cx is the x
	
	mov ah, 0ch ;print pixel to screen
	int 10h

	pop ax ;restore registers
	pop dx
	pop cx
	pop bp
	ret 6
endp pixel

proc pixel11 ;takes center x,y and color, and builds a square from x-7,y-7 to x+7,y+7 (15x15), with the given color
	push bp ;access the stack with bp
	mov bp, sp 
	push si ;save registers
	push ax
	push bx
	push cx
	push dx
	xor ax, ax
	mov al, [bp+4] ;al = color
	mov dx, [bp+6] ;dx = y center
	mov bx, [bp+8] ;bx = x center
	mov cx, 11 ;loop 15 times for 15 different x-values
pi11x:
	mov si, cx ;si = cx. si is 1 to 15
	sub si, 6 ;si is -7 to 7
	add si, bx ;si is the x-7 to x+7. meaning si have the x-values of the square
	push cx ;save cx for the y loop
	mov cx, 11 ;loop 15 times for 15 different y-values
pi11y: ;for each x value, we will print 15 diffferent pixels in 15 different y values
	push cx ;save cx. cx is 1 to 15
	sub cx, 6 ;cx is -7 to 7
	add cx, dx ;cx is the y-7 to y+7, meaning cx have the y-values of the square
	push si ;the x value
	push cx ;the y value
	push ax ;the color
	call pixel ;build pixel here
	pop cx ; restore cx for the next y loop iteration
	loop pi11y
	pop cx ;resotre cx for the next x loop iteration
	loop pi11x
	pop dx ;restore registers
	pop cx
	pop bx
	pop ax
	pop si
	pop bp
	ret 6
endp pixel11

proc pixel9 ;takes center x,y and color, and builds a square from x-7,y-7 to x+7,y+7 (15x15), with the given color
	push bp ;access the stack with bp
	mov bp, sp 
	push si ;save registers
	push ax
	push bx
	push cx
	push dx
	xor ax, ax
	mov al, [bp+4] ;al = color
	mov dx, [bp+6] ;dx = y center
	mov bx, [bp+8] ;bx = x center
	mov cx, 9 ;loop 15 times for 15 different x-values
pi9x:
	mov si, cx ;si = cx. si is 1 to 15
	sub si, 5 ;si is -7 to 7
	add si, bx ;si is the x-7 to x+7. meaning si have the x-values of the square
	push cx ;save cx for the y loop
	mov cx, 9 ;loop 15 times for 15 different y-values
pi9y: ;for each x value, we will print 15 diffferent pixels in 15 different y values
	push cx ;save cx. cx is 1 to 15
	sub cx, 5 ;cx is -7 to 7
	add cx, dx ;cx is the y-7 to y+7, meaning cx have the y-values of the square
	push si ;the x value
	push cx ;the y value
	push ax ;the color
	call pixel ;build pixel here
	pop cx ; restore cx for the next y loop iteration
	loop pi9y
	pop cx ;resotre cx for the next x loop iteration
	loop pi9x
	pop dx ;restore registers
	pop cx
	pop bx
	pop ax
	pop si
	pop bp
	ret 6
endp pixel9

proc appleHandle
	push ax
	push bx
	push cx
	push dx
	push si
	push bp
	mov bx, [head_x]
	mov ax, [head_y]
	mov cx, [snakelen]
	inc cx
	mov bp, cx
	shl bp, 1
cord:
	mov si, cx
	shl si, 1
	neg si
	add si, bp
	sub ax, 17
	sub bx, 11
	div [e11]
	mul [e28]
	mov dx, ax
	mov ax, bx
	div [e11]
	add dx, ax
	mov [snake_cord+si], dx
	mov ax, [snake_y+si]
	mov bx, [snake_x+si]
	loop cord

	mov ax, [Clock]
	and ax, 111111111b
	xor ax, [ranxorkey]
	mov cx, [snakelen]
	inc cx
checkapple:
	mov si, cx
	shl si, 1
	cmp ax, [snake_cord+si-1]
	jb contin
	inc ax
contin: 
	loop checkapple
	shr bp, 1
	neg bp
	add bp, 447
	cmp ax, bp
	mov [apple_cord], ax
	jbe validapp
	
	mov ax, [tail2_y]
	sub ax, 17
	div [e11]
	mul [e28]
	mov dx, ax
	mov ax, [tail2_x]
	sub ax, 11
	div [e11]
	add dx, ax
	mov [apple_cord], dx

validapp:
	call print_apple
	pop bp
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp appleHandle
proc graphic_mode
    push ax ;save ax

    mov ax, 13h ;graphic mode
    int 10h
    
    pop ax ;restore ax
    ret
endp graphic_mode

proc home_screen
	push ax
	push bx
	push cx
	push dx
	
	call graphic_mode
	mov ah, 9h ;print string
	mov dx, offset home_screen_text
	int 21h
	
	mov ax, 0h ;turn on mouse
	int 33h
	
	mov ax, 1h ;show mouse
	int 33h
	
home_loop:
	
	mov cx, 31
start_pixel_left:
	push 20
	mov ax, 101
	add ax, cx
	push ax
	push 15
	call pixel
	loop start_pixel_left

mov cx, 120
start_pixel_up:
	mov ax, 20
	add ax, cx
	push ax
	push 102
	push 15
	call pixel
	loop start_pixel_up
	
	mov cx, 120
start_pixel_down:
	mov ax, 20
	add ax, cx
	push ax
	push 132
	push 15
	call pixel
	loop start_pixel_down
	
	mov cx, 31
start_pixel_right:
	push 140
	mov ax, 101
	add ax, cx
	push ax
	push 15
	call pixel
	loop start_pixel_right
	
	mov cx, 31
exit_pixel_left:
	push 180
	mov ax, 101
	add ax, cx
	push ax
	push 15
	call pixel
	loop exit_pixel_left

mov cx, 120
exit_pixel_up:
	mov ax, 180
	add ax, cx
	push ax
	push 102
	push 15
	call pixel
	loop exit_pixel_up
	
mov cx, 120
exit_pixel_down:
	mov ax, 180
	add ax, cx
	push ax
	push 132
	push 15
	call pixel
	loop exit_pixel_down
	
	mov cx, 31
exit_pixel_right:
	push 300
	mov ax, 101
	add ax, cx
	push ax
	push 15
	call pixel
	loop exit_pixel_right
	
	xor bx,bx
	mov ax, 3h ;check mouse
	int 33h
	shr cx, 1
	cmp bx, 1
	jne noclick
	cmp dx, 102
	jb noclick
	cmp dx, 132
	ja noclick
	cmp cx, 20
	jb noclick
	cmp cx, 140
	ja nostart
	jmp start_game
nostart:
	cmp cx, 180
	jb noclick
	cmp cx, 300
	ja noclick
	mov ah,0
	mov al,2
	int 10h
	jmp exit
noclick:
	jmp home_loop
start_game:
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp home_screen

proc main_screen
	push ax
	push cx
	push si
	mov ax, 2h ;hide mouse
	int 33h

	call setup
	mov ah, 9h ;print string
	mov dx, offset score_text
	int 21h
	call print_score
	call print_snake
	
	mov cx, 310
upper_bord:
	mov si, 4
	add si, cx
	push si
	push 11
	push 15
	call pixel
	loop upper_bord
	
	mov cx, 310
lower_bord:
	mov si, 4
	add si, cx
	push si
	push 188
	push 15
	call pixel
	loop lower_bord
	
	mov cx, 178
left_bord:
	mov si, 10
	add si, cx
	push 5
	push si
	push 15
	call pixel
	loop left_bord

	mov cx, 178
right_bord:
	mov si, 10
	add si, cx
	push 314
	push si
	push 15
	call pixel
	loop right_bord
	
	pop si
	pop cx
	pop ax
	ret
endp main_screen
proc print_score
	push ax
	push bx
	push cx
	push dx
	mov ax, [score] ;xyz
	mov cx, 3
	mov bl, 100
printloop:
	div bl
	mov dh, ah
	mov dl, al
	mov al, bl
	mov bh, 10
	xor ah,ah
	div bh
	mov bl, al
	mov ah, 2 ;print dl
	add dl, '0' ;add dl 0
	int 21h
	mov al, dh
	xor ah,ah
	loop printloop
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp print_score
proc print_snake
	push [head_x]
	push [head_y]
	push 2
	call pixel11
	
	mov cx, [snakelen]
snakeloop:
	mov si, cx
	shl si, 1
	push [snake_x+si-2]
	push [snake_y+si-2]
	push 10
	call pixel11
	loop snakeloop
	ret
endp print_snake

proc print_apple
	push ax
	push bx
	mov ax,[apple_cord]
	div [e28]
	mov bl, al
	shr ax, 8
	mul [e11]
	add ax, 11
	push ax
	push ax
	pop [apple_x]
	mov al, bl
	mul [e11]
	add ax, 17
	push ax
	mov [apple_y], ax
	push 4
	call pixel9
	pop bx
	pop ax
	ret
endp print_apple
proc keyboard_input
	push ax
	push bx
	mov ah, 01h
	int 16h
	jz noKeyPress
	mov ah, 00h
	int 16h
	cmp ah, 50h
	je updatebuff
	cmp ah, 4Bh
	je updatebuff
	cmp ah, 48h
	je updatebuff
	cmp ah, 4Dh
	jne nokeypress
updatebuff:
	mov [buffer], ah
noKeyPress:
	pop bx
	pop ax
	ret
endp keyboard_input
proc game_input
	push ax
	push bx
	mov ah, [buffer]
	cmp ah, 50h
	jne notDown
	cmp [dir],'u'
	je noKey
	mov [dir],'d'
	jmp noKey
notDown:
	cmp ah, 4Bh
	jne notLeft
	cmp [dir], 'r'
	je nokey
	mov [dir], 'l'
	jmp noKey
notLeft:
	cmp ah, 4Dh
	jne notRight
	cmp [dir], 'l'
	je nokey
	mov [dir], 'r'
	jmp nokey
notRight:
	cmp ah, 48h
	jne noKey
;up:
	cmp [dir],'d'
	je nokey
	mov [dir], 'u'
noKey:
	pop bx
	pop ax
	ret
endp game_input
proc waitmic
	push bp
	mov bp, sp
	push ax
	push cx
	push dx
	mov cx, [bp+6]
	mov dx, [bp+4]
	mov ah, 86h
	int 15h
	ret 4
endp waitmic

proc updateSnake
	push ax
	push bx
	push cx
	push dx
	push bp
	push si
	cmp [dir], 'l' ;check if dir is left
	je Left
	cmp [dir],'r'
	jne noX
	push [head_x] ;push head_x to save as first snake_x
	add [head_x], 11 ;mov snake head right
	jmp validx
Left:
	push [head_x] ;push head_x to save as first snake_x
	sub [head_x],11 ;mov snake head left
	jmp validx
noX:
	cmp [dir], 'u'
	je Up
Down:
	push [head_y] ;push head_y to save as first snake_y
	add [head_y],11 ;mov snake head down
	jmp validy
Up:
	push [head_y] ;push head_y to save as first snake_y
	sub [head_y],11 ;mov snake head up
validy:
	pop bx
	mov ax, [head_x]
	jmp updateloop
validx:
	pop ax ;ax=head_x for the first snake_x
	mov bx, [head_y] ;bx=head_y for the first snake_y
updateloop:
	mov cx, [snakelen] ;for every square in snake tail
	mov bp, [snakelen]
	shl bp, 1
sna_upd:
	mov si, cx
	shl si, 1
	neg si
	add si, bp
	push cx
	mov cx, [snake_x+si]
	mov dx, [snake_y+si]
	mov [snake_x+si], ax
	mov [snake_y+si], bx
	mov ax, cx
	mov bx, dx
	pop cx
	cmp cx, 1
	jne notlast
	push ax
	mov ax, [tail_x]
	mov [tail2_x], ax
	mov ax, [tail_y]
	mov [tail2_y], ax
	pop ax
	mov [tail_x], ax
	mov [tail_y], bx
notlast:
	loop sna_upd
	call checkhead ;check if head is valid
	cmp [isValid], 1 ;if valid, update and continue snake
	jne noValid
	push [tail_x]
	push [tail_y]
	push 0
	call pixel11
	call print_snake
noValid:
	pop si
	pop bp
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp updateSnake
proc checkhead
	push ax
	push bx
	push cx
	push si
	cmp [head_x],10
	jb notValid
	cmp [head_x],309
	ja notValid
	cmp [head_y],16
	jb notValid
	cmp [head_y], 183
	ja notValid

	mov ax, [head_x]
	mov bx, [head_y]
	mov cx, [snakelen]
check:
	mov si, cx
	shl si,1
	cmp ax,[snake_x+si-2]
	jne valx
	cmp bx, [snake_y+si-2]
	je notValid
valx:
	loop check
	cmp ax, [apple_x]
	jne valid
	cmp bx, [apple_y]
	jne valid
	mov [isApple], 1
	jmp valid
notValid:
	mov [isValid],0
valid:
	pop si
	pop cx
	pop bx
	pop ax
	ret
endp checkhead
proc endGame
	push ax
	push bx
	push cx
	push dx

	call graphic_mode

	mov ax, 0h ;hide mouse
	int 33h
	mov ax, 1h ;hide mouse
	int 33h

	mov ah, 9h ;print string
	mov dx, offset game_over_text
	int 21h
	call print_score
	mov ah, 9h ;print string
	mov dx, offset end_buttons
	int 21h
	
	mov ax, 0h ;turn on mouse
	int 33h
	
	mov ax, 2h ;show mouse
	int 33h
	

	mov cx, 31
again_pixel_left:
	push 20
	mov ax, 101
	add ax, cx
	push ax
	push 15
	call pixel
	loop again_pixel_left

mov cx, 120
again_pixel_up:
	mov ax, 20
	add ax, cx
	push ax
	push 102
	push 15
	call pixel
	loop again_pixel_up
	
	mov cx, 120
again_pixel_down:
	mov ax, 20
	add ax, cx
	push ax
	push 132
	push 15
	call pixel
	loop again_pixel_down
	
	mov cx, 31
again_pixel_right:
	push 140
	mov ax, 101
	add ax, cx
	push ax
	push 15
	call pixel
	loop again_pixel_right
	
	mov cx, 31
exit2_pixel_left:
	push 180
	mov ax, 101
	add ax, cx
	push ax
	push 15
	call pixel
	loop exit2_pixel_left

mov cx, 120
exit2_pixel_up:
	mov ax, 180
	add ax, cx
	push ax
	push 102
	push 15
	call pixel
	loop exit2_pixel_up
	
mov cx, 120
exit2_pixel_down:
	mov ax, 180
	add ax, cx
	push ax
	push 132
	push 15
	call pixel
	loop exit2_pixel_down
	
	mov cx, 31
exit2_pixel_right:
	push 300
	mov ax, 101
	add ax, cx
	push ax
	push 15
	call pixel
	loop exit2_pixel_right
	
end_loop:
	xor bx,bx
	mov ax, 3h ;check mouse
	int 33h
	shr cx, 1
	cmp bx, 1
	jne noclick2
	cmp dx, 102
	jb noclick2
	cmp dx, 132
	ja noclick2
	cmp cx, 20
	jb noclick2
	cmp cx, 140
	ja noagain2
	jmp again_game
noagain2:
	cmp cx, 180
	jb noclick2
	cmp cx, 300
	ja noclick2
	mov ah,0
	mov al,2
	int 10h
	jmp exit
noclick2:
	jmp end_loop
again_game:
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp endGame
start:
	mov ax, @data
	mov ds, ax
	mov ax, 40h
	mov es, ax
	
	call home_screen
startgame:
	call graphic_mode
	call main_screen
	call print_apple
	mov ah, 0
	int 16h	
main_loop:
	

;	mov ax, [Clock]
FirstTick:
;	cmp ax, [Clock]
;	je FirstTick
	mov cx, 3
DelayLoop:
	mov ax, [Clock]
Tick:
	call keyboard_input
	cmp ax, [Clock]
	je TICK
	loop DELAYLOOP
	call game_input
	call updatesnake
	cmp [isValid], 1
	jne noval
	cmp [isapple], 1
	jne noApp
	push ax
	push bx
	push cx
	push dx
	mov bx, [snakelen]
	shl bx, 1
	mov cx, [tail_x]
	mov [snake_x+bx], cx
	mov cx, [tail_y]
	mov [snake_y+bx], cx
	inc [snakelen]
	call print_snake
	inc [score]
	mov ah, 9h ;print string
	mov dx, offset score_text
	int 21h
	call print_score
	call applehandle
	pop dx
	pop cx
	pop bx
	pop ax
	mov [isapple], 0
noApp:
	jmp main_loop
noval:
	call endgame
	jmp startgame

exit:
	mov ax, 4c00h
	int 21h
END start


