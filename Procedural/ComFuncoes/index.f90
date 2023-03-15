! AUTOR: DAVID TIGRE MORAES
! Programa atualiza uma lista de números baseado em outra lista

!! ======== FUNCTIONS ========= !!
real function calcula_novo_salario(salario)
    implicit none
    real, INTENT(IN) :: salario  !!ARGUMENTO DA FUNCAO

    calcula_novo_salario = salario * 0.9
end function calcula_novo_salario

!! ======== ROTINAS ========= !!
subroutine escrever_novo_salario(indice_arquivo, valor)
    implicit none
    integer :: indice_arquivo
    real :: valor
    character(len = 20) :: formato = '(F10.2)'

    if(valor <= 10) then
        formato = '(F4.2)'
    else if(valor <= 100) then
        formato = '(F5.2)'
    else if(valor <= 1000) then
        formato = '(F6.2)'
    else if(valor <= 10000) then
        formato = '(F7.2)'
    else if(valor <= 100000) then
        formato = '(F8.2)'
    else if(valor <= 1000000) then
        formato = '(F9.2)'
    end if

    write(indice_arquivo, formato) valor
end subroutine escrever_novo_salario

subroutine obter_salarios(resultado, total)
    implicit none
    integer :: total
    real, dimension(100) :: resultado
    real :: valor
    integer :: indice_arquivo = 1, io

    character(len = 20) :: nome_arquivo_base = 'lista_salarios.txt'

    open(indice_arquivo, file = nome_arquivo_base, status = 'old')

    do
        read(indice_arquivo, *, IOSTAT = io) valor

        if(io /= 0) then
            exit
        else
            resultado(total + 1) = valor
        end if

        total = total + 1
    end do

    close(indice_arquivo)
end subroutine obter_salarios

subroutine salvar_novos_salarios(salarios, total_de_salarios)
    implicit none
    integer :: total_de_salarios
    real, dimension(100) :: salarios
    real :: calcula_novo_salario
    integer :: indice_arquivo_resultado = 2
    real :: valor_calculado, soma_salarios = 0
    integer :: i
    character(len = 20) :: nome_arquivo_resultado = 'lista_atualizada.txt'

    open(indice_arquivo_resultado, file = nome_arquivo_resultado, status = 'old')

    do i = 1, total_de_salarios, 1
        valor_calculado = calcula_novo_salario(salarios(i))

        call escrever_novo_salario(indice_arquivo_resultado, valor_calculado)
        soma_salarios = soma_salarios + valor_calculado
    end do

    write(indice_arquivo_resultado, *) 'Media do Valor'
    write(indice_arquivo_resultado, '(F7.2)') (soma_salarios / total_de_salarios)

    close(indice_arquivo_resultado)
end subroutine salvar_novos_salarios

!! ======== EXECUCAO DO PROGRAMA ========= !!
program paradigma_procedural
!implicit none permite que se crie variaveis de qualquer nome de qualquer tipo
implicit none
    integer :: total_de_salarios = 0
    real, dimension(100) :: lista_salarios

    call obter_salarios(lista_salarios, total_de_salarios)
    call salvar_novos_salarios(lista_salarios, total_de_salarios)
end program paradigma_procedural
