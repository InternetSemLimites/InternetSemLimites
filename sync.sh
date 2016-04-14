#!/bin/bash
cd /home/automacao/InternetSemLimites && (
	# Reset de segurança
	git reset --hard HEAD; git clean -f -d; /usr/bin/git pull origin HEAD

	#substitui o arquivo com o novo
	#wget http://internetsemlimites.herokuapp.com/readme.md -O README.md 

	# commit e push
	#git commit -a -m "readme atualizado"
	#git push origin master
)
