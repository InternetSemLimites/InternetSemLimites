#!/bin/bash -x
cd /home/automacao/InternetSemLimites && (
	# Reset de segurança
	git reset --hard HEAD; git clean -f -d; /usr/bin/git pull origin HEAD

	#substitui o arquivo com o novo
	wget https://internetsemlimites.herokuapp.com/README.md -O README.md.tmp

        SIZE=`du -k "README.md.tmp" | cut -f 1`
        if [ $SIZE -lt 1 ]; then
                rm -f README.md.tmp
		echo invalid file size
		exit 0
	fi

        MD5A=`md5sum README.md |awk '{print $1}'`
        MD5B=`md5sum README.md.tmp |awk '{print $1}'`

	if [ "$MD5A" != "$MD5B" ]; then
		mv -f README.md.tmp README.md
		git pull origin master
                git add . && (git commit -a -m "auto-update README.md"; git push origin master)
	fi
)
