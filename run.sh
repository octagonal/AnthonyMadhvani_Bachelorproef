#!/usr/bin/bash
pandoc <(cat paper/*.md) -o out/out.html --template template/template.html --css template/template.css --self-contained

#Formatting html to pdf
/opt/wkhtmltox/bin/wkhtmltopdf --footer-right "Page [page] of [toPage]" --header-right "[section]" cover "Cover.svg" toc http://localhost:5000/out.html ./out/out.pdf

#Formatting html to pdf
/opt/wkhtmltox/bin/wkhtmltopdf --footer-right "Page [page] of [toPage]" --header-right "[section]" cover "Cover.svg" toc http://localhost:5000/out.html ./out/out.pdf
