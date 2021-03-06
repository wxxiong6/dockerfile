@echo off

title nginx install

set WEBROOT_DIR=D:/web
set DOCKERFILE_DIR=D:/docker/docker-lnmp
set DOCKER_LOGS_DIR=D:/docker/logs/nginx
set docker_name="wxxiong6/nginx:1.10"

set used=false
for /F "usebackq tokens=1" %%i in (`"docker ps -a|find "nginx""`) do (
    set old_docker_name=%%i
    set used=true
)

 if "%used%"=="true" (
	docker stop %old_docker_name%
	docker rm %old_docker_name%
)


docker run --name nginx  --link php-fpm:php-fpm -p 80:80 -p443:443 -v %WEBROOT_DIR%:/var/www/html -v %dockerfile_dir%/nginx.conf:/etc/nginx/nginx.conf -v %dockerfile_dir%/conf.d:/etc/nginx/conf.d -v %DOCKER_LOGS_DIR%/nginx:/var/log/nginx -d %docker_name%

if %ERRORLEVEL% == 0 (
   echo install success
) ELSE (
   echo install failure
)
pause