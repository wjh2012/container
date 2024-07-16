FROM nginx:alpine AS runner
WORKDIR /usr/share/nginx/html

# 기존 배포 파일 삭제
RUN rm -rf ./*
COPY out/ /usr/share/nginx/html/

# Nginx 설정 파일을 복사 (옵션)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 로그 디렉토리 생성
RUN mkdir -p /var/log/nginx

EXPOSE 3100
CMD ["nginx", "-g", "daemon off;"]