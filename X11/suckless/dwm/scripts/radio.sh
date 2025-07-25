#!/bin/bash

echo "Rádios lofi disponíveis:"
echo "1) hip hop radio"
echo "2) jazz radio"
echo "3) medieval radio"
echo "4) summer radio"
echo "5) sleep radio"

read -p "Selecione uma rádio: " opcao

case "$opcao" in
    1) URL="https://www.youtube.com/live/jfKfPfyJRdk?si=fN9JRGcIagPeVLse" ;;
    2) URL="https://www.youtube.com/live/HuFYqnbVbzY?si=yEIsyHNSyPop8O7G" ;;
    3) URL="https://www.youtube.com/live/IxPANmjPaek?si=Nv520_QRsSnlbTjr" ;;
    4) URL="https://www.youtube.com/live/SXySxLgCV-8?si=xLcfIjhpfc-t7bu_" ;;
    5) URL="https://www.youtube.com/live/28KRPhVzCus?si=ApBtLi17gUoYY5Ed" ;;
    *) echo "Opção inválida."; exit 1 ;;
esac

if [ -z "$URL" ]; then
    echo "Erro, nenhuma URL fornecida. Abortando."
    exit 1
fi

echo "Tocando rádio..."
mpv --no-video "$(yt-dlp --get-url "$URL")"
