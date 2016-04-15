#!/bin/bash -x

FILE="README.md"
if [ "$1" == "shame" ]; then
	FILE="HALL_OF_SHAME.md"
fi

cd /home/automacao/InternetSemLimites && (
	# Reset de segurança
	git reset --hard HEAD; git clean -f -d; /usr/bin/git pull origin HEAD

	#substitui o arquivo com o novo
	wget https://internetsemlimites.herokuapp.com/$FILE -O $FILE.tmp

        SIZE=`du -k "README.md.tmp" | cut -f 1`
        if [ $SIZE -lt 1 ]; then
                rm -f $FILE.tmp
		echo invalid file size
		exit 0
	fi

        MD5A=`md5sum $FILE |awk '{print $1}'`
        MD5B=`md5sum $FILE.tmp |awk '{print $1}'`

	if [ "$MD5A" != "$MD5B" ]; then
		mv -f $FILE.tmp $FILE
		git pull origin master
                git add . && (git commit -a -m "auto-update $FILE"; git push origin master)
	fi
)
