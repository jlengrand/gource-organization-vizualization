#!/bin/sh

rm -rf *.txt; rm -rf *.txt-r

for OUTPUT in $(ls . | grep adyen)
do
	gource --output-custom-log $OUTPUT.txt $OUTPUT
    sed -i -r "s/\(.*\)|/\1\|\/adyen\/$OUTPUT/" $OUTPUT.txt
done

echo "SORTING"

cat *.txt | sort -n > combined.txt

echo "GOURCING"

gource  -1920x1080 \
        --auto-skip-seconds 1 \
        --seconds-per-day 0.05 \
        --hide usernames \
        --hide files \
        --logo logo.png \
        --logo-offset 900x600 \
        --title "Adyen on GitHub, 2021" \
        --start-date "2021-01-01" \
        --stop-date "2022-01-01" \
        --max-files 100 \
        --highlight-dirs \
        combined.txt \
        -o gource.ppm 

        # --hide users \
        # --background-colour FFFFFF \
        # --bloom-multiplier 2.0 \
        # --bloom-intensity 1.5 \

ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i gource.ppm -vcodec libx264 -preset medium -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 gource.mp4
