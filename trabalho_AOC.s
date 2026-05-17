.data
	ano1: .asciiz "\n Digite o ano: "
	ano2: .asciiz "\n Digite um outro ano: "
	saida: .asciiz "\n A quant. de anos não bissextos é: "
.text
main:
	#Recebendo o primeiro ano
	li $v0, 4
	la $a0, ano1
	syscall
	
	#Leitura do primeiro ano
	li $v0, 5
	syscall
	add $t1 , $v0 , $zero # ano1 = t1
	
	#Recebendo o segundo ano
	li $v0, 4
	la $a0, ano2
	syscall
	
	#Leitura do segundo ano
	li $v0, 5
	syscall
	add $t2 , $v0 , $zero # ano2 = t2
	
	add $s3 , $zero , $zero # Contador dos anos não bissextos
	
	# Se ano1>ano2
	bgt $t1, $t2, entao
	j senao
	
entao:
	add $s1 , $t2 , $zero # inicio(s1) = t2
	add $s2 , $t1 , $zero # fim(s2) = t1
	sub $s0 , $s2 , $s1   # diferença 
	
	# Se diferença>1000, então
	bgt $s0 , 1000 , main
	j enquanto # Senão
	
senao:
	add $s1 , $t1 , $zero # inicio(s1) = t1 	
	add $s2 , $t2 , $zero # fim(s2) = t2
	sub $s0 , $s2 , $s1   # diferença 
	
	# Se diferença>1000, então
	bgt $s0 , 1000 , main
	j enquanto # Senao
	
enquanto:
	# Enquanto inicio<fim, faça
	blt $s1 , $s2 , continua
	j fim

continua:
	# Se inicio(ano1) % 400 == 0, então
	rem $t0, $s1 , 400
	beq $t0 , 0 , proxAno
	
	# # Se inicio(ano1) % 100 == 0 e não %400, então
	rem $t0 , $s1 , 100
	beq $t0 , 0 , naoBissexto
	
	# Se inicio(ano1) % 4 == 0, então
	rem $t0, $s1 , 4
	beq $t0 , 0 , proxAno
	
	j naoBissexto
	
naoBissexto:
	add $s3 , $s3 , 1 # Incrementando ano não bissexto
	
	j proxAno
	
proxAno:
	add $s1 , $s1 ,1 # Incrementando ano1
	j enquanto
	
fim:
	#Saída
	li $v0 , 4
	la $a0 , saida
	syscall
	li $v0 , 1
	add $a0 , $s3 , $zero
	syscall
