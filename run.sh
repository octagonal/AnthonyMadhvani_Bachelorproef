#!/usr/bin/bash
pandoc <(cat paper/*.md) -o out/out.html --template template/template.html --css template/template.css --self-contained
pandoc <(cat paper/*.md) -o out/outpandoc.pdf --toc -V papersize="a4paper" mainfont='Alegreya-Regular.otf'

/opt/wkhtmltox/bin/wkhtmltopdf --footer-right "Page [page] of [toPage]" --header-right "[section]" toc --xsl-style-sheet "template/toc_stylesheet.xml" http://localhost:5000/out.html ./out/out.pdf

#pdfunite Cover.pdf out/outpandoc.pdf out/final.pdf

pdfunite Cover.pdf out/out.pdf out/final.pdf
