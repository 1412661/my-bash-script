
extract () {
   if [ -f $1 ] ; then
      case $1 in
         *.tar.bz2)   tar xjf $1      ;;
         *.tar.gz)   tar xzf $1      ;;
         *.bz2)      bunzip2 $1      ;;
         *.rar)      rar x $1      ;;
         *.gz)      gunzip $1      ;;
         *.tar)      tar xf $1      ;;
         *.tbz2)      tar xjf $1      ;;
         *.tgz)      tar xzf $1      ;;
         *.zip)      unzip $1      ;;
         *.Z)      uncompress $1   ;;
         *)         echo "'$1' cannot be extracted via extract()" ;;
      esac
   else
      echo "'$1' is not a valid file"
   fi
}

transfer()
{
  proto="http://"
  upload_domain="upload.transfer.vietnix.vn";
  user_domain="transfer.vietnix.vn";
  if [ $# -eq 0 ];
    then 
      echo "
# Using the alias 
$ transfer hello.txt

# Upload using cURL 
$ curl --upload-file ./hello.txt https://transfer.sh/hello.txt
$ curl -H \"Max-Downloads: 1\" -H \"Max-Days: 5\" --upload-file ./hello.txt https://transfer.sh/hello.txt

# Upload multiple files at once
$ curl -i -F filedata=@/tmp/hello.txt -F filedata=@/tmp/hello2.txt https://transfer.sh/

# Combining downloads as zip or tar archive 
$ curl https://transfer.sh/(15HKz/hello.txt,15HKz/hello.txt).tar.gz 
$ curl https://transfer.sh/(15HKz/hello.txt,15HKz/hello.txt).zip

# Encrypt files with password using gpg 
$ cat /tmp/hello.txt|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt 

# Download and decrypt 
$ curl https://transfer.sh/1lDau/test.txt|gpg -o- > /tmp/hello.txt

# Scan for malware or viruses using Clamav 
$ wget http://www.eicar.org/download/eicar.com 
$ curl -X PUT --upload-file ./eicar.com https://transfer.sh/eicar.com/scan 

# Upload malware to VirusTotal, get a permalink in return 
$ curl -X PUT --upload-file nhgbhhj https://transfer.sh/test.txt/virustotal 

# Backup, encrypt and transfer 
$ mysqldump --all-databases|gzip|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt
"
    return 1; 
  fi 

  tmpfile=$(mktemp -t transfer-XXX); 
  if tty -s; 
    then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); 
    curl --progress-bar --upload-file "$1" "$proto$upload_domain/$basefile" >> $tmpfile; 
  else curl --progress-bar --upload-file "-" "$proto$upload_domain/$1" >> $tmpfile ; 
  fi; 

  link=`cat $tmpfile`;
  # Redirect to user page
  echo ${link/$upload_domain/$user_domain}

  rm -f $tmpfile;

  return 0;
}

alias randpasswd="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1"

function duls {
    paste <( du -hs -- "$@" | cut -f1 ) <( ls -ld -- "$@" ) | sort -hr
}

function del {
    rm -rf "$@"
}
