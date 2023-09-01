#!/bin/bash

#Pode Utilizar esse script no contrab para remover todas as imagens não utilizadas, com isso não precisa docker image prune;

#opçãp 01
#O dangling=true filtra e encontra imagens não utilizadas e remove.
#docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

#Opção 02
#Tecnicamente, você deve primeiro limpar os contêineres antes de limpar as imagens, pois isso captura mais imagens pendentes e menos erros.
#dcleanup(){
#    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
#    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
#}

#Opção03
#Apaga as imagens do docker com mais de 4 Meses
#Apaga com mais 5 dias > 120 horas
#Apaga com mais 1 mês > 730 horas
#Apaga com mais 4 meses  > 2920 horas 
docker image prune -a --force --filter "until=2920h"
