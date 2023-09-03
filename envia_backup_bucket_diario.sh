#/bin/bash
# By Robson Medeiros
# versão 1.0 b
#Script de BACKUP DIARIO
#Backup do jenkins gerado pelo plugin ThinBACKUP /BACKUP (mantendo 7 últimos backups na pasta)

#Descomente caso queira utilizar outra cópia de backup para outra pasta específica:
#mkdir -p /BACKUP/diario
#cp /BACKUP/*.zip /BACKUP/diario

#Envia todo conteúdo da pasta BACKUP para o Bucket S3 da AWS
#Envia backup do Jenkins para o S3
/usr/local/bin/aws s3 sync /BACKUP s3://backup.empresax.dominio.com.br/

#intervalo para enviar
#sleep 210
echo "Backup enviado com sucesso."
