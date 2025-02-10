cp config/en_PP-OCRv4_rec.yml PaddleOCR/configs/rec/PP-OCRv4/en_PP-OCRv4_rec.yml
cp dict/micr.txt PaddleOCR/ppocr/utils/dict/micr.txt
cp -r pretrain_models PaddleOCR
python3 tools/train.py -c configs/rec/PP-OCRv4/en_PP-OCRv4_rec.yml