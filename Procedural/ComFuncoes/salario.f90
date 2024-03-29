module salario
    use formatter
    implicit none

    contains

    real function calcula_novo_salario(salario)
        real, INTENT(IN) :: salario  !!ARGUMENTO DA FUNCAO

        calcula_novo_salario = salario * 0.9
    end function calcula_novo_salario

    subroutine obter_salarios(resultado, total, nome_arquivo)

        integer :: total
        real, dimension(100) :: resultado
        character(len=*), intent(in) :: nome_arquivo
        real :: valor
        integer :: indice_arquivo = 1, io

        open(indice_arquivo, file = nome_arquivo, status = 'old')

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

    subroutine salvar_novos_salarios(salarios, total_de_salarios, nome_arquivo)

        integer :: total_de_salarios
        real, dimension(100) :: salarios
        character(len=*), intent(in) :: nome_arquivo
        integer :: indice_arquivo_resultado = 2
        real :: valor_calculado, soma_salarios = 0
        integer :: i

        open(indice_arquivo_resultado, file = nome_arquivo, status = 'old')

        do i = 1, total_de_salarios, 1
            valor_calculado = calcula_novo_salario(salarios(i))

            call escrever_salario_arquivo(indice_arquivo_resultado, valor_calculado)
            soma_salarios = soma_salarios + valor_calculado
        end do

        write(indice_arquivo_resultado, *) 'Media do Valor'
        write(indice_arquivo_resultado, '(F7.2)') (soma_salarios / total_de_salarios)

        close(indice_arquivo_resultado)
    end subroutine salvar_novos_salarios

end module salario
