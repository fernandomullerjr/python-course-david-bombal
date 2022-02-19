
-Erros de ascii, devido acentuação:
UnicodeEncodeError: 'ascii' codec can't encode character python3

-Resolvido após executar o código usando:
PYTHONIOENCODING=utf-8 python3 script.py
PYTHONIOENCODING=utf-8 python3 aula58-teste4.py


-Para não ter que usar o parametro toda vez, foi adici

export PYTHONIOENCODING=utf-8

root@NetworkAutomation-1:~# echo $PYTHONIOENCODING
utf-8
root@NetworkAutomation-1:~#




############# EXPLICAÇÃO DO COMANDO EXPORT:
export variável=valor
Descrição

Comando do shell que permite configurar e compartilhar 
variáveis de ambiente entre diversos programas e bibliotecas acessados a partir do mesmo terminal.