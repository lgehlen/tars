#!/bin/bash

ant_all(){
	platform
	eval "ant all"
}

ant_clean(){
	platform
	eval "ant clean all"
}

ant_clean_all(){
	platform
	eval "ant clean all"
}

ant_initialize(){
	platform
	eval "ant initialize > ~/Documentos/initialize.log"
}

_clear(){
	eval "cd"
	eval "clear"
}

install_local(){
	eval "cd $pathHybris$pathInstaller"
	eval "./install.sh -r local setup"
}

_git(){
	eval "cd $pathHybris"
	eval "git status"
	break
}

git_add(){
	eval "cd $pathHybris"

	cmd="null"

	while [ "$cmd" != "fim" ]
	do
		eval "clear"
		eval "git status"

		echo "Entre com o arquivo que você deseja adicionar ou digite \"fim\" para encerrar"
		
		read cmd
		
		if [ "$cmd" != "fim" ] 
		then
			eval "git add $cmd"
		fi

	done
}

git_checkout(){
	eval "cd $pathHybris"
	eval "git checkout -- ."
}

git_merge(){
	eval "cd $pathHybris"
	eval "git merge origin/develop"
}

git_status(){
	eval "cd $pathHybris"
	eval "git status"
}

log(){
	eval "cd $pathHybris$pathLog"
	eval "tail -f $log"
}

log_x(){

	echo "Entre com o número de linhas:"
	read linhas
	
	eval "cd $pathHybris$pathLog"
	eval "tail -n $linhas $log"
}

platform(){
	eval "cd $pathHybris$pathPlatform"
	eval ". ./setantenv.sh"
}

start(){
	platform
	eval "./hybrisserver.sh start debug"
	log
}

start_all(){
	platform
	eval "ant all && ./hybrisserver.sh start debug"
	log
}

start_clean(){
	platform
	eval "ant clean all && ./hybrisserver.sh start debug"
	log
}

stop(){
	platform
	eval "./hybrisserver.sh stop"
}

update(){
	platform
	eval "ant updatesystem"
}

yarn_build(){
	platform
	eval "yarn run build"
}

yarn_full(){
	platform
	eval "cd $pathHybris$pathFront"
	eval "yarn run setup && yarn run build"
}

yarn_setup(){
	platform
	eval "yarn run setup"
}

valida_cmd(){	
	echo "Tem certeza que você quer realizar a seguinte ação?"
	echo "$ordem"
	echo "(s/n)"

	read opt

	if [ "$opt" == "s" ]
	then
		
		echo "Agora é tarde..."
		
		if [ "$ordem" == "git merge" ]
		then
			git_merge
		fi
		break
	else
		echo "Não vá fazer merda..."
	fi
}

pathHybris="/app/Ambientes/HeringB2B"
pathPlatform="/hybris/bin/platform"
pathInstaller="/installer"
pathFront="/hybris/bin/custom/heringb2b/heringb2bstorefront"
pathLog="/hybris/log/tomcat"
log="console-$(date +'%Y%m%d').log"

ordem="null"

while [ "$ordem" != "sair" ]
do
	echo "O que eu posso fazer por você?"
	read ordem

	if [ "$ordem" == "ant all" ] 
	then
		ant_all

	elif [ "$ordem" == "ant clean" ] 
	then
		ant_clean
	
	elif [ "$ordem" == "ant clean all" ] 
	then
		ant_clean_all

	elif [ "$ordem" == "ant initialize" ] 
	then
		ant_initialize

	elif [ "$ordem" == "clear" ]
	then
		_clear

	elif [ "$ordem" == "install local" ]
	then
		install_local

	elif [ "$ordem" == "git" ]
	then
		_git

	elif [ "$ordem" == "git add" ]
	then
		git_add

	elif [ "$ordem" == "git checkout" ]
	then
		git_checkout

	elif [ "$ordem" == "git merge" ]
	then		
		valida_cmd $ordem

	elif [ "$ordem" == "git status" ]
	then
		git_status
	
	elif [ "$ordem" == "log" ]
	then
		log
	
	elif [ "$ordem" == "log x" ]
	then
		log_x

	elif [ "$ordem" == "start" ]
	then
		start

	elif [ "$ordem" == "start all" ] 
	then
		start_all

	elif [ "$ordem" == "start clean" ] 
	then
		start_clean

	elif [ "$ordem" == "stop" ]
	then
		stop
	
	elif [ "$ordem" == "update" ] 
	then
		update	
	
	elif [ "$ordem" == "yarn build" ] 
	then
		yarn_build	
	
	elif [ "$ordem" == "yarn full" ] 
	then
		yarn_full	
	
	elif [ "$ordem" == "yarn setup" ] 
	then
		yarn_setup	

	elif [ "$ordem" == "sair" ]
	then
		echo "Quando quiser algo, estarei aqui fazendo naaada... *barulho de BitCoin sendo mineirado*"

	elif [ "$ordem" == "help" ]
	then
		echo ""
		echo " ant all		| ant all"
		echo " ant clean		| ant clean"
		echo " ant clean all 		| ant clean all"
		echo " ant initialize		| ant initialize"
		echo " clear			| clear"
		echo " install local		| ./install.sh -r local setup"
		echo " git			| git status + sair"
		echo " git add		| git add + (Seus Arquivos)"
		echo " git checkout		| git checkout -- ."
		echo " git merge 		| git merge origin/develop"
		echo " git status		| git status"
		echo " log			| tail -f $log"
		echo " log x			| tail -n (valor desejado) $log"
		echo " start			| ./hybrisserver.sh start debug + tail -f $log"
		echo " start all		| ant all && ./hybrisserver.sh start debug + tail -f $log"
		echo " start clean		| ant clean all && ./hybrisserver.sh start debug + tail -f $log"
		echo " stop			| ./hybrisserver.sh stop"
		echo " yarn build		| yarn run build"
		echo " yarn full		| yarn run setup && yarn run build"
		echo " yarn setup		| yarn run setup"
		echo ""
		echo " sair			| sair"

	else
		echo "Hã? Não entendi... (use o comando \"help\" pra falar decentemente)"
	fi

	eval "cd"

done

ordem="null"
