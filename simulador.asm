.data
    buffer: .space 30
    buffer2: .space 30
    str_forma_pagamento:  .asciiz "Digite 1 - para Crédito /2 - para Débito:"
    str_bandeira:  .asciiz "Digite a bandeira do cartão de crédito (1-Visa/2-Master/3-Elo):"
    str_valor: .asciiz "Digite o valor da compra:"
    str_n_cartao: .asciiz "Digite o número do cartão:"
    str_senha: .asciiz "Digite sua senha:"
    view_forma_pagamento: .asciiz "\nForma de pagamento: "
    view_credito: .asciiz "Crédito"
    view_debito: .asciiz "Débito"
    view_pagamento: .asciiz "\nValor da compra: R$"
    view_n_cartao: .asciiz "\nNúmero do cartão: "
    view_valor: .asciiz "\nValor da compra: R$"
    zerof :	.float 0.0
    
.text
    
main:
	# SOLICITA AO USUARIO O TIPO DE PAGAMENTO (inteiro)
	la $a0, str_forma_pagamento
	li $v0, 4
	syscall

	# LE UM NUMERO DO BUFFER DE ENTRADA (TIPO DE PAGAMENTO)
	li $v0, 5
	syscall
	move $t0, $v0
	
	# SOLICITA AO USUARIO O TIPO DA BANDEIRA (inteiro)
	la $a0, str_bandeira
	li $v0, 4
	syscall

	# LE UM NUMERO DO BUFFER DE ENTRADA (TIPO DA BANDEIRA)
	li $v0, 5
	syscall
	move $t1, $v0
	
	# SOLICITA AO USUARIO O VALOR DA COMPRA (float)
	la $a0, str_valor
	li $v0, 4
	syscall

	# LE A ENTRADA DO USUARIO (VALOR DA COMPRA)
	li $v0, 6 #O valor sera armazenado em $f0
	syscall
	
	# SOLICITA AO USUARIO O NUMERO DO CARTAO (string)
	la $a0, str_n_cartao    #Carrega e exibe uma mensagem 
        li $v0, 4
        syscall
	
	# LE A ENTRADA DO USUARIO (NUMERO DO CARTAO)
        li $v0, 8       # Ler uma string
        la $a0, buffer  # aloca o buffer
        li $a1, 30      # tamanho do buffer
        syscall
    
        move $t2, $a0   # salva string em t2
        
	# SOLICITA AO USUARIO A SENHA DO CARTAO (string)
	la $a0, str_senha    #Carrega e exibe uma mensagem 
        li $v0, 4
        syscall
	
	# LE A ENTRADA DO USUARIO (SENHA DO CARTAO)
        li $v0, 8       # LE uma string
        la $a0, buffer2  # aloca o buffer
        li $a1, 30      # tamanho do buffer
        syscall
    
        move $t3, $a0   # salva string em t3
	
	#################################################
	
	# EXIBE A FORMA DE PAGAMENTO
	la $a0, view_forma_pagamento    # Carrega e exibe " Forma de pagamento: "
        li $v0, 4
        syscall
        
        bne $t0, 1, Else        # desvia para ELSE se $t0 < > 1
        la $a0, view_credito     # Carrega " Credito"
        j Exit                   # desvia para exit
Else:   la $a0, view_debito      # Carrega " Debito"
Exit:
	li $v0, 4
        syscall
        
	# EXIBE O VALOR DA COMPRA
	lwc1 $f4, zerof    #Sera ultilizado para somar e exibir
	la $a0, view_valor    # Carrega e exibe " Numero do cartao: "
        li $v0, 4
        syscall
        
	li $v0, 2
	add.s $f12, $f0, $f4
	syscall
	
	# EXIBE O NUMERO DO CARTAO
	la $a0, view_n_cartao    # Carrega e exibe " Numero do cartao: "
        li $v0, 4
        syscall
    
        la $a0, buffer  # aloca o buffer
        move $a0, $t2  # armazena a string em $a0
        li $v0, 4      # imprime a string
        syscall
	
	# FINALIZA O PROGRAMA
	li $v0, 10
	syscall
