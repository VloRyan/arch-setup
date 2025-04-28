function is_installed() {
    pacman -Q "$1" > /dev/null
    return $?
}

function file_diff() {
    if diff "$1" "$2" > /dev/null; then
      return 1
    fi
    return 0
}

function copy_configs() {
  copied=false
  mkdir -p "$2"
  for FILE in "$1"*; do
    file_name="$(basename -- "$FILE")"
    if [ -f "$2/$file_name" ]; then
        echo "Config found under: $2$file_name"
        if ! file_diff "$FILE" "$2$file_name"; then
          echo "no diff: $2$file_name"
          continue
        fi
        while true; do
            read -rp "Replace (Y/n)? " yn
            case $yn in
                [Yy]* ) replace=true; break;;
                [Nn]* ) replace=false;break;;
                * ) echo "Please answer yes or no.";;
            esac
        done
        if [ "$replace" = false ]; then
          continue
        fi
        cp "$2/$file_name" "$2${file_name}_$(date +%s)"
    fi
    cp "$FILE" "$2$file_name"
    copied=true
  done
  if [ $copied == true ]; then
    return 0
  fi
  return 1
}