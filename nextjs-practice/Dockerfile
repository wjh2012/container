FROM nginx:alpine AS runner
WORKDIR /usr/share/nginx/html

# 기존 배포 파일 삭제
RUN rm -rf ./*
COPY out /usr/share/nginx/html

# Nginx 설정 파일을 복사 (옵션)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]