#!/bin/bash
get_file_hash () {	#1 - path to file | 2 - function selection
	case $2 in
		1)
			sha1sum $1 >> $3.sha1
			;;
		256)
			sha256sum $1 >> $3.sha256
			;;
		384)
			sha384sum $1 >> $3.sha384
			;;
		512)
			sha512sum $1 >> $3.sha512
			;;
		*)
			echo "Invalid function selected"
			;;
	esac
}

check_file_integrity (){
	exten=$(echo $1 | cut -d'.' -f 2)
	case $exten in
		sha1)
			sha1sum $1 -c
			;;
		sha256)
			sha256sum $1 -c
			;;
		sha384)
			sha384sum $1 -c
			;;
		sha512)
			sha512sum $1 -c
			;;
		*)
			echo "Invalid file"
			;;
	esac
}

case $1 in
	-h | --help)
		echo "USAGE:"
		echo "If you want to collect new baseline run script with first parameter -c or --collect"
		echo "If you want to check integrity with saved baseline run script with first parameter -i or --integrity"
		echo "You also need to pass path to file, which integrity should be checked as second parameter"
		;;
	-c | --collect)
		echo "===== COLLECTIONG BASELINE ====="
		echo "Put path to file to clculate checksum: "
		read infilename
		echo "Where output data should be saved? Pleas give me only file name, without extension: "
		read outfilename
		echo "Which function should be used? Pass me number:"
		echo "1 for SHA1"
		echo "256 for SHA256"
		echo "384 for SHA384"
		echo "512 for SHA 512"
		read funcselection
		get_file_hash $infilename $funcselection $outfilename
		;;
	-i | --integrity)
		echo "===== CHECKING INTEGRITY ====="
		echo "Put path to file with checksum of file to be checked (with extension):"
		read filechecksum
		check_file_integrity $filechecksum
		;;
	*)
		echo "Passed wrong parameter, run script with -h or --help parameter for more information"
		;;
esac
