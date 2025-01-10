.model small
.org 100h

.data
    menu    db 13,10,'1. Herbivora'
            db 13,10,'2. Omnivora'
            db 13,10,'3. Karnivora$'

    daftar  db 13,10,'Masukkan pilihan (1-3): $'
    
    herb    db 13,10,'**********************'
            db 13,10,'* Hewan Herbivora    *'
            db 13,10,'*  a. Sapi           *'
            db 13,10,'*  b. Kambing        *'
            db 13,10,'*  c. Kerbau         *'  
            db 13,10,'**********************$'
            
    omni    db 13,10,'**********************'
            db 13,10,'* Hewan Omnivora     *'
            db 13,10,'*  a. Kucing         *'
            db 13,10,'*  b. Ayam           *'
            db 13,10,'*  c. Tikus          *'  
            db 13,10,'**********************$'
            
    karni   db 13,10,'**********************'
            db 13,10,'* Hewan Karnivora    *'
            db 13,10,'*  a. Harimau        *'
            db 13,10,'*  b. Singa          *'
            db 13,10,'*  c. Serigala       *'   
            db 13,10,'**********************$'

    error_msg db 13,10,'Pilihan tidak valid. Program dihentikan.$'
    
    continue_prompt db 13,10,'Apakah Anda ingin memilih yang lain? (Y/N): $'
    choice db 0

.code        
mulai:
    
    ; Menampilkan menu utama
    mov ah,09h
    lea dx,menu
    int 21h
    
    ; Menampilkan prompt untuk memilih kategori
    mov ah,09h
    lea dx,daftar
    int 21h   
    
    ; Menerima input dari pengguna
    mov ah,01h ; Fungsi untuk membaca karakter
    int 21h    ; Panggil interrupt untuk menerima input
    mov bh, al ; Menyimpan input ke dalam bh 
    
    ; Memeriksa pilihan kategori
    cmp bh, '1'
    je herb_choice
    
    cmp bh, '2'
    je omni_choice 
    
    cmp bh, '3'
    je karni_choice
    
    ; Jika pilihan tidak valid
    mov ah, 09h
    lea dx, error_msg
    int 21h
    jmp exit_program
    
herb_choice:
    ; Menampilkan pilihan hewan Herbivora
    mov ah, 09h
    lea dx, herb
    int 21h
    jmp continue_prompt_loop
    
omni_choice:
    ; Menampilkan pilihan hewan Omnivora
    mov ah, 09h
    lea dx, omni
    int 21h
    jmp continue_prompt_loop
    
karni_choice:
    ; Menampilkan pilihan hewan Karnivora
    mov ah, 09h
    lea dx, karni
    int 21h
    jmp continue_prompt_loop
    
continue_prompt_loop:
    ; Menanyakan kepada pengguna apakah ingin melanjutkan
    mov ah, 09h
    lea dx, continue_prompt
    int 21h
    
    ; Menerima input dari pengguna untuk melanjutkan atau tidak
    mov ah,01h
    int 21h
    mov al, bh  ; Menyimpan jawaban di AL
    
    ; Cek apakah jawabannya Y atau N
    cmp al,'Y'
    jmp mulai     ; Jika Y, ulangi dari awal
    
    cmp al,'y'
    jmp mulai     ; Jika y, ulangi dari awal
    
    cmp al,'N'
    mov ah, 09h
    lea dx, error_msg
    int 21h
    je exit_program ; Jika N, keluar dari program
    
    cmp al,'n'
    mov ah, 09h
    lea dx, error_msg
    int 21h
    jmp exit_program  ; Jika n, keluar dari program

exit_program:
    ; Keluar dari program
    mov ah, 4Ch
    int 21h
            
end start