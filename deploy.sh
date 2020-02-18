#!/usr/bin/env bash

add_profiled(){
cat <<EOF > /etc/profile.d/telegram-alert.sh
#!/usr/bin/env bash
# Log conexiones
bash $ALERTSCRIPT_PATH
EOF
}

add_zsh () {
cat <<EOF >> /etc/zsh/zshrc
# Log conexiones
bash $ALERTSCRIPT_PATH
EOF
}

ALERTSCRIPT_PATH="/opt/ssh-login-alert-telegram/alert.sh"

echo "Desplegando alertas..."
add_profiled

echo "Checa si ZSH esta instalado."

HAS_ZSH=$(grep -o -m 1 "zsh" /etc/shells)
if [ ! -z $HAS_ZSH ]; then
    echo "ZSH esta instalado, agregando alertas a zshrc"
    add_zsh
else
    echo "Instala zsh. Al parecer no esta instalado"
fi

echo "Terminado!"
