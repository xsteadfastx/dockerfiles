FROM mayanedms/mayanedms

RUN apt-get update \
 && apt-get install tesseract-ocr-deu \
 && rm -rf /var/lib/apt/lists/* \
 && rm -f /var/cache/apt/archives/*.deb
