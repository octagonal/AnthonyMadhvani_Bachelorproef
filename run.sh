#!/usr/bin/bash

#Run a web server in the background
#ruby -run -e httpd -- -p 5000 . &

#Convert to HTML
pandoc <(cat paper/*.md) -o out/out.html --template template/template.html --css template/flatly.css --self-contained --filter pandoc-citeproc --bibliography "citations.bib" --csl "apa-5th-edition"
#pandoc <(cat paper/*.md) -o out/outpandoc.pdf --toc -V papersize="a4paper" --filter pandoc-citeproc --bibliography "citations.bib"

#Convert to PDF
/opt/wkhtmltox/bin/wkhtmltopdf --header-font-name "Roboto" --header-font-size 9 --footer-font-name "Roboto" --footer-font-size 9  --footer-right "Page [page] of [toPage]" --header-right "[section]" toc --xsl-style-sheet "template/toc_stylesheet.xml" http://localhost:5000/out.html ./out/out.pdf

#Merge paper and cover
#pdfunite Cover.pdf out/outpandoc.pdf out/final.pdf
pdfunite Cover.pdf empty.pdf Cover.pdf out/out.pdf out/final.pdf
