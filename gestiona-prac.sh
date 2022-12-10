#!/bin/bash
declare -i opcion=0
while [ $opcion != 4 ]
do
echo -e "ASO 22/23 - Practica 6\nNombre del Alumno\n--------------------\n"
echo -e "Menú"
echo -e "   1) Programar recogida de practicas"
echo -e "   2) Empaquetado de practica de una asignatura"
echo -e "   3) Ver tamaño y fecha del fichero del fichero"
echo -e "   4) Finalizar programa"
read -p "Opción: " -a opcion
case $opcion in
	1)
		echo "Menú 1 - Programar recogida de prácticas\n"
		read -p "Asignatura cuyas prácticas desea recoger: " -a asig
		read -p "Ruta con las cuentas de los alumnos: " -a pathAlum
		while [ ! -d $pathAlum ]
		do
		echo $pathAlum "no existe."
		read -p "Ruta con las cuentas de los alumnos: " -a pathAlum
		done
echo $pathAlum
		read -p "Ruta para almacenar prácticas: " -a pathPrac
		while [ ! -d $pathPrac ]
		do
		echo $pathPrac "no existe"
		read -p "Ruta para almacenar prácticas: " -a pathPrac
		done
echo $pathPrac	
		echo "Se va a programar la recogida de las practicas de $asig para mañana a las 8:00. Origen: $pathAlum. Destino: $pathPrac"
		resp1="l"
		while [ $resp1 != "s" -a $resp1 != "n" ]
		do
			read -p "¿Está de acuerdo (s/n)?" -a resp
			if [ $resp1 == "s" ]
			then
				crontab -l > tareas
	echo "45 2 6 12 * bash $(pwd)/recoge-prac.sh $pathAlum $pathPrac"
	echo "45 2 6 12 * bash $(pwd)/recoge-prac.sh $pathAlum $pathPrac" >> tareas
				#echo "0 8 $(date -d tomorrow +%d) $(date -d tomorrow +%m) * bash /home/sergiodlx/Documentos/Prac6/recoge-prac.sh $pathAlum $pathPrac" >> tareas
				crontab tareas
			elif [ $resp == "n" ]
			then
				echo "Operacion cancelada"
			fi
		done
	;;
	2)
		echo "Menú 2 - Empaquetar prácticas de la asignatura"

		read -p "Asignatura cuyas prácticas se desea empaquetar:" -a pracEmp
		while [ ! -d $pracEmp ]
                do
                echo $pracEmp "no existe."
                read -p "Asignatura cuyas prácticas se desea empaquetar: " -a pracEmp
                done

		read -p "Ruta absoluta del directorio de prácticas:" -a dirPrac
		while [ ! -d $dirPrac ]
                do
                echo $dirPrac "no existe."
                read -p "Ruta absoluta del directorio de prácticas: " -a dirPrac
                done

		echo "Se van a empaquetar las prácticas de la asignatura $pracEmp presentes en el directorio $dirPrac."
		resp2="l"
		while [ $resp2 != "s" -a $resp2 != "n" ]
		do
			read -p "¿Está de acuerdo (s/n)?" -a resp2 
			if  [ $resp2 == "s" ]
			then
				nombreArchivo=$pracEmp-$(date +%y%m%d).tgz
				echo $nombreArchivo
				tar -cvf $nombreArchivo /$dirPrac/*
			elif [ $resp2 == "n" ]
			then
				echo "Operación cancelada"
			fi
		done
        ;;
	3)
		echo "Menú 3 - Obtener tamaño y fehca del archivo0"
		read -p "Asignatura sobre la que queremos información:" -a infoAsig
		cuenta=ls *.tgz | wc -l
		if [ $cuenta -gt 1 ]
			ls *.tgz
			read -p "Hay varios archivos .tgz. Escoja uno específico: " -a infoAsig
		fi
		archComp=find /$infoasig -name "*.tgz"
		tamaño=tar -cfz - $archComp.tar | wc -c
		echo "El fichero generado es $archComp y ocupa $tamaño" 
    	;;
	4)
		opcion=4
	;;
	*)
		opcion=0
	;;
esac
done
